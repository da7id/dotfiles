#!/bin/sh

[ "$1" = "-h" ] && {
cat <<EOF
Usage:
$0      -- Deploy files but do not overwrite any existing dotfiles
$0 -f   -- Deploy files and overwrite any existing dotfile
$0 -s   -- Deploy files, save and replace any existing dotfile

EOF
exit 3
}

link_dotfile() {
  /bin/echo -n "$2: "
  if [ -e "$2" ]; then
    /bin/echo -n "present, "
    if [ -L "$2" ]; then
      /bin/echo -n "is a symlink, "
    else
      /bin/echo -n "is not a symlink, "
    fi
    if [ "$3" = "-f" ]; then
      /bin/echo "forcibly re-linking."
      rm -f "$2"
      ln -s ~/textfiles/dotfiles/$1 $2
    else
      if [ "$3" = "" ]; then
        /bin/echo "not relinked."
      else
      if [ -L "$2" ]; then
        /bin/echo "forcibly re-linking."
        rm -f "$2"
      else
        /bin/echo "saving as \"$2.save\" and re-linking."
        mv "$2" "$2.save"
      fi
        ln -s ~/textfiles/dotfiles/$1 $2
      fi
    fi
  else
    /bin/echo does not exist, linking.
    ln -s ~/textfiles/dotfiles/$1 $2
  fi
}

link_dotfile dircolors ~/.dircolors $*
link_dotfile bash_profile ~/.bashrc $*
link_dotfile bash_profile ~/.bash_profile $*
link_dotfile tmux.conf ~/.tmux.conf $*

#Vim setup
link_dotfile vimrc ~/.vimrc $*
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
