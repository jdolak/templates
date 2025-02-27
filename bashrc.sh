cat << EOF >> .bashrc
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Custom Shell
PS1="\n\[\033[01;32m\]\h\[\033[00m\]: \[\033[01;34m\]\w\[\033[00m\]\$(parse_git_branch)\n\[\033[01;32m\]\$\[\033[00m\] "

EDITOR=/usr/bin/vim

alias cl='clear'
EOF
