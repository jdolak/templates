# Jachob's Template Scripts

These are a collection dotfiles and automation scripts that I find myself using alot.  
Each file is set up to be run as a shell script and will create the file or append its contents to the existing one.

For example:  
```sh
curl https://raw.githubusercontent.com/jdolak/templates/refs/heads/main/bashrc.sh | sh
```

### directories.sh

`directories.sh` is special and will create a directory structure, necessary file and Makefile for the language passed as an argument.

For example:  
```sh
curl https://raw.githubusercontent.com/jdolak/templates/refs/heads/main/directories.sh | CREATE=py,docker sh
```
The options for `CREATE` are currently `c`, `py`, and `docker`. Multiple arguments can be specified and it will create the appropriate directories for both and append the Makefile.
