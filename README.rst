.. image:: antimber.png
    :alt: antimber sigil
    :align: center


antimber
  noun: matter, materials, substance

These are a set of legacy dotfiles for my Linux workspace. Depends on `Ansible`_,
`ansible-aur`_ and `Hord`_.

These were made for use with `Arch Linux`_, with `Xmonad`_ as my window manager and
`Neovim`_ as my primary development environment.

To install the symlinks:

.. code-block:: console

   hord dotfiles

To run the ansible playbook:

.. code-block:: console

   ansible-playbook playbook.yaml -K

.. _Hord: https://github.com/autophagy/hord
.. _Ansible: https://www.ansible.com/
.. _ansible-aur: https://aur.archlinux.org/packages/ansible-aur-git/
.. _Arch Linux: https://archlinux.org/
.. _Xmonad: https://hackage.haskell.org/package/xmonad
.. _Neovim: https://neovim.io/
