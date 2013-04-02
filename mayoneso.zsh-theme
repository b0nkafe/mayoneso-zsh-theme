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
#
function get_load() {
if [[ $OSTYPE == "linux-gnu" ]]; then
	CPUCORES=$(grep processor /proc/cpuinfo | wc -l)
  LOAD=$(cat /proc/loadavg | cut -d" " -f1 | cut -d. -f1)
  LOADAVG=$(cat /proc/loadavg | cut -d" " -f1,2,3)
else
	CPUCORES=$(sysctl -n hw.ncpu)
  LOAD=$(sysctl -n vm.loadavg | cut -d" " -f2 | cut -d. -f1)
  LOADAVG=$(sysctl -n vm.loadavg | cut -d" " -f2,3,4)
fi
if [ `expr $CPUCORES % 2` -eq 0 ]; then
	if [ $LOAD -lt $(($CPUCORES / 2)) ]; then
		echo -n "%{$fg_bold[black]%}l:%{$fg_bold[green]%}$LOADAVG %{$reset_color%}"
	elif [[ $LOAD -ge $(($CPUCORES / 2)) && $LOAD -lt $CPUCORES ]]; then
		echo -n "%{$fg_bold[black]%}l:%{$fg_bold[yellow]%}$LOADAVG %{$reset_color%}"
	elif [ $LOAD -ge $CPUCORES ]; then 
		echo -n "%{$fg_bold[black]%}l:%{$fg_bold[red]%}$LOADAVG %{$reset_color%}"
	fi
else
	if (( $LOAD < 0.50 )); then
		echo -n "%{$fg_bold[black]%}l:%{$fg_bold[green]%}$LOADAVG %{$reset_color%}"
	elif (( $LOAD >= 0.50 )) && (( $LOAD < 1.00 )); then
		echo -n "%{$fg_bold[black]%}l:%{$fg_bold[yellow]%}$LOADAVG %{$reset_color%}"
	elif (( $LOAD >= 1.00 )); then
		echo -n "%{$fg_bold[black]%}l:%{$fg_bold[red]%}$LOADAVG %{$reset_color%}"
	fi
fi
}

# Local variables
#
time="%{$fg_bold[black]%}%T%{$reset_color%}"
pre="%{$fg_bold[yellow]%}·%{$reset_color%}"
user="%{$fg_bold[$USERCOLOR]%}%n%{$reset_color%}"
hostname="%{$fg[yellow]%} ➲ %{$fg_bold[green]%}%M%{$reset_color%}"
dir="%{$fg_bold[black]%}%~%{$reset_color%}"
post="%{$fg_bold[yellow]%}·%{$reset_color%}"

# Prompt and Right Prompt
#
PROMPT='%{$fg[yellow]%}⌈ ${time} ${user}${hostname} ${pre}${dir}${post} $(git_prompt_info)
%{$fg[yellow]%}⌊ %{$fg_bold[$USERCOLOR]%}%#%{$reset_color%} '
RPROMPT='$(get_vpn_status) $(get_load)'

# Git stuff
#
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}(%{$fg_bold[black]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[yellow]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} ●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ●%{$reset_color%}"
