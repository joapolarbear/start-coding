#!/bin/bash -e

uname=$(uname);
case "$uname" in
    (*Linux*) installCMD='apt-get'; ;;
    (*Darwin*) installCMD='brew'; ;;
    (*CYGWIN*) openCmd='cygstart'; ;;
    (*) echo 'error: unsupported platform.'; exit 2; ;;
esac;

PROMPT() {
    local str="$1"
    echo -e "\e[1;34m$str\e[0m"  # Using bold blue for a lighter effect
}

usrname=$(whoami)
if [ $usrname != "root" ]; then
    sudo_prefix="sudo"
else
    sudo_prefix=""
fi
$sudo_prefix $installCMD update && $sudo_prefix $installCMD install -y vim git wget tmux zsh vim-gtk

### Config Vim
PROMPT "Config Vim ..."
if [ ! -d "~/.vim_runtime" ]; then
    # git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    cp -r 3rdparty/vimrc ~/.vim_runtime
fi
sh ~/.vim_runtime/install_awesome_vimrc.sh
cp vim/my_configs.vim ~/.vim_runtime/

### Config Tmux
PROMPT "Config Tmux ..."
cp tmux/.tmux.conf ~/
tmux source-file ~/.tmux.conf

### Config On-my-zsh
print_blue "Config On-my-zsh"
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

### Using 'rm -rf' safely
alias rm='rm -i'
