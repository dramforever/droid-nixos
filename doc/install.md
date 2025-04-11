# Installation

**This is not a step by step guide.** It is only a rough documentation of what I tried.

## Prerequisites

As of April 2025, an android device having "Linux development environment" available and enabled in developer settings. It should be available on Pixel 6 and later with up-to-date software. You should have a "Terminal" app.

## Installation steps

All of these steps are done on the guest.

For convenience, consider using Termux on your host and SSH into the virtual machine.

### Install Nix

```console
$ sh <(curl -L https://nixos.org/nix/install) --daemon
```

### Build the config

Edit `configuration.nix` and change the SSH key to your own.

In the repo top level directory:

```
$ nix build --extra-experimental-features 'nix-command flakes' -j3 .#droid-nixos
```

You should get a `result` symlink.

### Set up first boot

Set up `/etc/NIXOS_LUSTRATE`

```
$ sudo touch /etc/NIXOS_LUSTRATE
```

**Warning**: From this step onwards, the Debian installation will not be recoverable. If anything goes wrong you may have to turn go to developer settings and turn it off and back on to reset the app.

Edit `/boot/grub/grub.cfg` to replace the `linux` and `initrd` lines in the default boot entry. For convenience, the `gengrub.sh` file generates the two lines based on the `result` symlink.

```
$ sudo vim /boot/grub/grub.cfg  # Or other editor
```

### Reboot and pray

```
$ sudo reboot
```

Hope that it works! If you get "unrecoverable error", try killing the Terminal app and starting it again, it might work the second time.

### Horray

Instead of the terminal from before, you should see a line of text

```
Welcome to NixOS
```
