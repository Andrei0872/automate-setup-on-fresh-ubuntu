#!/bin/bash

# could be invoked as `bash install $HOME`

if [ "$#" == 0 ] 
then
  echo "must provide the user's home"
  exit
fi

# we need the user's home directory in order to easily install and configure zsh
users_home=$1

# we need to add the user to `docker` group
user=${users_home##*/}

# note: the order matters

function format_output {
  echo -e "\e[1;42m $1 \e[m";
}

function installVim {
  format_output "installing vim"

  sudo apt install -y vim

  sudo chmod 666 /etc/vim/vimrc

  sudo echo "set tabstop=2" >> /etc/vim/vimrc

  echo
}

function installGit {
  format_output "installing git"

  sudo apt install -y git

  echo
}

function installZsh {
  format_output "installing zsh"

  sudo apt install -y zsh

  sudo apt-get install -y powerline fonts-powerline

  git clone https://github.com/robbyrussell/oh-my-zsh.git "$users_home"/.oh-my-zsh

  cp "$users_home"/.oh-my-zsh/templates/zshrc.zsh-template "$users_home"/.zshrc

  chsh -s /bin/zsh

  syntax highlighting

  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$users_home/.zsh-syntax-highlighting" --depth 1

  echo "source $users_home/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$users_home/.zshrc"

  echo  
}

function installChrome {
  format_output "installing chrome"

  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

  sudo apt install ./google-chrome-stable_current_amd64.deb

  rm -rf ./google-chrome-stable_current_amd64.deb

  echo
}

function installVsCode {
  format_output "installing VS Code"

  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -

  sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

  sudo apt update

  sudo apt install -y code

  echo
}

function installGolang {
  format_output "installing golang"

  cd /tmp

  # ! might need to manually update this
  wget https://dl.google.com/go/go1.15.1.linux-amd64.tar.gz

  sudo tar -xvf go1.15.1.linux-amd64.tar.gz

  sudo mv go /usr/local

  cat >> "$users_home/.zshrc" <<EOL
  export GOROOT=/usr/local/go
  export GOPATH=$HOME/go
EOL

  echo "export PATH=$GOPATH/bin:$GOROOT/bin:$PATH" >> "$users_home/.zshrc"
  
  echo
}

function installCurl {
  format_output "installing curl"
  
  sudo apt install -y curl

  echo
}


function installDocker {
  format_output "installing docker"

  curl -s https://get.docker.com/ | bash

  usermod -aG docker $user

  su - $user

  echo
}

function installNode {
  format_output "installing nodejs"
  
  curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

  sudo apt-get install -y nodejs

  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get update && sudo apt-get install -y yarn

  echo
}

function installSlack {
  format_output "installing slack"
  
  wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.2-amd64.deb


  sudo apt install -y ./slack-desktop-*.deb

  echo
}

function installPostman {
  format_output "installing postman"
  
  sudo snap install postman

  echo
}

function installBrave {
  format_output "installing brave browser"

  sudo apt -y install curl software-properties-common apt-transport-https 

  curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

  echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

  sudo apt update

  sudo apt install -y brave-browser

  echo
}

function installGimp {
  format_output "installing gimp"
  
  sudo snap install gimp

  echo
}

functions="$(cat $0 | egrep -o install[A-Z]+[A-Za-z]+)"
for f in $functions; do $f;done