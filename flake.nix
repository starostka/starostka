{
  # https://xeiaso.net/blog/nix-flakes-1-2022-02-21

  description = "Starostka's Public Repo";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    strka.url = "git+ssh://git@github.com/Starostka/strka";
    strka.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {

  };

}