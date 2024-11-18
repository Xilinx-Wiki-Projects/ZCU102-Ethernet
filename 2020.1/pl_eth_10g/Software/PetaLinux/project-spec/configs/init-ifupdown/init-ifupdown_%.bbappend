# init-ifupdown_%.bbappend content
#For 2022.1 release onwards
#do_install:append() {
#    sed -i '/iface eth0 inet dhcp/ a auto eth1' ${D}${sysconfdir}/network/interfaces
#}
#For 2021.2 and old releases
do_install_append() {
    sed -i '/iface eth0 inet dhcp/ a auto eth1' ${D}${sysconfdir}/network/interfaces
}

