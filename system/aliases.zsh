# Ping 8.8.8.8
alias p8='ping -v 8.8.8.8'

# ps and grep easily
alias pg='ps aux | grep'

# quicker kill all
alias kk='killall'

if [ -n "$IS_MACOS" ]; then
	# RM Replacement
	# don't use rm unless you know what you're doing
	# to force rm, use full path : /bin/rm
	alias rm='echo "use /bin/rm or trash"'

	# Mac Catalina is breaking everything, thanks Tim Apple.
	# from https://www.kvraudio.com/forum/viewtopic.php?t=530824&start=15
	alias unlockvst='xattr -d com.apple.quarantine'
fi

if [ -n "$IS_LINUX" ]; then
	function portscan(){
		lsof -nP -i4TCP:$1
	}
fi
