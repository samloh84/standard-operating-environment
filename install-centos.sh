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


# install gcp
echo -e "[google-cloud-sdk]\nname=Google Cloud SDK\nbaseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg\n       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg" | sudo tee /etc/yum.repos.d/google-cloud-sdk.repo
sudo yum install -y google-cloud-sdk

# install azure
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
sudo yum install -y azure-cli

# install terraform
sudo yum install -y unzip
sudo curl -sSLj -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.12.0/terraform_0.12.0_linux_amd64.zip
sudo unzip -d /opt/terraform /tmp/terraform.zip
sudo rm -rf /tmp/terraform.zip
sudo ln -s /opt/terraform/terraform /bin/terraform

# install packer
sudo yum install -y unzip
sudo curl -sSLj -o /tmp/packer.zip https://releases.hashicorp.com/packer/1.4.1/packer_1.4.1_linux_amd64.zip
sudo unzip -d /opt/packer /tmp/packer.zip
sudo rm -rf /tmp/packer.zip
sudo ln -s /opt/packer/packer /bin/packer

# install vault
sudo yum install -y unzip
sudo curl -sSLj -o /tmp/vault.zip https://releases.hashicorp.com/vault/1.1.2/vault_1.1.2_linux_amd64.zip
sudo unzip -d /opt/vault /tmp/vault.zip
sudo rm -rf /tmp/vault.zip
sudo ln -s /opt/vault/vault /bin/vault


# install consul
sudo yum install -y unzip
sudo curl -sSLj -o /tmp/consul.zip https://releases.hashicorp.com/consul/1.5.1/consul_1.5.1_linux_amd64.zip
sudo unzip -d /opt/consul /tmp/consul.zip
sudo rm -rf /tmp/consul.zip
sudo ln -s /opt/consul/consul /bin/consul


# install vagrant
sudo yum install -y unzip
sudo curl -sSLj -o /tmp/vagrant.zip https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_linux_amd64.zip
sudo unzip -d /opt/vagrant /tmp/vagrant.zip
sudo rm -rf /tmp/vagrant.zip
sudo ln -s /opt/vagrant/vagrant /bin/vagrant


# install nomad
sudo yum install -y unzip
sudo curl -sSLj -o /tmp/nomad.zip https://releases.hashicorp.com/nomad/0.9.1/nomad_0.9.1_linux_amd64.zip
sudo unzip -d /opt/nomad /tmp/nomad.zip
sudo rm -rf /tmp/nomad.zip
sudo ln -s /opt/nomad/nomad /bin/nomad


# install inspec
sudo yum install -y https://packages.chef.io/files/stable/inspec/4.3.2/el/7/inspec-4.3.2-1.el7.x86_64.rpm

