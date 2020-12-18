#!/bin/sh

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Greetings. Preparing to power up and begin diagnostics.$(tput sgr 0)"
echo "---------------------------------------------------------"

INSTALLDIR=$PWD

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Checking for Homebrew installation.$(tput sgr 0)"
echo "---------------------------------------------------------"
brew="/usr/local/bin/brew"
if [ -f "$brew" ]
then
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2)Gon: Homebrew is installed.$(tput sgr 0)"
  echo "---------------------------------------------------------"
else
  echo "--------------------------------------------------------"
  echo "$(tput setaf 3)Gon: Installing Homebrew. Homebrew requires osx command lines tools, please download xcode first$(tput sgr 0)"
  echo "---------------------------------------------------------"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Installing system packages.$(tput sgr 0)"
echo "---------------------------------------------------------"

packages=(
  "git"
  "node"
  "watchman"
  "ruby"
  "tmux"
  "neovim"
  "python3"
  "zsh"
  "ripgrep"
  "fzf"
  "z"
  "lf"
  "thefuck"
  "go"
  "gcc"
  "fortune"
  "cowsay"
  "--HEAD wvanlint/twf/twf"
)

for i in "${packages[@]}"
do
  brew install $i
  echo "---------------------------------------------------------"
done

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing twf.$(tput sgr 0)"
echo "---------------------------------------------------------"
go get -u github.com/wvanlint/twf/cmd/twf
echo "---------------------------------------------------------"

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Installing adoptopenjdk8.$(tput sgr 0)"
echo "---------------------------------------------------------"
brew tap AdoptOpenJDK/openjdk
brew cask install adoptopenjdk8

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Installing Python NeoVim client.$(tput sgr 0)"
echo "---------------------------------------------------------"

pip3 install neovim
pip3 install neovim-remote

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Installing yarn$(tput sgr 0)"
echo "---------------------------------------------------------"

npm install -g yarn

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Installing node neovim package$(tput sgr 0)"
echo "---------------------------------------------------------"

npm install -g neovim

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Installing spaceship prompt$(tput sgr 0)"
echo "---------------------------------------------------------"

npm install -g spaceship-prompt

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Installing vim linter (vint)$(tput sgr 0)"
echo "---------------------------------------------------------"

pip3 install vim-vint

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Installing bash language server$(tput sgr 0)"
echo "---------------------------------------------------------"

npm i -g bash-language-server

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Installing gem pakcages$(tput sgr 0)"
echo "---------------------------------------------------------"

gemPackages=(
  "colorls"
  "neovim"
  "environment"
  "cocoapods"
  "iStats"
  "lolcat"
)

for i in "${gemPackages[@]}"
do
  sudo gem install $i
  echo "---------------------------------------------------------"
done

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Installing system fonts.$(tput sgr 0)"
echo "---------------------------------------------------------"

brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font
brew cask install font-hasklig-nerd-font
brew cask install font-fira-code
brew cask install font-firacode-nerd-font

localGit="/usr/local/bin/git"
if ! [[ -f "$localGit" ]]; then
  echo "---------------------------------------------------------"
  echo "$(tput setaf 1)Gon: Invalid git installation. Aborting. Please install git.$(tput sgr 0)"
  echo "---------------------------------------------------------"
  exit 1
fi


echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Installing oh-my-zsh.$(tput sgr 0)"
echo "---------------------------------------------------------"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2)Gon: oh-my-zsh already installed.$(tput sgr 0)"
  echo "---------------------------------------------------------"
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Installing zsh-autosuggestions.$(tput sgr 0)"
echo "---------------------------------------------------------"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions


echo "---------------------------------------------------------"
echo "$(tput setaf 2)insert .zshrc file into zshenv.$(tput sgr 0)"
echo "---------------------------------------------------------"
# cp ./shell/.zshenv ~/.
echo "ZDOTDIR=~/.config/shell" >> ~/.zshenv

echo "---------------------------------------------------------"
echo "$(tput setaf 2)installing zsh powerdk.$(tput sgr 0)"
echo "---------------------------------------------------------"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

echo "---------------------------------------------------------"
echo "$(tput setaf 2)installing zsh highlighting.$(tput sgr 0)"
echo "---------------------------------------------------------"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Installing zsh plugins...$(tput sgr 0)"
echo "---------------------------------------------------------"

cd ~/.oh-my-zsh/custom/plugins
zshplugins=(
  "https://github.com/zsh-users/zsh-syntax-highlighting.git" 
  "https://github.com/djui/alias-tips.git"
  "https://github.com/lukechilds/zsh-better-npm-completion.git"
  "https://github.com/zsh-users/zsh-completions.git"
  "https://github.com/zsh-users/zsh-autosuggestions.git"
)
for i in "${zshplugins[@]}"
do
  git clone $i
  echo "---------------------------------------------------------"
done


echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Switching shell to zsh. You may need to logout.$(tput sgr 0)"
echo "---------------------------------------------------------"

sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Installing tmux plugin manager.$(tput sgr 0)"
echo "---------------------------------------------------------"

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Copying tmux.$(tput sgr 0)"
echo "---------------------------------------------------------"
cp ./.tmux.conf ~/.

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: Installing vtop.$(tput sgr 0)"
echo "---------------------------------------------------------"
npm install -g vtop

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Gon: System update complete. Currently running at 100% power. Enjoy.$(tput sgr 0)"
echo "---------------------------------------------------------"

exit 0

