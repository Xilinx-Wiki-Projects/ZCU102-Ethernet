SRC_URI += "file://user_2019-09-23-16-59-00.cfg"
SRC_URI += "file://0001-net-xilinx_phy-Add-flag-to-reset-after-clock-enable.patch"
SRC_URI += "file://0002-net-macb-Handle-phy-reset-for-PCS-PMA-IP.patch"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

