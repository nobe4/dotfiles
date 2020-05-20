# Start ssh with root account
function rssh(){
	ssh "$1" -t 'sudo su; exec bash -l'
}
alias sshr=rssh

alias coffee="caffeinate -d"

function ups() {
	curl 'https://www.ups.com/track/api/Track/GetStatus?loc=en_US' \
		-s \
		-H 'Accept: application/json, text/plain, */*' \
		--compressed \
		-H 'Content-Type: application/json' \
		--data-raw '{"Locale":"en_US","TrackingNumber":["'$1'"]}' \
		| jq '.trackDetails[0].shipmentProgressActivities
		| reverse
		| .[]
		| select(.activityScan != null)
		| .date + " " + .time + " - " + .location + " - " + .activityScan'
}
