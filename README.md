# droid-nixos

NixOS VM on the Android "Terminal" app

**Experimental project**: This thing probably doesn't work. Use at your own risk, especially risk of destroying your virtual machine.

See also <https://github.com/nix-community/nixos-avf> which is probably better anyway.

## What on earth is this?

Google shipped a "Linux development environment" to Pixel devices around March 2025.

> Starting with Android 15 QPR1, you can try the experimental Linux terminal app that's available on select devices. This app provides access to a Linux terminal environment within a virtual machine (VM).

Source: <https://developer.android.com/about/versions/15/release-notes#linux-development-environment>

It runs a Debian VM. We can replace it with NixOS with `/etc/NIXOS_LUSTRATE`. Since it's "just" an AArch64 VM it runs mainline Linux just fine.

## Screenshots

![Fake terminal running in Terminal app](doc/droid-fake-terminal.png)

![Neofetch running on NixOS, while connected via SSH in Termux](doc/droid-ssh-neofetch.png)

## What works and what doesn't?

Works:

- Boots
- You can SSH into it

Doesn't work:

- Bootloader config (`nixos-rebuild switch` won't work)
- Terminal (It's a fake one with just some text now)

## More information:

- [`doc/install.md`](doc/install.md)
- [`doc/notes.md`](doc/notes.md)
