# PL 1000BASE-X
## **Design Summary**

This project utilizes AXI 1G/2.5G Ethernet Subsystem configured for 1000BASE-X. This has been routed to the SFP cage on SFP1 for use on a ZCU102 board. System is configured to use the ZCU102 si570 at 156.25MHz.

---

## **Required Hardware** 

- ZCU102
- SFP module supporting 1000BASE-X

---

## **Build Instructions** 

### **Vivado:**

Enter the `Scripts` directory. From the command line run the following:

`vivado -source *top.tcl`

The Vivado project will be built in the `Hardware` directory.

### **PetaLinux**:

Enter the `Software` directory. From the command line run the following:

`petalinux-create -t project -s *.bsp`

The PetaLinux project will be created under the `plnx` directory. To reduce file size, the project is shipped pre-configured, but un-built.

To build the PetaLinux project, run the following from the `plnx` directory:

`petalinux-build`

Once complete, the built images can be found in the `plnx/images/linux/` directory. To package these images for SD boot, run the following from the `plnx` directory:

`petalinux-package --boot --fsbl images/linux/zynqmp_fsbl.elf --fpga images/linux/*.bit --pmufw images/linux/pmufw.elf --u-boot --force`

Once packaged, the `BOOT.bin` and `image.ub` files (in the `plnx/images/linux` directory) can be copied to an SD card, and used to boot.

---

## **Validation**

---

## **Known Issues**

---
