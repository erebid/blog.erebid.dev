---
title: Basic 9front QEMU Setup
date: 2021-11-07
---
The commands assume the following:
* You have `9front.386.iso` in your working directory.
You can get this from the
[9front releases page](http://9front.org/releases/)
* You want the VM to be stored in `$HOME/9front.qcow2.img`.
* You want to use KVM for virtualization.

To boot the VM for installation:
```sh
mkdir -p $HOME/vm
qemu-img create -f qcow2 $HOME/vm/9front.qcow2.img 30G

qemu-system-x86_64 -cpu host -enable-kvm -m 1024 \
-net nic,model=virtio,macaddr=52:54:00:00:EE:03 -net user \
-device virtio-scsi-pci,id=scsi \
-drive if=none,id=vd0,file=$HOME/vm/9front.qcow2.img \
-device scsi-hd,drive=vd0 \
-drive if=none,id=vd1,file=9front.386.iso \
-device scsi-cd,drive=vd1,bootindex=0
```

Follow the install portion of this tutorial by henesy:
{{< youtube PjVpB3SpAfQ >}}

After the install process is complete and you poweroff the VM in the tutorial,
you can use this script to start the VM normally:

```sh
#!/bin/sh
qemu-system-x86_64 -cpu host -enable-kvm -m 1024 \
-net nic,model=virtio,macaddr=52:54:00:00:EE:03 -net user\
,hostfwd=tcp::5640-:564\
,hostfwd=tcp::17019-:17019\
,hostfwd=tcp::5670-:567\
,hostfwd=tcp::17020-:17020 \
-device virtio-scsi-pci,id=scsi \
-drive if=none,id=vd0,file=$HOME/vm/9front.qcow2.img \
-device scsi-hd,drive=vd0
```
It forwards 567 and 564 on the VM to non-privileged ports so that running as
root isn't required.

When henesy uses drawterm in the tutorial,
get [drawterm](http://drawterm.9front.org/) and use
`drawterm -h 'tcp!127.0.0.1!17019' -u glenda -a 'tcp!127.0.0.1!5640'` to connect.
