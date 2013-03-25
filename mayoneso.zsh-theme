# vim:ft=zsh ts=2 sw=2 sts=2 
# Mayoneso zsh prompt theme!
# Author: Bruno Heras <me@b0nk.com>
#

# Functions and stuff
#
if [ $UID -ne 0 ]; then
	USERCOLOR="yellow"
else
	USERCOLOR="red"
fi

# VPN status
# 
function get_vpn_status() {
	VPN=$(ifconfig | grep ppp | cut -d" " -f 2)
	if [ $VPN ]; then 
		echo -n "%{$fg_bold[black]%}v:%{$fg_bold[green]%}⇡%{$reset_color%} "
 	else 
		echo -n "%{$fg_bold[black]%}v:%{$fg_bold[red]%}⇣%{$reset_color%} "; 
	fi
}

# We check only last minute avg. 
# - Change $LOAD to 'uptime | cut -d, -f 6 | cut -d" " -f 2' to get 5min avg
# - Change $LOAD to 'uptime | cut -d, -f 5 | cut -d" " -f 2' to get 15min avg
#
function get_load() {
	LOAD=$(uptime | cut -d, -f 4 | cut -d: -f 2)
	if [ $LOAD -lt 3 ]; then
		echo -n "%{$fg_bold[black]%}l:%{$fg_bold[green]%}$(uptime | cut -d" " -f 11,12,13) %{$reset_color%}"
	elif [[ $LOAD -ge 3 && $LOAD -lt 4 ]]; then
		echo -n "%{$fg_bold[black]%}l:%{$fg_bold[yellow]%}$(uptime | cut -d" " -f 11,12,13) %{$reset_color%}"
	elif [ $LOAD -ge 4 ]; then 
		echo -n "%{$fg_bold[black]%}l:%{$fg_bold[red]%}$(uptime | cut -d" " -f 11,12,13) %{$reset_color%}"
	fi
}

# Local variables
#
time="%{$fg_bold[black]%}%T%{$reset_color%}"
pre="%{$fg[cyan]%}·%{$reset_color%}"
user="%{$fg_bold[$USERCOLOR]%}%n%{$reset_color%}"
hostname="%{$fg_bold[blue]%} ➲ %{$fg_bold[green]%}%M%{$reset_color%}"
dir="%{$fg_bold[cyan]%}%~%{$reset_color%}"
post="%{$fg[cyan]%}·%{$reset_color%}"

# Prompt and Right Prompt
#
PROMPT='%{$fg_bold[blue]%}⌈ ${time} ${user}${hostname} ${pre}${dir}${post} $(git_prompt_info)
%{$fg_bold[blue]%}⌊ %{$fg_bold[$USERCOLOR]%}%#%{$reset_color%} '
RPROMPT='$(get_vpn_status) $(get_load)'

# Git stuff
#
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} •%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} •%{$reset_color%}"
