#!/bin/sh

# This is just an example to showcase pre-commit

set -e

if git commit -v --dry-run | grep '!nocommit' >/dev/null 2>&1
then
  echo "Trying to commit non-committable code."
  echo "Remove the !nocommit string and try again."
  exit 1
fi

exit 0
