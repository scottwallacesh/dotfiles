#--------------------------------------------------------------------------------
# The best editor
#--------------------------------------------------------------------------------
alias vi=vim
export EDITOR=vim
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Make less use visual bell
#--------------------------------------------------------------------------------
export LESS="-qr"
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Update the path with local overrides
#--------------------------------------------------------------------------------
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:${PATH}

# coreutils
COREUTILS=$(brew --prefix coreutils 2>/dev/null)
if [ -s "${COREUTILS}" ]; then
    export PATH=${COREUTILS}/libexec/gnubin:${PATH}
fi
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# A useful prompt
#--------------------------------------------------------------------------------
export PS1="[\u@\h \W \[\033[32m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ <\1>/')\[\033[00m\]]\\$ "
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Record history for longer and more dynamically
#--------------------------------------------------------------------------------
# Large history buffer
export HISTSIZE=9999
export HISTFILESIZE=9999

# Avoid duplicates in the history...
export HISTCONTROL=ignoredups:erasedups

# Append history entries...
shopt -s histappend

# After each command, save and reload history
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a"
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# OS X aliases
#--------------------------------------------------------------------------------
if [ $(uname -s) = "Darwin" ]; then
    alias top='top -u'
    alias ll='ls -l'
fi
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Git aliases
#--------------------------------------------------------------------------------
alias gitx='open -a GitX .'
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Set up GOPATH for Go development
#--------------------------------------------------------------------------------
export GOPATH=${HOME}/src/go
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Add bash completion scripts
#--------------------------------------------------------------------------------
for FILE in ~/.bash/auto_complete.d/*; do source ${FILE}; done
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Run an SSH agent, if possible
#--------------------------------------------------------------------------------
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
     echo -n "Initialising new SSH agent... "
     /usr/bin/ssh-agent 2> /dev/null | sed 's/^echo/#echo/' > "${SSH_ENV}"
     pgrep ssh-agent > /dev/null && echo "succeeded" || echo "failed"
     chmod 0600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add ~/.ssh/scott_dsa
}

# Check if we already have an agent running and sourced
if [ -z "${SSH_AUTH_SOCK}" ]; then
    # Source SSH settings, if applicable
    if [ -f "${SSH_ENV}" ]; then
        . "${SSH_ENV}" > /dev/null
        pgrep ssh-agent | grep -E "^${SSH_AGENT_PID}" > /dev/null || {
            start_agent
        }
    else
        start_agent
    fi
fi
#--------------------------------------------------------------------------------

[ -f ~/.bashrc_local ] && source ~/.bashrc_local
