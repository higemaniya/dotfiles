path=($HOME/.local/bin(N) $HOME/bin(N) /usr/pkg/{s,}bin(N) /opt/local/{s,}bin(N) /usr/local/{s,}bin(N) /{s,}bin /usr/{s,}bin /usr/games(N))
typeset -U path

export EDITOR=vim

autoload -U compinit
compinit

bindkey -e
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
bindkey -s '^z' '^[q %vim^m'

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ":vcs_info:git:*" check-for-changes false
zstyle ":vcs_info:git:*" formats "%s:%c%u|%b@%r"
zstyle ":vcs_info:git:*" actionformats "%s!%a%b!%c|%b@%r"
zstyle ":vcs_info:git:*" unstagedstr "*"
zstyle ":vcs_info:git:*" stagedstr "S"

my_git_info_stash() {
	if [ "$(git stash list 2>/dev/null)" != "" ]; then
		echo "#";
	fi
}
my_vcs_info() {
	vcs_info
#	echo $(my_git_info_stash)$vcs_info_msg_0_
	echo $vcs_info_msg_0_
}
setopt prompt_subst
PROMPT='%B%m:%~%b%# '
PROMPT2='%_%% '
RPROMPT=$'$(my_vcs_info)'

HISTFILE=~/.zsh_history
HISTSIZE=1024000
SAVEHIST=1024000
setopt hist_ignore_space
setopt hist_ignore_dups
setopt share_history

setopt auto_cd
setopt auto_pushd
#setopt correct
setopt nolistbeep
setopt list_packed

alias vi='vim'

test -f $HOME/.rvm/scripts/rvm && source $HOME/.rvm/scripts/rvm && rvm reload > /dev/null

which hub > /dev/null && eval "$(hub alias -s)"
