# Antimber :: Feówerscýte

Feówerscýte is a stark, cubonic theme set up for
[Arch](https://www.archlinux.org/), with date displayed in
[Wending Calendar](https://datarum.readthedocs.io/en/latest/usage/details.html).

Work spaces are currently:
1 :: terminal // 2 :: browser // 3 :: code // 4 :: comm // 5-0 :: free

#### Clean
![feowerscyte clean](screenshots/clean.jpg)

#### Busy
![feowerscyte busy](screenshots/busy.jpg)

#### Lock Screen
![feowerscyte i3lock](screenshots/i3lock.jpg)

## Polybar Sigils

In the upper right, power, wlan/vpn connectivity, volume and mail alerts
are indicated. They are represented by:

- wlan connected :: ◩
- vpn connected :: ◪
- mail alert :: ▤
- volume level :: muted □ // volume level (lowest - highest) ◱ ◰ ◳ ◲
- battery :: charging ▣ // battery level (lowest - highest) □ ◫ ◧ ◨ ■

There is also a exit/suspend/restart/shutdown menu in the upper right:

- shutdown :: □
- reboot :: ◲
- lock and suspend :: ◫
- i3 exit :: ◪

## Components Used

 - [i3wm-gaps](https://github.com/Airblader/i3) :: tiling window manager
 - [dunst](https://github.com/dunst-project/dunst) :: lightweight notification
   daemon
 - [polybar](https://github.com/jaagr/polybar) :: customisable statusbar (
   replaces i3-status)
 - [i3lock-color](https://github.com/chrjguill/i3lock-color) :: simple,
   customisable screen locker (replaces i3lock)

##  Requirements

 - fonts :: [Interface](https://rsms.me/interface/) // [DejaVu Sans Mono For Powerline](https://github.com/powerline/fonts/tree/master/DejaVuSansMono)
 - python :: [datarum](https://pypi.python.org/pypi/datarum/) for Wending date
 - [scrot](https://www.archlinux.org/packages/community/i686/scrot/) :: for
   printscrn
 - [imagemagick](https://www.imagemagick.org/script/index.php) :: for i3lock
   screenshot && blur
 - [bc](https://www.gnu.org/software/bc/) :: for i3lock icon type detection
 - [rxvt-unicode](https://www.archlinux.org/packages/community/x86_64/rxvt-unicode/)
   :: terminal emulator
