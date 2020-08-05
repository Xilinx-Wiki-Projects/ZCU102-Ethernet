# PS 1000BASE-X via EMIO v2019.1

## **Design Summary**

This project utilizes PS-GEM over EMIO to a 1G/2.5G Ethernet PCS/PMA or SGMII core. The core is configured for 1000BASE-X operation. This has been routed to the SFP cage on SFP0 for use on a ZCU102 board. System is configured to use the ZCU102 si570 at 156.25MHz.

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
```
ZynqMP> dhcp
ethernet@ff0b0000 Waiting for PHY auto negotiation to complete. done
BOOTP broadcast 1
BOOTP broadcast 2
BOOTP broadcast 3
DHCP client bound to address 123.234.10.32 (1297 ms)
ZynqMP> ping 123.234.10.1
Using ethernet@ff0b0000 device
host 123.234.10.1 is alive
ZynqMP>
```
### **Kernel:**
```
root@plnx:~# ifconfig
eth0      Link encap:Ethernet  HWaddr DE:AD:BE:EF:00:00
          inet addr:123.234.10.18  Bcast:123.234.10.255  Mask:255.255.255.0
          inet6 addr: fe80::dcad:beff:feef:0/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:64 errors:0 dropped:0 overruns:0 frame:0
          TX packets:73 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:4170 (4.0 KiB)  TX bytes:12088 (11.8 KiB)
          Interrupt:29

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

root@plnx:~# ping -I eth0 123.234.10.1 -c 9
PING 123.234.10.1 (123.234.10.1): 56 data bytes
64 bytes from 123.234.10.1: seq=0 ttl=64 time=0.239 ms
64 bytes from 123.234.10.1: seq=1 ttl=64 time=0.134 ms
64 bytes from 123.234.10.1: seq=2 ttl=64 time=0.146 ms
64 bytes from 123.234.10.1: seq=3 ttl=64 time=0.138 ms
64 bytes from 123.234.10.1: seq=4 ttl=64 time=0.150 ms
64 bytes from 123.234.10.1: seq=5 ttl=64 time=0.193 ms
64 bytes from 123.234.10.1: seq=6 ttl=64 time=0.213 ms
64 bytes from 123.234.10.1: seq=7 ttl=64 time=0.142 ms
64 bytes from 123.234.10.1: seq=8 ttl=64 time=0.138 ms

--- 123.234.10.1 ping statistics ---
9 packets transmitted, 9 packets received, 0% packet loss
round-trip min/avg/max = 0.134/0.165/0.239 ms
root@plnx:~#
```
---

## **Known Issues**

On boot, the following error will be seen:

`[    6.929736] macb ff0b0000.ethernet eth0: unable to generate target frequency: 125000000 Hz
`

This can be safely ignored.

---
