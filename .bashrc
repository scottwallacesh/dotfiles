#--------------------------------------------------------------------------------
# The best editor
#--------------------------------------------------------------------------------
export EDITOR=vim
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Update the path with local overrides
#--------------------------------------------------------------------------------
export PATH=/usr/local/bin:/usr/local/sbin:${PATH}
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# A useful prompt
#--------------------------------------------------------------------------------
export PS1="[\u@\h \W]\\$ "
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
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Make OS X's 'top' behave like the GNU one
#--------------------------------------------------------------------------------
alias top='top -u'
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Git aliases
#--------------------------------------------------------------------------------
alias githistory='git log --oneline --abbrev-commit --all --graph --decorate'
alias gitx='open -a GitX .'
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Set up GOPATH for Go development
#--------------------------------------------------------------------------------
export GOPATH=${HOME}/src/go
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Add bash completion for ssh: it tries to complete the host to which you 
# want to connect from the list of the ones contained in ~/.ssh/known_hosts
#--------------------------------------------------------------------------------
__ssh_known_hosts() {
    if [[ -f ~/.ssh/known_hosts ]]; then
        cut -d " " -f1 ~/.ssh/known_hosts | cut -d "," -f1
    fi
}

_ssh() {
    local cur known_hosts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    known_hosts="$(__ssh_known_hosts)"
                                            
    if [[ ! ${cur} == -* ]] ; then
        COMPREPLY=( $(compgen -W "${known_hosts}" -- ${cur}) )
        return 0
    fi
}

complete -o bashdefault -o default -o nospace -F _ssh ssh 2>/dev/null \
    || complete -o default -o nospace -F _ssh ssh
#--------------------------------------------------------------------------------

[ -f ~/.bashrc_local ] && source ~/.bashrc_local
