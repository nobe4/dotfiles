#!/bin/sh
#
# Antigen

if ! [[ -a $HOME/.antigen/antigen.zsh ]]
then
  echo "  Installing Antigen for you."
  mkdir ~/.antigen
  curl -L https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh -o ~/.antigen/antigen.zsh
fi

exit 0
