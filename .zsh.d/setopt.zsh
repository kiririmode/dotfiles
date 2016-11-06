### NO_GLOBAL_RCS can force /etc/z* files after /etc/zshenv to be skipped.
setopt no_global_rcs

# Report the status of background jobs immediately, rather than
# waiting until just before printing a prompt.
setopt notify

# Don't push multiple copies of the same directory onto the directory
# stack.
setopt pushd_ignore_dups

# Have pushd with no arguments act like `pushd $HOME'.
setopt pushd_to_home

# This options works like APPEND_HISTORY except that new history lines
# are added to the $HISTFILE incrementally (as soon as they are
# entered),  rather  than waiting until the shell exits.
setopt inc_append_history

# Remove  the  history (fc -l) command from the history list when
# invoked.  Note that the command lingers in the internal history
# until the next command is entered before it vanishes, allowing you
# to briefly reuse or edit the line.
setopt hist_no_store

# Remove function definitions from the history list.
setopt hist_no_functions

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

# When  the last character resulting from a completion is a slash and
# the next character typed is a word delimiter, a slash, or a
# character that ends a command (such as a semicolon or an ampersand),
# remove the slash.
setopt auto_remove_slash

# Print  a carriage return just before printing a prompt in the line
# editor.
setopt no_prompt_cr

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

# Expand expressions in braces which would not otherwise undergo brace
# expansion to a lexically ordered list of all  the  characters.
setopt brace_ccl

# Perform filename generation (globbing).
setopt glob

# Treat  the  `#', `~' and `^' characters as part of patterns for
# filename generation, etc.
setopt extended_glob

# Make globbing (filename generation) sensitive to case.
setopt no_case_glob

# Print eight bit characters literally in completion lists, etc.
setopt print_eight_bit

# Beep on error in ZLE.
setopt no_beep

# Beep on an ambiguous completion.  More accurately, this forces the
# completion widgets to return status 1 on an  ambiguous  completion,
# which  causes  the  shell to beep if the option BEEP is also set;
setopt no_list_beep

# Beep in ZLE when a widget attempts to access a history entry which
# isn't there.
setopt no_hist_beep

# Append a trailing `/' to all directory names resulting from filename
# generation (globbing)
setopt mark_dirs

# Perform a path search even on command names with slashes in them.
setopt path_dirs

# Print  the exit value of programs with non-zero exit status.
setopt print_exit_value

# Print commands and their arguments as they are executed.
setopt no_xtrace

# If  querying  the  user  before executing `rm *' or `rm path/*',
# first wait ten seconds and ignore anything typed in that time.
setopt rm_star_wait

# List jobs in the long format by default.
setopt long_list_jobs
