.. image:: static/antimber.png
    :alt: antimber sigil
    :align: center

antimber
  noun: matter, materials, substance

These are a set of nix expressions and dotfiles for my Linux workspace. Depends
on `home-manager`_.

Currently using `NixOS`_, with `i3`_ as my window manager and
`Neovim`_ as my primary development environment.

My configuration is described by a nix flake. To build nixos or home-manager using `just`_::

    λ just build nixos
    λ just build home-manager

To switch nixos or home-manager configurations::

    λ just switch nixos
    λ just switch home-manager

A full build or switch can be done with the ``full`` target.

Antimber manages the following machines:

- **Heorot** - My personal development laptop (Lenovo X1 Carbon).
- **Gamentól** - Gaming machine.
- **Hindberige** - Raspberry Pi 3 Model B.

*My legacy Arch Linux dotfiles are available on the* `arch`_ *branch.*

.. _NixOS: https://nixos.org/
.. _home-manager: https://github.com/nix-community/home-manager
.. _i3: https://i3wm.org/
.. _Neovim: https://neovim.io/
.. _just: https://github.com/casey/just
.. _arch: https://github.com/autophagy/antimber/tree/arch
