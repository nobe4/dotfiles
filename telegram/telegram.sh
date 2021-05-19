#!/bin/bash

curl -q -s -X POST "https://api.telegram.org/bot$(cat $DOTFILE_FOLDER/telegram/creds | head -n1)/sendMessage" -d chat_id="$(cat $DOTFILE_FOLDER/telegram/creds | tail -n1)" -d text="$*"
