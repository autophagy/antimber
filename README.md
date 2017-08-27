# Autophagy :: Dotfiles

Dotfiles for [Arch Linux](https://www.archlinux.org/) themes, all based around
the use of the [i3wm-gaps](https://github.com/Airblader/i3) window manager.

## Themes

### 0x01 :: Arboria

![arboria UI](arboria/arboria.jpg)

Elements :: i3wm // polybar // dunst

[Arboria README](arboria/README.md)

## Installation

Theme installation is done via `install.py`. To set up:

```
virtualenv -p python3 .env
.env/bin/pip install -r requirements.txt
```

To list valid themes:

```
.env/bin/python install.py -l
```

To install a theme (for example, arboria):

```
.env/bin/python install.py -n arboria
```
