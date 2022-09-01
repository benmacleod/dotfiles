#!/bin/bash
# Find the directory this script is in
# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Install each gem in gems.txt
cat "$SCRIPT_DIR/gems.txt" | xargs gem install
