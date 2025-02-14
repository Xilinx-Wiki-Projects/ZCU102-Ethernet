SRC_URI:append = " ${@" ".join(["file://%s" % f for f in (d.getVar('EXTRA_DT_FILES') or "").split()])}"

# We need the deployed output
PROC_TUNE:versal = "cortexa72"
PROC_TUNE:zynqmp = "cortexa53"
APU_DT_FILE_NAME ?= "${PROC_TUNE}-${SOC_FAMILY}-linux.dts"

EXTRA_DT_FILES ??= ""
EXTRA_DTFILE_PREFIX ??= "system"
EXTRA_DTFILES_BUNDLE ??= ""

do_configure:append () {
	if ! grep -e "^/include/ \"system-user.dtsi\"$" "${DT_FILES_PATH}/${APU_DT_FILE_NAME}"; then
		echo "/include/ \"system-user.dtsi\"" >> ${DT_FILES_PATH}/${APU_DT_FILE_NAME}
	fi
	for f in ${EXTRA_DT_FILES}; do
		cp ${WORKDIR}/${f} ${DT_FILES_PATH}/
	done
}

devicetree_do_compile:append() {
    import subprocess

    apu_dt_file = d.getVar('APU_DT_FILE_NAME').replace('.dts', '.dtb') or ''
    if not apu_dt_file or not os.path.isfile(apu_dt_file):
        return

    if d.getVar('EXTRA_DTFILES_BUNDLE'):
        ccdtb_prefix = d.getVar('EXTRA_DTFILE_PREFIX')
        extra_dt_files = d.getVar('EXTRA_DT_FILES').split() or []
        for dtsfile in extra_dt_files:
            dtname = os.path.splitext(os.path.basename(dtsfile))[0]
            if os.path.isfile(f"{dtname}.dtbo"):
                fdtargs = ["fdtoverlay", "-o", f"{ccdtb_prefix}-{dtname}.dtb", "-i", apu_dt_file, f"{dtname}.dtbo"]
                bb.note("Running {0}".format(" ".join(fdtargs)))
                subprocess.run(fdtargs, check = True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
}
