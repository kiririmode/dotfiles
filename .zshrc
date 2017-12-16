###
### .zshrc
###

umask 022

# Maximum size of a core dump.
limit coredumpsize 0

# Delete all existing keymaps and reset to the default state.
bindkey -d
# Selects  keymap  `emacs'  for  any  operations  by  the  current
# command, and also links `emacs' to `main' so that it is selected by
# default the next time the editor starts.
bindkey -e


# setting of DOTPATH
if [[ -f $HOME/.path ]]; then
    source $HOME/.path
fi

# import common functions
export VITAL_PATH="$DOTPATH/etc/lib/vital.sh"
if [[ -f "$VITAL_PATH" ]]; then
    source "$VITAL_PATH"
fi

# run zsh configuration scripts
for conf in $HOME/.zsh.d/*.zsh; do
    source $conf
done

# run os dependent zsh configuration scripts
if [[ -r $HOME/.zsh.d/$(get_os).zshrc ]]; then
    source $HOME/.zsh.d/$(get_os).zshrc
fi

### liquid prompt settings: https://github.com/nojhan/liquidprompt

# Only load Liquid Prompt in interactive shells, not from a script or
# from scp
if is_interactive; then
    source $DOTPATH/etc/init/submodules/zsh/liquidprompt/liquidprompt
fi

function pe() {
    ack "$@" . | peco --exec 'awk -F : '"'"'{print "+" $2 " " $1}'"'"' | xargs less -N '
}
