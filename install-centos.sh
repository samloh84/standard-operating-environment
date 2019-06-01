#!/bin/bash

# install google_chrome
sudo yum install -y https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

# install sublime
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo yum config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo yum install -y sublime-text sublime-merge


# install jetbrains_toolbox
sudo yum install -y curl jq
JETBRAINS_TOOLBOX_URL=$(curl -sSLj -o- "https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release&build=" | jq --raw-output ".TBA[0].downloads.linux.link")
sudo curl -sSLj -o /tmp/jetbrains-toolbox.tar.gz ${JETBRAINS_TOOLBOX_URL}
sudo mkdir -p /opt/jetbrains-toolbox
sudo tar -C /opt/jetbrains-toolbox -xzf /tmp/jetbrains-toolbox.tar.gz --strip-components=1
sudo rm -rf /tmp/jetbrains-toolbox.tar.gz
/opt/jetbrains-toolbox/jetbrains-toolbox

# install nvm
rm -rf ${HOME}/.nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
[[ -s "${HOME}/.nvm/nvm.sh" ]] && source "${HOME}/.nvm/nvm.sh"
nvm install node


# install pyenv
rm -rf ${HOME}/.pyenv

curl https://pyenv.run | bash

echo -e "PATH=\"\${HOME}/.pyenv/bin:\${PATH}\"\neval \"\$(pyenv init -)\"\neval \"\$(pyenv virtualenv-init -)\"" >> ~/.bashrc
git clone https://github.com/momo-lab/xxenv-latest.git "$(pyenv root)"/plugins/xxenv-latest

# https://github.com/pyenv/pyenv/wiki/Common-build-problems
sudo yum install -y zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel xz xz-devel libffi-devel findutils

pyenv latest install
pyenv latest install 2.7
pyenv latest global


# install rvm
rm -rf ${HOME}/.rvm
gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
[[ -s "${HOME}/.rvm/scripts/rvm" ]] && source "${HOME}/.rvm/scripts/rvm"
rvm install ruby --latest


# install gvm
rm -rf ~/.gvm

bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
[[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "${HOME}/.gvm/scripts/gvm"

sudo yum install -y curl git make bison gcc glibc-devel

gvm install go1.4 -B
gvm use go1.4 --default
export GOROOT_BOOTSTRAP=${GOROOT}
gvm install go1.12.2


# install docker
sudo yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine
sudo yum -y install yum-plugins-core

sudo yum config-manager \
--add-repo \
https://download.docker.com/linux/fedora/docker-ce.repo

sudo yum install -y docker-ce
sudo usermod -aG docker ${USER}
sudo systemctl start docker
sudo systemctl enable docker

# install pip
pip install --upgrade pip ansible awscli docker-compose