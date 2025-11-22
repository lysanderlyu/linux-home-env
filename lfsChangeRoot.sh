mount -v --bind /dev $LFS/dev &&
mount -vt devpts devpts -o gid=5,mode=0620 $LFS/dev/pts &&
mount -vt proc proc $LFS/proc &&
mount -vt sysfs sysfs $LFS/sys &&
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
    install -v -d -m 1777 $LFS$(realpath /dev/shm)
else
    mount -vt tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm
fi

sudo chroot "$LFS" /usr/bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin \
    MAKEFLAGS="-j10" \
    TESTSUITEFLAGS="-j10" \
    /bin/bash --login


umount  $LFS/dev/pts &&
umount  $LFS/dev/shm &&
umount  $LFS/dev &&
umount  $LFS/proc &&
umount  $LFS/sys &&
umount  $LFS/run
