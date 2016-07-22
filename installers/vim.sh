sudo apt-get install vim-gnome -y

rm -f ~/.vimrc
CURRENT_DIR="$(pwd)"
ln -s $CURRENT_DIR/vimrc ~/.vimrc

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim +PluginInstall +qall
