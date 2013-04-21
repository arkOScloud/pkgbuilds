# Create initial environment and install base packages
mkdir -p $1
echo -e "\033[1mInstalling packages...\033[0m"
mkdir -p $1/var/lib/pacman
pacman -Syy --force --noconfirm --noprogressbar -r $1 base base-devel binutils dosfstools dialog e2fsprogs genesis ifplugd iptables linux linux-headers localepurge mkinitcpio mkinitcpio-busybox netctl ntp openssh raspberrypi-firmware syslog-ng systemd wpa_supplicant wpa_actiond wget 

# Add root password and set up special files
echo -e "\033[1mSetting the password to 'root' and cleaning up:\033[0m"
echo -e "root\nroot\n" | chroot $1/ /usr/bin/passwd root
rm $1/dev/{null}
chroot $1/ mknod -m 600 /dev/console c 5 1
chroot $1/ mknod -m 666 /dev/null c 1 3
chroot $1/ mknod -m 666 /dev/zero c 1 5
chroot $1/ mknod -m 0644 /dev/random c 1 8
chroot $1/ mknod -m 0644 /dev/urandom c 1 9

# Create manpages DB (this can take awhile)
chroot $1/ /usr/bin/mandb --quiet

# Generate locale
rm $1/etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> $1/etc/locale.gen
echo "en_US ISO-8859-1" >> $1/etc/locale.gen
chroot $1/ /usr/bin/locale-gen

# Purge excess locales
echo "MANDELETE" >> $1/etc/locale.nopurge
echo "en_US" >> $1/etc/locale.nopurge
echo "en_US.UTF-8" >> $1/etc/locale.nopurge
chroot $1/ /usr/sbin/localepurge.config
chroot $1/ /usr/sbin/localepurge

# Set timezone to UTC by default
chroot $1/ ln -s /usr/share/zoneinfo/UTC etc/localtime

# Add basic file for automatic ethernet connection on startup
echo "Connection='ethernet'" >> $1/etc/netctl/ethernet
echo "Description='A basic dhcp ethernet connection using iproute'" >> $1/etc/network.d/ethernet-eth0
echo "Interface='eth0'" >> $1/etc/netctl/ethernet
echo "IP='dhcp'" >> $1/etc/netctl/ethernet

echo "arkos" >> $1/etc/hostname

# Enable important system services on startup
chroot $1/ ln -s '/usr/lib/systemd/system/sshd.service' '$1/etc/systemd/system/multi-user.target.wants/sshd.service'
chroot $1/ ln -s '/usr/lib/systemd/system/ntpd.service' '$1/etc/systemd/system/multi-user.target.wants/ntpd.service'
chroot $1/ netctl enable ethernet

# Clear pacman cache files
chroot $1/ yes | /usr/bin/pacman -Scc

echo "Complete. Your rootfs is located at $1. Enjoy!"