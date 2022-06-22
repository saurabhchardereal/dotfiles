# History
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=1000                   # History loaded into memory
SAVEHIST=2000                   # Max commands to save in $HISTFILE
setopt share_history            # Share history across terminals
setopt inc_append_history       # Immediately append to the history file, not just when a term is killed
setopt hist_expire_dups_first   # Trim duplicate entries first
setopt hist_find_no_dups        # Don't show repeated commands
setopt hist_ignore_all_dups     # Removes older entry if it dublicates the current
setopt hist_ignore_dups         # Ignore current command if previously entered
