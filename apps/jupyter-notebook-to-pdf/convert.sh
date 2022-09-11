#! /usr/bin/env nix-shell
#! nix-shell -i bash -p pandoc python39Packages.ipython python39Packages.toolz python39Packages.nbconvert

# https://nixos.org/manual/nix/unstable/command-ref/nix-shell.html

echo "Uuuuh what a nice little notebook. Let me handle it for ya! ;-)"

NOTEBOOK_PATH=$1
OUTPUT_PATH=$2

jupyter nbconvert --to PDF ${NOTEBOOK_PATH} --output ${OUTPUT_PATH}