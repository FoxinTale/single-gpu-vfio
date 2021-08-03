#Full path for this is /etc/libvirt/hooks/qemu.d/win10/prepare/begin/start.sh

# debugging
set -x

# load variables
source "/etc/libvirt/hooks/kvm.conf"

# stop display manager
systemctl stop sddm.service

# Avoid race condition
sleep 5

systemctl set-property --runtime -- user.slice AllowedCPUs=0,6
systemctl set-property --runtime -- system.slice AllowedCPUs=0,6
systemctl set-property --runtime -- init.scope AllowedCPUs=0,6

modprobe -r amdgpu

modprobe -r snd_hda_intel

# unbind gpu
virsh nodedev-detach $VIRSH_GPU_VIDEO
virsh nodedev-detach $VIRSH_GPU_AUDIO
