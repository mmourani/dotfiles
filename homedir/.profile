#############################################################
# Generic configuration that applies to all shells
#############################################################

#source ~/.shellvars
#source ~/.shellfn
#source ~/.shellpaths
#source ~/.shellaliases
#source ~/.iterm2_shell_integration.`basename $SHELL`
# Private/Proprietary shell aliases (not to be checked into the public repo) :)
#source ~/Dropbox/Private/Boxes/osx/.shellaliases
. "$HOME/.cargo/env"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/user/.lmstudio/bin"

# 🔐 Load secure API keys and secrets
[[ -f ~/.secrets ]] && source ~/.secrets
