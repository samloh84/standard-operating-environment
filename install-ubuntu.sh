#!/bin/bash


# install google_chrome
sudo curl -sSLj -o /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb
sudo rm -rf /tmp/google-chrome-stable_current_amd64.deb

# install sublime
curl -sSLj -o- https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install -y apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install -y sublime-text sublime-merge

# install jetbrains_toolbox
sudo apt-get install -y curl jq
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
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

pyenv latest install
pyenv latest install 2.7
pyenv latest global


# install rvm

rm -rf ${HOME}/.rvm
sudo apt-get install -y gnupg2
gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
[[ -s "${HOME}/.rvm/scripts/rvm" ]] && source "${HOME}/.rvm/scripts/rvm"
rvm install ruby --latest

# install gvm
rm -rf ~/.gvm

curl -sSL https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash

[[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "${HOME}/.gvm/scripts/gvm"

sudo apt-get install -y curl git mercurial make binutils bison gcc build-essential

gvm install go1.4 -B
gvm use go1.4 --default
export GOROOT_BOOTSTRAP=${GOROOT}
LATEST_GO_VERSION="$(gvm listall | grep -o 'go[0-9]\{1,\}\.[0-9]\{1,\}$' | sort --version-sort | tail -n1)"
gvm install "${LATEST_GO_VERSION}" && gvm use "${LATEST_GO_VERSION}"

# install docker
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker ${USER}
sudo systemctl start docker
sudo systemctl enable docker

# install pip
pip install --upgrade pip ansible awscli docker-compose



# install gcp
CLOUD_SDK_REPO="cloud-sdk-$(grep VERSION_CODENAME /etc/os-release | cut -d '=' -f 2)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-cloud-sdk

# install azure
sudo apt-get update
sudo apt-get install curl apt-transport-https lsb-release gnupg
curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor | \
    sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null

AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt-get update
sudo apt-get install azure-cli



# install terraform
sudo apt-get install -y unzip
sudo curl -sSLj -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.12.0/terraform_0.12.0_linux_amd64.zip
sudo unzip -d /opt/terraform /tmp/terraform.zip
sudo rm -rf /tmp/terraform.zip
sudo ln -s /opt/terraform/terraform /bin/terraform

# install packer
sudo apt-get install -y unzip
sudo curl -sSLj -o /tmp/packer.zip https://releases.hashicorp.com/packer/1.4.1/packer_1.4.1_linux_amd64.zip
sudo unzip -d /opt/packer /tmp/packer.zip
sudo rm -rf /tmp/packer.zip
sudo ln -s /opt/packer/packer /bin/packer

# install vault
sudo apt-get install -y unzip
sudo curl -sSLj -o /tmp/vault.zip https://releases.hashicorp.com/vault/1.1.2/vault_1.1.2_linux_amd64.zip
sudo unzip -d /opt/vault /tmp/vault.zip
sudo rm -rf /tmp/vault.zip
sudo ln -s /opt/vault/vault /bin/vault


# install consul
sudo apt-get install -y unzip
sudo curl -sSLj -o /tmp/consul.zip https://releases.hashicorp.com/consul/1.5.1/consul_1.5.1_linux_amd64.zip
sudo unzip -d /opt/consul /tmp/consul.zip
sudo rm -rf /tmp/consul.zip
sudo ln -s /opt/consul/consul /bin/consul


# install vagrant
sudo apt-get install -y unzip
sudo curl -sSLj -o /tmp/vagrant.zip https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_linux_amd64.zip
sudo unzip -d /opt/vagrant /tmp/vagrant.zip
sudo rm -rf /tmp/vagrant.zip
sudo ln -s /opt/vagrant/vagrant /bin/vagrant


# install nomad
sudo apt-get install -y unzip
sudo curl -sSLj -o /tmp/nomad.zip https://releases.hashicorp.com/nomad/0.9.1/nomad_0.9.1_linux_amd64.zip
sudo unzip -d /opt/nomad /tmp/nomad.zip
sudo rm -rf /tmp/nomad.zip
sudo ln -s /opt/nomad/nomad /bin/nomad





# install inspec
sudo curl -sSLj -o /tmp/inspec_4.3.2-1_amd64.deb https://packages.chef.io/files/stable/inspec/4.3.2/ubuntu/18.04/inspec_4.3.2-1_amd64.deb
sudo dpkg -i /tmp/inspec_4.3.2-1_amd64.deb
sudo rm -rf /tmp/inspec_4.3.2-1_amd64.deb



