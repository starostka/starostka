#!/bin/bash

# Login to 1Password. 
# Assumes you have installed the OP CLI and performed the initial configuration
# For more details see https://support.1password.com/command-line-getting-started/
eval $(op signin my)

# TODO: add option for selecting another vault

ev=`op get item "Environment Variables"` 

# Convert to base64 for multi-line secrets.
# The schema for the 1Password type 'Password' uses t as the label, and v as the value.
for row in $(echo ${ev} | jq -r -c '.details.sections[1].fields[] | @base64'); do
    _envvars() {
        echo ${row} | base64 --decode | jq -r ${1}
    } 
    echo "Setting environment variable $(_envvars '.t')"
    export $(echo "$(_envvars '.t')=$(_envvars '.v')")
done
