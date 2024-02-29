# Pytorch-Project-Template

## Todo
- [ ] Create ssh key pair and copy the public key to ssh-key.pub
- [ ] Change the password in the Dockerfile
- [ ] Add necessary apt packages to the Dockerfile
- [ ] Add necessary pip packages to the requirements.txt
- [ ] Test container build and run by running `make ssh` (works on linux, send feedback for windows)

## SSH connection
```
ssh -v -i <private_key> -o IdentitiesOnly=yes -p 2200  root@<hostname>
```
