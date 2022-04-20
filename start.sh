#!/bin/bash -e

uname=$(uname);
case "$uname" in
    (*Linux*) installCMD='apt-get'; ;;
    (*Darwin*) installCMD='brew'; ;;
    (*CYGWIN*) openCmd='cygstart'; ;;
    (*) echo 'error: unsupported platform.'; exit 2; ;;
esac;

$installCMD install tmux vim

### Config Vim
echo "Config Vim ..."
if [ ! -d "~/.vim_runtime" ]; then
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
fi
sh ~/.vim_runtime/install_awesome_vimrc.sh
cp vim/my_configs.vim ~/.vim_runtime/

### Config Tmux
echo "Config Tmux ..."
cp tmux/.tmux.conf ~/
tmux source-file ~/.tmux.conf


