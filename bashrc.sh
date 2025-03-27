cat << EOF >> .bashrc
show_git_branch() {
  git rev-parse --abbrev-ref HEAD 2> /dev/null
}

# Custom Shell
PS1="\n\[\033[01;32m\]\h\[\033[00m\]: \[\033[01;34m\]\w\[\033[00m\] (\$(show_git_branch)) \n\[\033[01;32m\]$\[\033[00m\] "

EDITOR=/usr/bin/vim

alias cl='clear'
EOF
