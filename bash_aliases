##
# global aliases
# put local aliases in .bash_aliases.local
alias ta="tmux attach"
alias ll="ls -lah"
alias tailfn="tail --follow=name"
alias dc="docker-compose"

gpg_ownertrust() {
  echo "$( \
    gpg --list-keys --fingerprint | \
    grep $1 -A 1 | tail -1 | \
    tr -d '[:space:]' | cut -f2 -d'=' \
  ):6:"
}

export PATH=~/bin:$PATH

# load local aliases
if [ -f ~/.bash_aliases.local ]; then source ~/.bash_aliases.local; fi

