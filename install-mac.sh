#!/bin/bash

HOMEBREW_GITHUB_API_TOKEN=${HOMEBREW_GITHUB_API_TOKEN:-}

command_exists () {
    type "$1" &> /dev/null ;
}

xcode-select --install 2>&1 | grep -q "installed"
if [[ ! $? -eq 0 ]]; then
xcode-select --install
fi


if ! command_exists brew; then
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [[ -z "${HOMEBREW_GITHUB_API_TOKEN}" ]]; then
echo "Please setup a GitHub personal access token at https://github.com/settings/tokens, then set the HOMEBREW_GITHUB_API_TOKEN environment variable with your token."
exit 1
fi


brew tap Caskroom/cask

brew tap weaveworks/tap

brew install gpg

brew install \
curl \
dockutil \
docker-compose  \
docker-machine \
docker-credential-helper \
git \
maven \
mongodb \
mysql \
nmap \
nvm \
packer \
postgresql \
python \
python3 \
redis \
tmux \
unrar \
wget


brew cask install \
apache-directory-studio \
appcode  \
automake \
clion  \
datagrip  \
filezilla \
firefox \
google-chrome \
intellij-idea \
java  \
mysqlworkbench \
pgadmin4 \
phpstorm  \
pycharm  \
rdm \
robomongo \
rubymine  \
sourcetree \
sublime-text \
telegram  \
tunnelblick \
vagrant \
virtualbox \
virtualbox-extension-pack \
webstorm  \
whatsapp \
xnviewmp \
google-cloud-sdk \
awscli

brew install \
homebrew/completions/docker-compose-completion \
homebrew/completions/docker-machine-completion \
homebrew/completions/packer-completion \
homebrew/completions/vagrant-completion \
homebrew/completions/git-completion \
homebrew/completions/maven-completion \
homebrew/php/php56

brew install weaveworks/tap/eksctl

if ! command_exists rvm; then
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
fi

if ! command_exists virtualenv; then
pip install virtualenv
fi

# brew install \
# dropbox \
# spotify \


dockutil --remove all
dockutil --add /Applications/Launchpad.app
dockutil --add /Applications/Google\ Chrome.app
dockutil --add /Applications/Sublime\ Text.app
dockutil --add /Applications/IntelliJ\ IDEA.app
dockutil --add /Applications/SourceTree.app
dockutil --add /Applications/FileZilla.app
dockutil --add /Applications/VirtualBox.app
dockutil --add /Applications/Utilities/Terminal.app
dockutil --add /Applications/System\ Preferences.app
dockutil --add /Applications/Utilities/Activity\ Monitor.app