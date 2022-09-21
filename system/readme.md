# Welcome
This folder contains automated dotfile management and system configurations using the NixOS system.

## Macbook

## Windows

## Raspberry Pi

# Dotfiles

This is my collection of [configuration files](http://dotfiles.github.io/).

## NOTICE!
The nix files currently focus on MacOS systems and thus, haven't been tested on other types of hosts..

## TODO
Add and configure whatever brews needed in the old Brewfile

1. Search the corresponding Nix package.
2. Add the Nix package name to the home.packages list in my home.nix file.
3. Run home-manager switch.
4. Verify that the program is picked up by my shell (which <executable name>) and is runnable (<executable name> --version or similar).
5. Look at the corresponding Home Manager module, if it exist, to see if I can port over any dotfiles.


# OLD SECTION
It uses [home-manager][home-manager]—a [Nix][nix]-based tool—to install
programs and create their configuration files based off the
[`home.nix`](home.nix) file in this repository. I [wrote more about it in a
blog post][nix-post].

(I used to [use GNU Stow][stow-post]. The last Stow-based commit was
[`4f1feee1e`][stow-commit].)

## Usage

Install [Nix][nix] and then install [home-manager][home-manager]. You should be
able to run the `home-manager` program in a shell.

Next, clone this repository to `~/.config/nixpkgs`.

```shell
$ git clone git@github.com:starostka/dotfiles.git ~/.config/nixpkgs
```

This will place the [`home.nix`](home.nix) file in the location home-manager
expects. The home-manager profile can then be built and activated:

```shell
$ home-manager switch
```

To update home-manager:

```shell
$ nix-channel --update nixpkgs
unpacking channels...
$ nix-env -u home-manager
```

To update home-manager-managed packages:

```shell
$ nix-channel --update nixpkgs
unpacking channels...
$ home-manager switch
```

### Neovim

On its first run [Neovim][neovim] will install the [packer.nvim][packer]
package management plugin. Restart Neovim and install the other packages with
`:PackerInstall`.

### iTerm2

The [iTerm2][iterm2] profile can be installed with:

```shell
$ ln -s (realpath config/iterm2/DynamicDefault.json) ~/Library/Application\ Support/iTerm2/DynamicProfiles/
```

It depends on the [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) variant
of the [IBM Plex Mono](https://www.ibm.com/plex/) fonts.

## License

[MIT](http://opensource.org/licenses/MIT).

[nix]: https://nixos.org/
[home-manager]: https://github.com/nix-community/home-manager
[fish]: https://fishshell.com/
[neovim]: https://neovim.io/
[packer]: https://github.com/wbthomason/packer.nvim
[iterm2]: https://iterm2.com/

[nix-post]: https://alexpearce.me/2021/07/managing-dotfiles-with-nix/
[stow-post]: https://alexpearce.me/2016/02/managing-dotfiles-with-stow/
[stow-commit]: https://github.com/alexpearce/dotfiles/tree/4f1feee1e4bc71f2ba5774af44eed1da774510a0
