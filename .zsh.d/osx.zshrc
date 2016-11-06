### -*- mode: shell-script -*-
###
### osx.zshrc
###

### z configuration

# datafile
export _Z_DATA=$HOME/.z
# if not exist, create it
if [[ ! -f "$_Z_DATA" ]]; then
    touch $_Z_DATA
fi

. $(brew --prefix)/etc/profile.d/z.sh

### zsh-syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
