#--------------------------------------------------------------------------------
# Exit for non-interactive sessions
#--------------------------------------------------------------------------------
if [ -z "$PS1" ]; then
    return
fi
#--------------------------------------------------------------------------------

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
export EDITOR=vim
alias vi='vim'
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
# Set some variables
#--------------------------------------------------------------------------------
# Add the Homebrew API token, if appropriate
if [ -x "$(which brew 2>/dev/null)" ]; then
    export HOMEBREW_GITHUB_API_TOKEN=$(getkey HOMEBREW_GITHUB_API_TOKEN)
fi
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Add bash completion scripts (deferred until the end and backgrounded)
#--------------------------------------------------------------------------------
function _deferred {
    # Bash completion with Homebrew
    if [ -f $(brew --prefix 2>/dev/null)/etc/bash_completion ]; then
        . $(brew --prefix 2>/dev/null)/etc/bash_completion
    fi
}
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# A useful prompt
#--------------------------------------------------------------------------------
function __PROMPT_COMMAND() {
    history -a
    echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"
}

export PS1="[\u@\h \W \[\033[32m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ <\1>/')\[\033[00m\]]\\$ "
export PROMPT_COMMAND="${PROMPT_COMMAND:+"${PROMPT_COMMAND%%';__PROMPT_COMMAND'};"}__PROMPT_COMMAND"
export PROMPT_COMMAND="${PROMPT_COMMAND//;;/;}"
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Record history for longer and more dynamically
#--------------------------------------------------------------------------------
# Unlimited history buffer
export HISTSIZE=
export HISTFILESIZE=

# Avoid duplicates in the history...
export HISTCONTROL=ignoreboth

# Record the timestamp in the bash history
export HISTTIMEFORMAT="%Y-%m-%d %T "

# Append history entries...
shopt -s histappend
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Command alias functions
#--------------------------------------------------------------------------------
function datafart() { curl --data-binary @- datafart.com; } && export -f datafart
function space() { du -ahx --max-depth=1 | sort -h;  } && export -f space
if ! alias ll >/dev/null 2>&1; then function ll() { ls -l ${@}; } && export -f ll; fi
[[ ! -x $(which psgrep 2>/dev/null) ]] && function psgrep() { ps -ef | grep ${@} | grep -v ${$}; } && export -f psgrep
[[ -x $(which glances 2>/dev/null) ]] && function top() { glances; } && export -f top
[[ -x $(which gdu 2>/dev/null) ]] && function du() { gdu ${@}; } && export -f du
[[ -x $(which gsort 2>/dev/null) ]] && function sort() { gsort ${@}; } && export -f sort
[[ -x /bin/ps && -x $(which pstree 2>/dev/null) && $(uname -s) = 'Darwin' ]] && function ps() { if [[ ${1} =~ 'f' ]]; then pstree; else /bin/ps ${@}; fi }
[[ -x $(which tree 2>/dev/null) ]] && alias tree="tree -AQh --du"
export GIT_SSH_COMMAND="$(which ssh) -o RemoteCommand=none"
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Set up GOPATH for Go development
#--------------------------------------------------------------------------------
export GOPATH=${HOME}
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
# iTerm2 shell integration
#--------------------------------------------------------------------------------
[ $(uname -s) = 'Darwin' -a -f ~/.iterm2/shell_integration.bash ] && source ~/.iterm2/shell_integration.bash
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Run local .bashrc for any local-only commands
#--------------------------------------------------------------------------------
[ -f ~/.bashrc_local ] && source ~/.bashrc_local
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Kick off the _deferred() function and background it (speeding up Bash loading)
#--------------------------------------------------------------------------------
trap '_deferred 2>/dev/null; trap USR1' USR1
{ sleep 0.1 ; builtin kill -USR1 $$ ; } & disown
#--------------------------------------------------------------------------------
