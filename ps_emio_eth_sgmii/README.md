# PS SGMII via EMIO v2019.2

## **Design Summary**

This project utilizes PS-GEM over EMIO to a 1G/2.5G Ethernet PCS/PMA or SGMII core. The core is configured for SGMII operation. This has been routed to the SFP cage on SFP1 for use on a ZCU102 board. System is configured to use the ZCU102 si570 at 156.25MHz.

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

### **Vitis**:

To build the Baremetal Example Applications for this project, create a new Vitis workspace in the `Software/Vitis` directory. Once created, build a new platform project targeting your exported xsa file from Vivado.

You can now create a new application project. Select `File > New > New Application Project`

Vitis offers several Ethernet-based example application projects which leverage the LwIP Library. These can be selected on the second page of the New Application Project dialogue.

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
root@plnx:~# [   41.677616] macb ff0b0000.ethernet eth0: unable to generate target frequency: 125000000 Hz
[   41.685886] macb ff0b0000.ethernet eth0: link up (1000/Full)

root@plnx:~# udhcpc -i eth0
udhcpc: started, v1.29.2
udhcpc: sending discover
udhcpc: sending select for 123.234.10.18
udhcpc: lease of 123.234.10.18 obtained, lease time 600
root@plnx:~# ping 123.234.10.1 -c 9
PING 123.234.10.1 (123.234.10.1): 56 data bytes
64 bytes from 123.234.10.1: seq=0 ttl=64 time=0.255 ms
64 bytes from 123.234.10.1: seq=1 ttl=64 time=0.181 ms
64 bytes from 123.234.10.1: seq=2 ttl=64 time=0.219 ms
64 bytes from 123.234.10.1: seq=3 ttl=64 time=0.233 ms
64 bytes from 123.234.10.1: seq=4 ttl=64 time=0.196 ms
64 bytes from 123.234.10.1: seq=5 ttl=64 time=0.160 ms
64 bytes from 123.234.10.1: seq=6 ttl=64 time=0.231 ms
64 bytes from 123.234.10.1: seq=7 ttl=64 time=0.185 ms
64 bytes from 123.234.10.1: seq=8 ttl=64 time=0.167 ms

--- 123.234.10.1 ping statistics ---
9 packets transmitted, 9 packets received, 0% packet loss
round-trip min/avg/max = 0.160/0.203/0.255 ms
root@plnx:~#
```
---

## **Known Issues**

On boot, the following error will be seen:

`[    6.929736] macb ff0b0000.ethernet eth0: unable to generate target frequency: 125000000 Hz
`

This can be safely ignored.

---
