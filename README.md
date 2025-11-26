# dotfiles
---
This repository contains minimalistic dotfiles that I primary use with GNU/Linux via
[Arch Linux](https://archlinux.org/)

## Setup
---
I manage my dotfiles using [GNU stow](https://www.gnu.org/software/stow/)
```
git clone https://github.com/pr1ngls/dotfiles.git
```
```
stow <package> -t $HOME
```
e.g. for hyprland:
```
stow hypr -t $HOME
```


