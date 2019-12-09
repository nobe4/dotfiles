function wifit(){
	echo $(date) >> $ZSH/network/deconnections
	networksetup -setairportpower Wi-Fi off
	sleep 1
	networksetup -setairportpower Wi-Fi on
}
