#!/usr/bin/env bash

source "${DOTFILE_FOLDER}/shell/prompt.sh"

# Load the functions
for f in "${DOTFILE_FOLDER}/functions/"*; do
    fn="${f##*/}"
    eval "$fn() { . '$f'; }"
done
