# install python, nbdev-v2, pandoc, # maybe latex?

# get quarto from (github release)
let src = pkgs.fetchFromGitHub {
    owner  = "fastai";
    repo   = "nbdev-v2";
    rev    = "88150c7b8a0664a70757ffd88b2ac12b84dd0604";
    sha256 = "1mb3gfg01mj7ajjl1ylw24mnwamcnnifbxkakzal2j6ibqyqw6rq";
  };
in
import "${src}/release.nix"

# setup awesome shell tools

# input notebook and output pdf

# create docker container