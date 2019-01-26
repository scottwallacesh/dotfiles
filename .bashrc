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
# A useful prompt
#--------------------------------------------------------------------------------
function __PROMPT_COMMAND() {
    history -a
    echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"
}

export PS1="[\u@\h \W \[\033[32m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ <\1>/')\[\033[00m\]]\\$ "
export PROMPT_COMMAND=__PROMPT_COMMAND
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Command alias functions
#--------------------------------------------------------------------------------
function datafart() { curl --data-binary @- datafart.com; } && export -f datafart
function space() { du -ahx --max-depth=1 | sort -h;  } && export -f space
if ! alias ll >/dev/null 2>&1; then function ll() { ls -l ${@}; } && export -f ll; fi
[[ ! -x $(which psgrep 2>/dev/null) ]] && function psgrep() { ps -ef | grep ${@} | grep -v ${$}; } && export -f psgrep
[[ -x $(which glances 2>/dev/null) ]] && function top() { glances; } && export -f top
[[ -x $(which tree 2>/dev/null) ]] && alias tree="tree -AQh --du"

export GIT_SSH_COMMAND="$(which ssh) -o RemoteCommand=none"
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Include deployed bash config
#--------------------------------------------------------------------------------
for include in ~/.bashrc.d/*; do
  source ${include}
done
#--------------------------------------------------------------------------------
