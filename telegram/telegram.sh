#!/bin/bash

curl -q -s -X POST "https://api.telegram.org/$(cat $ZSH/telegram/creds)/sendMessage" -d chat_id=668930122 -d text="$*"
