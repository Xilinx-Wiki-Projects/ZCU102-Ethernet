FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://devtool-fragment.cfg \
            file://0001-net-xilinx_phy-Add-flag-to-reset-after-clock-enable.patch \
            file://0002-net-macb-Handle-phy-reset-for-PCS-PMA-IP.patch"
