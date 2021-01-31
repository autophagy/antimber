.. image:: antimber.png
    :alt: antimber sigil
    :align: center


antimber
  noun: matter, materials, substance

These are a set of dotfiles for my Linux workspace. Depends on `Ansible`_,
`ansible-aur`_ and `Hord`_.

To install the symlinks:

.. code-block:: console

   hord dotfiles

To run the ansible playbook:

.. code-block:: console

   ansible-playbook playbook.yaml -K

.. _Hord: https://github.com/autophagy/hord
.. _Ansible: https://www.ansible.com/
.. _ansible-aur: https://aur.archlinux.org/packages/ansible-aur-git/
