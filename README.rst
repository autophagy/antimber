.. image:: antimber.png
    :alt: antimber sigil
    :align: center


antimber
  noun: matter, materials, substance

These are a set of dotfiles for my Linux workspace. Depends on `Ansible`_,
`ansible-aur`_ and `Stow`_.

To install the symlinks:

.. code-block:: console

   cd dotfiles
   stow -t ~/ dunst i3 nvim polybar qutebrowser git terminal

To run the ansible playbook:

.. code-block:: console

   ansible-playbook playbook.yaml -K

.. _Stow: https://www.gnu.org/software/stow/
.. _Ansible: https://www.ansible.com/
.. _ansible-aur: https://aur.archlinux.org/packages/ansible-aur-git/
