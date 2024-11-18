do_install_append() {
    sed -i '/iface eth0 inet dhcp/ a auto eth1' ${D}${sysconfdir}/network/interfaces
}
