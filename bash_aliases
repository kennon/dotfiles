##
# global aliases
# put local aliases in .bash_aliases.local
alias ta="tmux attach"

gpg_ownertrust() {
  echo "$( \
    gpg --list-keys --fingerprint | \
    grep $1 -A 1 | tail -1 | \
    tr -d '[:space:]' | cut -f2 -d'=' \
  ):6:"
}

# load local aliases
if [ -f ~/.bash_aliases.local ]; then source ~/.bash_aliases.local; fi

