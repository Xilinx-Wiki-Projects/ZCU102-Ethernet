# init-ifupdown_%.bbappend content
  
SRC_URI += " \
        file://myinterfaces \
        "
  
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
  
# Overwrite interface file with myinterface file in rootfs
do_install_append() {
     install -m 0644 ${WORKDIR}/myinterfaces ${D}${sysconfdir}/network/interfaces
}