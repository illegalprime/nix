###########
# History #
###########
# Setup zsh to save history from previous sessions.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=SAVEHIST=10000

########
# Wine #
########
export WINEBASE="$HOME/.wineprefixes"
export WINEPREFIX="$WINEBASE/default"

########
# PATH #
########
export PATH="${PATH}:/home/michael/.cabal/bin/"
export PATH="${PATH}:/home/michael/.local/bin"
export PATH="${PATH}:/home/michael/.gem/ruby/2.5.0/bin/"
export PATH="${PATH}:/home/michael/.cargo/bin/"
export PATH="${PATH}:/home/michael/bin/node_modules/.bin/"
export PATH="${PATH}:/home/michael/bin/"

############
# SSH Pass #
############
# export SSH_ASKPASS="/run/current-system/sw/bin/ksshaskpass"
