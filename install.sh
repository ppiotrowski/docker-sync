#!/bin/bash

# bash -c "$(curl -H 'Cache-Control: no-cache' -s https://raw.githubusercontent.com/ppiotrowski/docker-sync/master/install.sh)"

sudo apt update
sudo apt -y upgrade

sudo apt -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
    
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
   
sudo apt update
sudo apt -y install docker-ce docker-ce-cli containerd.io

sudo ln -s "/mnt/c/Program Files/Docker/Docker/resources/bin/docker.exe" /usr/local/bin/docker

sudo apt -y install docker-compose

sudo ln -s "/mnt/c/Program Files/Docker/Docker/resources/bin/docker-compose.exe" /usr/local/bin/docker-compose

sudo apt -y install ruby ruby-dev
sudo gem install docker-sync

echo "export DOCKER_HOST=tcp://localhost:2375" >> ~/.bashrc

sudo apt -y install build-essential

sudo apt -y install make
wget http://caml.inria.fr/pub/distrib/ocaml-4.08/ocaml-4.08.1.tar.gz
tar xvf ocaml-4.08.1.tar.gz
cd ocaml-4.08.1
./configure
make world
make opt
umask 022
sudo make install
sudo make clean

cd ..
wget https://github.com/bcpierce00/unison/archive/v2.51.2.tar.gz
tar xvf v2.51.2.tar.gz
cd unison-2.51.2
# The implementation src/system.ml does not match the interface system.cmi:curl and needs to be patched
curl https://github.com/bcpierce00/unison/commit/23fa1292.diff?full_index=1 -o patch.diff
git apply patch.diff
make UISTYLE=text
sudo cp src/unison /usr/local/bin/unison
sudo cp src/unison-fsmonitor /usr/local/bin/unison-fsmonitor
#sudo apt -y install unison

sudo mkdir /c
sudo mount --bind /mnt/c /c
echo "sudo mount --bind /mnt/c /c" >> ~/.bashrc && source ~/.bashrc

sudo mkdir /e
sudo mount --bind /mnt/e /e
echo "sudo mount --bind /mnt/e /e" >> ~/.bashrc && source ~/.bashrc

#sungroup ALL=(root) NOPASSWD: /bin/mount
#sungroup ALL=(root) NOPASSWD: /usr/local/bin/docker-sync
sudo visudo

#sudo cat <<EOT >> /etc/wsl.conf
#[automount]
#root = /
#options = "metadata"
#EOT
