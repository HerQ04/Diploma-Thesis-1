FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-runtime

RUN apt-get update -y && apt-get install -y --no-install-recommends \
    tmux \
    nano \
    htop \
    wget \
    curl \
    git \
    libsm6 \        
    libxrender1 \  
    libfontconfig1 \ 
    ffmpeg \
    libxext6 \
    openssh-server \
    cmake \
    libncurses5-dev \
    libncursesw5-dev \
    build-essential

RUN echo 'PermitRootLogin prohibit-password\nPasswordAuthentication no\nSubsystem sftp internal-sftp\nX11Forwarding yes\nX11UseLocalhost no\nAllowTcpForwarding yes' > /etc/ssh/sshd_config
EXPOSE 22
RUN groupadd sshgroup
RUN mkdir /var/run/sshd
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh
COPY ssh-key.pub /root/.ssh
RUN cat /root/.ssh/ssh-key.pub >> /root/.ssh/authorized_keys
RUN echo 'PATH=$PATH:/opt/conda/bin' >> ~/.bashrc # somehow conda is missing from PATH if login via ssh

# Change this to your password!
RUN echo 'root:radiator' | chpasswd  

# Force bash color prompt
RUN sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' ~/.bashrc

# Install nvtop
RUN git clone https://github.com/Syllo/nvtop.git -b 3.0.1 ~/nvtop
RUN mkdir -p ~/nvtop/build
RUN cd ~/nvtop/build && cmake .. -DNVIDIA_SUPPORT=ON -DAMDGPU_SUPPORT=OFF -DINTEL_SUPPORT=OFF
RUN cd ~/nvtop/build && make
RUN cd ~/nvtop/build && make install

# Set up conda and requirements
RUN ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh \n" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc
SHELL ["conda", "run", "-n", "base", "/bin/bash", "-c"]

COPY requirements.txt /workspace
COPY Dataset.ipynb /workspace
RUN ["conda", "run", "-n", "base", "pip", "install", "-r", "/workspace/requirements.txt"]

WORKDIR /workspace

CMD ["/bin/bash"]
