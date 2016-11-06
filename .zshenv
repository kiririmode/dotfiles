##
## .zshenv
##

if [[ -z "$DOTPATH" ]]; then
    function directory() {
        if [[ $# == 0 ]]; then
            return 1
        fi

        local file cwd result

        file="$1"
        cd "$(dirname "$file")"
        # physical current working directory (all symbolic links resolved).
        cwd="$(pwd -P)"

        echo "${cwd}"
    }
    dotpath="$(directory "$0")"
    export DOTPATH=$dotpath
fi

# import common functions
. $DOTPATH/etc/lib/vital.sh

### NO_GLOBAL_RCS can force /etc/z* files after /etc/zshenv to be skipped.
setopt no_global_rcs

# typeset:
#   -g: The -g (global) means that any resulting parameter will not be
#       restricted to local scope.
#   -x: Mark  for  automatic  export  to the environment of
#       subsequently executed commands.
#   -U: For  arrays (but not for associative arrays), keep only the
#       first occurrence of each duplicated value.
typeset -gx -U path cdpath fpath manpath


### autoload

# Push the buffer onto the buffer stack, and execute the command
# `run-help cmd', where cmd is the current command.
#   Key: ESC-h
autoload -Uz run-help

# The shell function add-zsh-hook provides a simple way of adding or
# removing functions from the array.
# hook is one of chpwd, periodic, precmd, preexec, zshaddhistory,
# zshexit, or zsh_directory_name, the special functions in question.
autoload -Uz add-zsh-hook

# This function  initializes  several associative arrays to map color
# names to (and from) the ANSI standard eight-color terminal codes.
# These are used by the prompt theme system.  You seldom should need
# to run colors more than once.
autoload -Uz colors && colors
autoload -Uz compinit && compinit -u

# Perform  a  greater-than-or-equal-to  comparison of two strings
# having the format of a zsh version number; that is, a string of
# numbers and text with segments separated by dots or dashes.  If the
# present string is not provided, $ZSH_VERSION is used.
autoload -Uz is-at-least

### zsh

# Report the status of background jobs immediately, rather than
# waiting until just before printing a prompt.
setopt notify

# Don't push multiple copies of the same directory onto the directory
# stack.
setopt pushd_ignore_dups

# If  this is set, zsh sessions will append their history list to the
# history file, rather than replace it. Thus, multiple parallel zsh
# sessions will all have the new entries from their history lists
# added to the history file, in the order that they exit.
setopt append_history

# Save each command's beginning timestamp (in seconds since the epoch)
# and the duration (in seconds) to the  history  file.
setopt extended_history

# When searching for history entries in the line editor, do not
# display duplicates of a line previously found, even if the
# duplicates are not contiguous.
setopt hist_find_no_dups

# Remove command lines from the history list when the first character
# on the line is a space, or when one of the expanded aliases contains
# a leading space.
setopt hist_ignore_space

# Remove superfluous blanks from each command line being added to the
# history list.
setopt hist_reduce_blanks

# Whenever the user enters a line with history expansion, don't
# execute the line directly; instead, perform history expansion and
# reload the line into the editing buffer.
setopt hist_verify

# This option both imports new commands from the history file, and
# also causes your typed commands to be appended to the  history file.
setopt share_history

# Make the echo builtin compatible with the BSD echo(1) command.  This
# disables backslashed  escape  sequences  in  echo  strings unless
# the -e option is specified.
setopt bsd_echo

# Remove any right prompt from display when accepting a command line.
setopt transient_rprompt

# If  set,  parameter  expansion,  command  substitution and
# arithmetic expansion are performed in prompts.
setopt prompt_subst

# Allow comments even in interactive shells.
setopt interactive_comments

# Automatically list choices on an ambiguous completion.
setopt auto_list

# Automatically  use  menu  completion  after  the second consecutive
# request for completion, for example by pressing the tab key
# repeatedly.
setopt auto_menu

# If a parameter name was completed and a following character
# (normally a space) automatically inserted, and the  next  character
# typed  is  one  of  those that have to come directly after the name
# (like `}', `:', etc.), the automatically added character is deleted,
# so that the character typed comes immediately after the parameter
# name.
setopt auto_param_keys

# If a parameter is completed whose content is the name of a
# directory, then add a trailing slash instead of a space.
setopt auto_param_slash

# When listing files that are possible completions, show the type of
# each file with a trailing identifying mark.
setopt list_types

# If unset, key functions that list completions try to return to the
# last prompt if given a numeric argument.
setopt always_last_prompt

# All  unquoted  arguments  of  the form `anything=expression'
# appearing after the command name have filename expansion (that is,
# where expression has a leading `~' or `=') performed on expression
# as if it were a parameter assignment.
setopt magic_equal_subst

# Perform filename generation (globbing).
setopt glob

# Treat  the  `#', `~' and `^' characters as part of patterns for
# filename generation, etc.
setopt extended_glob

# If set, is treated as a pattern during spelling correction.  Any
# potential correction that matches the pattern is ignored.
export CORRECT_IGNORE='_*'

# If  set, is treated as a pattern during spelling correction of
# file names.  Any file name that matches the pattern is never offered
# as a correction.
export CORRECT_IGNORE_FILE='.*'

# The  maximum  number of events stored in the internal history list.
export HISTSIZE=10000

# The file to save the history in when an interactive shell exits.  If
# unset, the history is not saved.
export HISTFILE=~/.zsh_history

# The maximum number of history events to save in the history file.
export SAVEHIST=1000000

# Do not add in root
if [[ $UID == 0 ]]; then
    unset HISTFILE
    export SAVEHIST=0
fi

# In the line editor, the number of matches to list without asking
# first.
export LISTMAX=50

# If nonnegative, commands whose combined user and system execution
# times (measured in seconds) are greater than this value have timing
# statistics printed for them.
export REPORTTIME=5

### Language
export LANGUAGE="ja_JP.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="{LANGUAGE}"

### Editor
export EDITOR=emacsclient
export SVN_EDITOR=${EDITOR}
export GIT_EDITOR=${EDITOR}

### PAGER

export PAGER=less
# --RAW-CONTROL-CHARS:
#   Like  -r, but only ANSI "color" escape sequences are output in
#   "raw" form.  Unlike -r, the screen appearance is maintained
#   correctly in most cases.
# --force:
#   Forces  non-regular  files  to  be  opened.  (A non-regular file
#   is a directory or a device special file.)
# --no-init
#   Disables  sending  the termcap initialization and deinitialization
#   strings to the terminal.
# --ignore-case:
#   Causes searches to ignore case; that is, uppercase and lowercase
#   are considered identical.
export LESS='--RAW-CONTROL-CHARS --force --no-init --ignore-case'
# Selects a predefined character set.
export LESSCHARSET='utf-8'
# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;44;37m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

### ls

# ls command colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

### settings for golang
export GOPATH=$HOME

### Path settings
path=(
    $HOME/.plenv/bin(N-/)
    $HOME/.pyenv/bin(N-/)
    $HOME/.rbenv/bin(N-/)
    $GOPATH/bin(N-/)
    $path
)

manpath=(
    $manpath
)

### xenv settings
for xenv in pyenv plenv rbenv; do
    if (( $+commands[$xenv] )); then
        path=($($xenv root)/shims $path)
        eval "$(SHELL=zsh $xenv init - --no-rehash)"
    fi
done

### os dependent settings
case "$(get_os)" in
    mac)
        source $HOME/.zsh.d/mac.zshenv
        ;;
esac
