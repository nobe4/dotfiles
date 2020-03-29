# Start ssh with root account
function rssh(){
	ssh "$1" -t 'sudo su; exec bash -l'
}
alias sshr=rssh

alias coffee="caffeinate -d"
