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

### path settings
path=(
    $(brew --prefix coreutils)/libexec/gnubin(N-/)
    $(brew --prefix findutils)/libexec/gnubin(N-/)
    $path
)

### less setting
# Command line to invoke the (optional) input-preprocessor.
export LESSOPEN="| $(brew --prefix source-highlight)/bin/src-hilite-lesspipe.sh %s"
