#--------------------------------------------------------------------------------
# Function to prepend PATH only if it doesn't already exist
#--------------------------------------------------------------------------------
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1${PATH:+":$PATH"}"
    fi
}
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Decrypt stored keys
#--------------------------------------------------------------------------------
getkey() {
    KEYFILE=~/.keys/${1}

    if [ -f ${KEYFILE} ]; then
        if [ -x /usr/bin/security ]; then
            PASS=$(/usr/bin/security find-internet-password -l ssh:scott@wallace.sh -gw)
        else
            read -sp "Password: " PASS
            echo
        fi

        openssl rsautl -decrypt -inkey ~/.ssh/scott@wallace.sh -passin "pass:${PASS}" -in ${KEYFILE} 2>/dev/null
    else
        echo "No such key" >&2
    fi
}
#--------------------------------------------------------------------------------

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
# Default directories
#--------------------------------------------------------------------------------
mkdir -p ~/src ~/tmp ~/var/log
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Update the path with local overrides
#--------------------------------------------------------------------------------
pathadd /usr/local/sbin
pathadd /usr/local/bin
pathadd ~/bin
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Rebind CTRL-T to search forward in history
#--------------------------------------------------------------------------------
if [ -n "$PS1" ]; then
    bind "\C-t":forward-search-history
fi
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Add bash completion scripts
#--------------------------------------------------------------------------------
for FILE in ~/.bash/auto_complete.d/*; do source ${FILE}; done
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
# Command aliases
#--------------------------------------------------------------------------------
alias ll='ls -l'
[[ -x $(which htop 2>/dev/null) ]] && alias top='sudo htop'
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Set up GOPATH for Go development
#--------------------------------------------------------------------------------
export GOPATH=${HOME}/src/go
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Run an SSH agent, if possible
#--------------------------------------------------------------------------------
# Check if we already have an agent running and sourced
if [ -z "${SSH_AUTH_SOCK}" ]; then
    SSH_AUTH_SOCK_FILE=~/.ssh/auth_sock
    if [ -S ${SSH_AUTH_SOCK_FILE} ]; then
        export SSH_AUTH_SOCK=${SSH_AUTH_SOCK_FILE}
        export SSH_AGENT_PID=$(cat ~/.ssh/agent.pid)
    else
        eval `ssh-agent -a ${SSH_AUTH_SOCK_FILE} -s`
        echo ${SSH_AGENT_PID} > ~/.ssh/agent.pid
        ssh-add
    fi
fi
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Update brew if it's older than one day
#--------------------------------------------------------------------------------
if [ -x /usr/local/bin/brew ]; then
    export HOMEBREW_GITHUB_API_TOKEN=$(getkey HOMEBREW_GITHUB_API_TOKEN)
    (
        find /usr/local/.git -name FETCH_HEAD -mtime +0 -exec \
        bash -c "echo \"--Start: $(date)\"; \
                 brew update; \
                 echo \"--End: $(date)\"" \
        \; >> ~/var/log/brew-update.log 2>&1 &
    )
fi
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Run local .bashrc for any local-only commands
#--------------------------------------------------------------------------------
[ -f ~/.bashrc_local ] && source ~/.bashrc_local
#--------------------------------------------------------------------------------
