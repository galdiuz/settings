sudo apt-get install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rm -f ~/.zshrc
CURRENT_DIR="$(pwd)"
ln -s $CURRENT_DIR/zshrc ~/.zshrc
