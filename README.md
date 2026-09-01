<p align="center">
  <img src="static/antimber.png" alt="antimber sigil">
</p>

**antimber**
> noun: matter, materials, substance

These are a set of nix expressions and dotfiles for my Linux and macOS
workspaces. Depends on [home-manager][home-manager] and, on macOS,
[nix-darwin][nix-darwin].

The Linux machines use [NixOS][nixos] with [sway][sway] as the window manager.
[Helix][helix] is the primary development environment across the
configurations.

My configuration is described by a nix flake. To build nixos, darwin or
home-manager using [just][just]:

```
λ just build nixos
λ just build darwin
λ just build home-manager
```

To switch nixos, darwin or home-manager configurations:

```
λ just switch nixos
λ just switch darwin
λ just switch home-manager
```

A full build or switch can be done with the `full` target, which composes the
system and Home Manager configurations: nixos and home-manager on Linux, darwin
and home-manager on macOS.

Antimber manages the following machines:

- **Æppelbōc** - MacOS personal development laptop (Apple Silicon MacBook).
- **Gamentól** - Gaming machine.
- **Hindberige** - Raspberry Pi 3 Model B.
- **Heorot** - Linux personal development laptop (Lenovo X1 Carbon).

*My legacy Arch Linux dotfiles are available on the [arch][arch] branch.*

[nixos]: https://nixos.org/
[home-manager]: https://github.com/nix-community/home-manager
[nix-darwin]: https://github.com/nix-darwin/nix-darwin
[sway]: https://swaywm.org/
[helix]: https://helix-editor.com/
[just]: https://github.com/casey/just
[arch]: https://github.com/autophagy/antimber/tree/arch
