list_file=${DOTFILE_FOLDER}/links/list

function l(){
	sane_list="$(cat $list_file | sed '/^#/d; /^$/d')"
	if [ -z "$sane_list" ]; then
		echo "No links, aborting."
		return 1
	fi

	choice="$(echo $sane_list | fzf)"
	if [ -z "$choice" ]; then
		echo "No choice, aborting."
		return 1
	fi

	if [ "$choice" = "OPEN_LIST" ]; then
		echo "Opening $list_file in $EDITOR."
		$EDITOR "$list_file"
		return 0
	fi

	url="$(echo $choice | cut -d' ' -f1)"
	if [ -z "$url" ]; then
		echo "No url, aborting."
		return 1
	fi

	echo "Copying '$url' in the clipboard."
	printf "$url" | pbcopy
}
