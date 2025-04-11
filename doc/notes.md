# Notes on AVF and the Terminal app

## Source code

The source code of everything is available: <https://cs.android.com/android/platform/superproject/main/+/main:packages/modules/Virtualization/>

It's not clear what version of this was shipped to Android 15 Pixel phones around March 2025.

## crosvm

Android AVF seems to be based on crosvm.

## Terminal

It's a web terminal, based on ttyd: <https://github.com/tsl0922/ttyd>

The Terminal app has a WebView essentially showing `https://192.168.0.2:7681`.

The guest runs ttyd with HTTPS on port 7681 with a self-signed certificate, and authenticates the client (in this case, the Terminal app) using a client certificate, which is hidden in the app, presumably so that other apps cannot just connect to it.

## Filesystems

The OS consists of two partitions:

- `/dev/vda1`: Ext4 root image
- `/dev/vda2`: FAT32 EFI system partition

It seems to be assembled into one full GPT image by *something* and provided to the VM as a virtio-blk device. `/dev/vda1` is writable, whereas `/dev/vda2` throws IO errors on write (kernel complains, check `dmesg`)

Moreover, two Virtiofs file shares are available:

- `internal` mounted at `/mnt/internal` for communicating files between the VM and the app
- `android` mounted at `/mnt/shared` is the host's download directory

Funnily, the two images are found in `/mnt/internal`:

- `/dev/vda1` is `/mnt/internal/root_part`
- `/dev/vda2` is `/mnt/internal/efi_part`

And `/mnt/internal/efi_part` *is* writable.

## gRPC

The app runs a "debian service". The guest has various daemons talking to it with gRPC.

## Networking

Host is `192.168.0.1`, guest is `192.168.0.2`.

The guest can get an address via DHCP.

Port forwarding is implemented in userspace. A daemon in the guest watches open ports in the guest, and notifies the host about them. When you enable forwarding for a port, the host forwards TCP connections to VSOCK, and a guest daemon forwards VSOCK connections to TCP.
