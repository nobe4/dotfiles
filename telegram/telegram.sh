#!/bin/bash

curl -q -s -X POST "https://api.telegram.org/bot$(cat $ZSH/telegram/creds | head -n1)/sendMessage" -d chat_id="$(cat $ZSH/telegram/creds | tail -n1)" -d text="$*"
