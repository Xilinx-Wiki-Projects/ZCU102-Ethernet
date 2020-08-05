# PS 10/100/1000BASE-T via MIO v2019.2

## **Design Summary**

This project utilizes GEM3 configured for RGMII via MIO. This has been routed to the on-board TI DP83867 PHY found on the ZCU102.

---

## **Required Hardware**
- ZCU102
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
```
ZynqMP> dhcp
BOOTP broadcast 1
BOOTP broadcast 2
BOOTP broadcast 3
DHCP client bound to address 123.234.1.70 (1009 ms)
ZynqMP> ping 123.234.1.1
Using ethernet@ff0e0000 device
host 123.234.1.1 is alive
ZynqMP>
```
### **Kernel:**
```
root@plnx:~# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:0A:35:00:22:01
          inet addr:123.234.1.10  Bcast:123.234.1.255  Mask:255.255.255.0
          inet6 addr: fe80::20a:35ff:fe00:2201/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:4 errors:0 dropped:0 overruns:0 frame:0
          TX packets:13 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:750 (750.0 B)  TX bytes:1780 (1.7 KiB)
          Interrupt:30

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

root@plnx:~# ping 123.234.1.1
PING 123.234.1.1 (123.234.1.1): 56 data bytes
64 bytes from 123.234.1.1: seq=0 ttl=64 time=0.262 ms
64 bytes from 123.234.1.1: seq=1 ttl=64 time=0.214 ms
64 bytes from 123.234.1.1: seq=2 ttl=64 time=0.231 ms
64 bytes from 123.234.1.1: seq=3 ttl=64 time=0.296 ms
64 bytes from 123.234.1.1: seq=4 ttl=64 time=0.231 ms
64 bytes from 123.234.1.1: seq=5 ttl=64 time=0.248 ms
64 bytes from 123.234.1.1: seq=6 ttl=64 time=0.266 ms
^C
--- 123.234.1.1 ping statistics ---
7 packets transmitted, 7 packets received, 0% packet loss
round-trip min/avg/max = 0.214/0.249/0.296 ms
root@plnx:~#
```
---

## **Known Issues**

---