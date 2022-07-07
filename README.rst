.. image:: static/antimber.png
    :alt: antimber sigil
    :align: center


antimber
  noun: matter, materials, substance

These are a set of nix expressions and dotfiles for my Linux workspace. Depends
on `home-manager`_.

Currently using `NixOS`_, with `i3`_ as my window manager and
`Neovim`_ as my primary development environment.

My configuration is described by a nix flake. To build/switch the NixOS configuration::

    λ sudo nixos-rebuild switch --flake .#

To build/switch home-manager::

    λ home-manager switch --flake .

*My legacy Arch Linux dotfiles are available on the* `arch`_ *branch.*

.. _NixOS: https://nixos.org/
.. _home-manager: https://github.com/nix-community/home-manager
.. _i3: https://i3wm.org/⎋
.. _arch: https://github.com/autophagy/antimber/tree/arch
