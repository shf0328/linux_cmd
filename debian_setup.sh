#!/bin/bash

sudo apt-get update

# SSH config
sudo apt-get install -y openssh-server
ssh-keygen -t rsa -b 4096
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
sudo sed -i '/Port /c Port 23' /etc/ssh/sshd_config
sudo sed -i '/ListenAddress 0.0.0.0/c ListenAddress 0.0.0.0' /etc/ssh/sshd_config
sudo sed -i '/PermitRootLogin /c PermitRootLogin no' /etc/ssh/sshd_config
sudo sed -i '/PasswordAuthentication yes/c PasswordAuthentication no' /etc/ssh/sshd_config
sudo sed -i '/AuthorizedKeysFile/c AuthorizedKeysFile     .ssh/authorized_keys' /etc/ssh/sshd_config
sudo service ssh restart

# Install ZSH
sudo apt-get install -y zsh
echo "change default shell to ZSH"
chsh -s $(which zsh)

# Restart connection to use OMZ
sudo apt-get install -y git
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Install conda
sudo apt-get install -y ca-certificates
sudo apt-get install -y bzip2
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh
echo "source miniconda3/etc/profile.d/conda.sh" >> .zshrc
