##
# global aliases
# put local aliases in .bash_aliases.local
alias tt="tt++ ~/.durisrc"
alias ta="tmux attach"

# load local aliases
if [ -f ~/.bash_aliases.local ]; then source ~/.bash_aliases.local; fi
