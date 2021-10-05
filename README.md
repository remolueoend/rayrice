# Voidrice

These are my dotfiles, based on Luke's rice: https://github.com/LukeSmithxyz/voidrice:

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

I also recommend trying out
[mutt-wizard](https://github.com/lukesmithxyz/mutt-wizard), which additionally
works with this setup. It gives you an easy-to-install terminal-based email
client regardless of your email provider. It is integrated into these dotfiles
as well.

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

