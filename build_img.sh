#!/bin/bash
IMAGE=windows-server-2012-r2.qcow2
FLOPPY=Autounattend.vfd
VIRTIO_ISO=../iso/virtio-win-0.1-81.iso
ISO=../iso/9600.17050.WINBLUE_REFRESH.140317-1640_X64FRE_SERVER_EVAL_RU-RU-IR3_SSS_X64FREE_RU-RU_DV9.ISO

KVM=/usr/libexec/qemu-kvm
if [ ! -f "$KVM" ]; then
    KVM=/usr/bin/qemu-kvm
fi

qemu-img create -f qcow2 -o preallocation=metadata $IMAGE 16G

$KVM -m 2048 -smp 2 -cdrom $ISO -drive file=$VIRTIO_ISO,index=3,media=cdrom -fda $FLOPPY $IMAGE -boot d -vga std -k en-us -vnc :1
