#PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\](\$?)\$ "
PS1="\[\033[01;37m\]\$? \$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]\342\234\223\"; else echo \"\[\033[01;31m\]\342\234\227\"; fi) $(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;32m\]sup'; fi)\[\033[01;34m\] \w \$\[\033[00m\] "

# Automatically correct mistyped directory names on cd 
shopt -s cdspell

#############
#  Aliases  #
#############

alias py="python"
alias mount="mount | column -t"
alias a_service_names="lsof -n -P -i +c 13"
alias a_sort='ls -trlh $1'

#############
# Functions #
#############

# Finds program name
f_findprogramname() {
 read -p "Turn on unknown program and press 'Enter' "
 ps x -o cmd > /tmp/capture1.txt
 read -t 15 -p "Turn off unknown program and press 'Enter'"
 ps x -o cmd > /tmp/capture2.txt
 diff /tmp/capture1.txt /tmp/capture2.txt
}

# Timer
f_timer(){
 if [[ "$@" -ne 1 ]]; then
  echo "usage: $FUNCNAME minutes_to_countdown"
  return 1
 fi
 min=$(($1 * 60))
 sleep $min && notify-send "Timer" "$1 min. ended." 
 echo "Timer ended after $1 min."
 }

# Opening file with defaul application
open(){
 xdg-open "$1" &
}

# Finds files in current directory
#eq= find -name "$1"
f_find() {
#   ls | grep "$1"
    find -iname "*$1*"
}


# Opens man on commands with Ctrl-H
function man_on_word {
	TMP_LN=$READLINE_LINE
	TMP_POS=$READLINE_POINT
	while [ $TMP_POS -gt 0 ] &&
	[ "${TMP_LN:TMP_POS:1}" != " " ]
	do true $((--TMP_POS))
	done
	if [ 0 -ne $TMP_POS ]; then true $((++TMP_POS));fi
	TMP_WORD="${READLINE_LINE:$TMP_POS}"
	TMP_WORD="${TMP_WORD%% *}"
	man "$TMP_WORD"
}

bind -x '"\C-h":man_on_word'


