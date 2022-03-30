# Voidrice

🔼 This repo is originally forked from [Luke Smith's rice](https://github.com/LukeSmithxyz/voidrice). Therefore credit where credit's due. But I distance myself from anything else, especially politically, coming from Luke's direction. If you're reading this, you probably know what this means.

- Very useful scripts are in `~/.local/ricebin/`
- Settings for:
	- i3 (window manager)
	- XFCE (desktop environment components)
	- vim/nvim (text editor)
	- spacemacs (another text editor)
	- zsh (shell)
	- sxhkd (general key binder)
	- ranger (file manager)
	- mpd/ncmpcpp (music)
	- sxiv (image/gif viewer)
	- mpv (video player)
	- tmux
	- other stuff like xdg default programs, inputrc and more, etc.
- I try to minimize what's directly in `~` so:
	- All configs that can be in `~/.config/` are.
	- Some environmental variables have been set in `~/.zprofile` to move configs into `~/.config/`
- Bookmarks in text files used by various scripts (like `~/.local/ricebin/shortcuts`)
	- File bookmarks in `~/.config/files`
	- Directory bookmarks in `~/.config/directories`

## Usage

## Install these dotfiles and all dependencies

Use [LARBS](https://github.com/remolueoend/LARBS) to autoinstall everything:

```
curl -LO https://raw.githubusercontent.com/remolueoend/LARBS/master/larbs.sh
```

or clone the repo files directly to your home directory and install the
[dependencies](https://raw.githubusercontent.com/remolueoend/LARBS/master/progs.csv).

## Useful tools

| name  | tags                       |
| ----- | ------                     |
| duc   | disk space                 |
| tlp   | energy battery performance |

