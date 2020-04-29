# Example Design Template

## **Design Summary**

This project is a template for creating your own example design repositories. A repository might be comprised of one or more of these projects. This is also a good section to describe where certain signals are routed at a high-level. For example: "The 1G AXI Ethernet signal is routed to the ZCU102 SFP cage on SFP0".

NOTE: the build instructions are universal if you use this template, so you don't have to edit that section.

---

## **Required Hardware**

In this section, describe the generalized required hardware to run the example design. This includes:
- Boards
- Cables
- Expansion Cards
- Network Adapters
- SFP Modules
- Etc

Description of the exact HW configuration used for testing will go in the **Validation** section.

---

## **Build Instructions**

### **Vivado:**

Enter the `Scripts` directory. From the command line run the following:

`vivado -source *top.tcl`

The Vivado project will be built in the `Hardware` directory.

### **PetaLinux**:

Enter the `Software/PetaLinux/` directory. From the command line run the following:

`petalinux-build`

The PetaLinux project will be rebuilt using the configurations in the PetaLinux directory. To reduce repo size, the project is shipped pre-configured, but un-built.

Once the build is complete, the built images can be found in the `plnx/images/linux/` directory. To package these images for SD boot, run the following from the `plnx` directory:

`petalinux-package --boot --fsbl images/linux/zynqmp_fsbl.elf --fpga images/linux/*.bit --pmufw images/linux/pmufw.elf --u-boot --force`

Once packaged, the `BOOT.bin` and `image.ub` files (in the `plnx/images/linux` directory) can be copied to an SD card, and used to boot.

---

## **Validation**

Here you will place example validation that you've done that the customer can repeat, along with the exact hardware used for validation. This improves confidence in the design, and gives a good test for the customer to run initially. Shown below are U-Boot and Kernel examples:

### **Validation Hardware:**
- Board
- Adapters
- Cables
- Etc

### **U-Boot:**
```
ZynqMP> example_command
example_command success
ZynqMP>
```

### **Kernel:**
```
root@plnx:~# example_command
example_command success
root@plnx:~#
```

---

## **Known Issues**
In this section, list any known issues with the design, or any warning messages that might appear which can be safely ignored by the customer.

---
