host_ssh_port=2200
image_name=your_container_name 
container_name=your_container_name 
data_path=/mnt/hdd2/se
artifact_path=/mnt/hdd2/kandras/your_artifacts

build:
	docker build --tag $(image_name) .

push:
	docker push $(image_name) 

pull:
	docker pull $(image_name) 

stop:
	docker stop $(container_name)

rm: stop
	docker rm $(container_name)

ssh: build
	nvidia-docker run \
	-dt \
	--restart unless-stopped \
	--shm-size 16G \
	-p $(host_ssh_port):22 \
	-e NVIDIA_VISIBLE_DEVICES=0 \
	--name $(container_name) \
	-v $(shell pwd):/workspace \
	-v $(data_path):/data/se:ro \
	-v $(artifact_path):/artifacts \
	$(image_name) \
	/usr/sbin/sshd -D

