![Antimber](doc/header.png)

Dotfiles for [Arch Linux](https://www.archlinux.org/) themes, all based around
the use of the [i3wm-gaps](https://github.com/Airblader/i3) window manager.

## Themes

### 0x01 :: Arboria
#### Clean

![arboria clean](arboria/screenshots/clean.jpg)

#### Busy

![arboria busy](arboria/screenshots/busy.jpg)

#### Lock Screen

![arboria i3lock](arboria/screenshots/i3lock.jpg)

Elements :: i3wm // polybar // dunst
[Arboria README](arboria/README.md)

### 0x02 :: Hwit
#### Clean

...

#### Busy

...

#### Lock Screen

...

Elements :: i3wm // polybar // dunst
[Hwit README](hwit/README.md)

## Installation

Theme installation is done via `install.py`. To set up:

```
virtualenv -p python3 .venv
.venv/bin/pip install -r requirements.txt
```

To list valid themes:

```
.venv/bin/python install.py -l
```

To install a theme (for example, arboria):

```
.venv/bin/python install.py -n arboria
```
