# PL SGMII v2019.1

## **Design Summary**

This project utilizes AXI 1G/2.5G Ethernet Subsystem configured for SGMII. This has been routed to the SFP cage on SFP1 for use on a ZCU102 board. System is configured to use the ZCU102 si570 at 156.25MHz.

---

## **Required Hardware**

- ZCU102
- SFP module supporting SGMII

---

## **Build Instructions**

### **Vivado:**

Enter the `Scripts` directory. From the command line run the following:

`vivado -source *top.tcl`

The Vivado project will be built in the `Hardware` directory.

### **SDK**:

To build the Baremetal Example Applications for this project, create a new SDK project in the `Software/SDK` directory. Once created, import the hardware definition file from your Vivado export location.

You can now create a new application project. Select `File > New > New Application Project`

SDK offers several Ethernet-based example application projects which leverage the LwIP Library. These can be selected on the second page of the New Application Project dialogue.

### **PetaLinux**:

Enter the `Software/PetaLinux/` directory. From the command line run the following:

`petalinux-build`

The PetaLinux project will be rebuilt using the configurations in the PetaLinux directory. To reduce repo size, the project is shipped pre-configured, but un-built.

Once the build is complete, the built images can be found in the `PetaLinux/images/linux/`
directory. To package these images for SD boot, run the following from the `PetaLinux` directory:

`petalinux-package --boot --fsbl images/linux/zynqmp_fsbl.elf --fpga images/linux/*.bit --pmufw images/linux/pmufw.elf --u-boot --force`

Once packaged, the `BOOT.bin` and `image.ub` files (in the `PetaLinux/images/linux` directory) can be copied to an SD card, and used to boot.

---

## **Validation**
### **U-Boot:**
NOTE: U-Boot validation results are not available

### **Kernel:**
```
root@plnx:~# ethtool -s eth0 speed 1000 duplex full autoneg off
root@plnx:~# [   38.161323] xilinx_axienet 80000000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off

root@plnx:~# udhcpc -i eth0
udhcpc: started, v1.29.2
udhcpc: sending discover
udhcpc: sending select for 123.234.10.18
udhcpc: lease of 123.234.10.18 obtained, lease time 600
root@plnx:~# ping 123.234.10.1 -c 9
PING 123.234.10.1 (123.234.10.1): 56 data bytes
64 bytes from 123.234.10.1: seq=0 ttl=64 time=0.374 ms
64 bytes from 123.234.10.1: seq=1 ttl=64 time=0.236 ms
64 bytes from 123.234.10.1: seq=2 ttl=64 time=0.167 ms
64 bytes from 123.234.10.1: seq=3 ttl=64 time=0.150 ms
64 bytes from 123.234.10.1: seq=4 ttl=64 time=0.235 ms
64 bytes from 123.234.10.1: seq=5 ttl=64 time=0.191 ms
64 bytes from 123.234.10.1: seq=6 ttl=64 time=0.265 ms
64 bytes from 123.234.10.1: seq=7 ttl=64 time=0.201 ms
64 bytes from 123.234.10.1: seq=8 ttl=64 time=0.127 ms

--- 123.234.10.1 ping statistics ---
9 packets transmitted, 9 packets received, 0% packet loss
round-trip min/avg/max = 0.127/0.216/0.374 ms
root@plnx:~#

```
---

## **Known Issues**

---
