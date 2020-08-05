# PL 10GBASE-R v2019.1

## **Design Summary**

This project utilizes AXI 10G/25G Ethernet Subsystem configured for 10GBASE-R. This has been routed to the SFP cage on SFP2 for use on a ZCU102 board. System is configured to use the ZCU102 si570 at 156.25MHz.

- `eth0` is configured as GEM3 routed via RGMII to the on-board PHY.
- `eth1` is configured as 10G/25G Ethernet Subsystem routed to SFP1.

---

## **Required Hardware**

- ZCU102
- SFP supporting 10GBASE-R
- 10G capable link partner

---

## **Build Instructions**

### **Vivado:**

Enter the `Scripts` directory. From the command line run the following:

`vivado -source *top.tcl`

The Vivado project will be built in the `Hardware` directory.

### **SDK**:

There is currently no baremetal SDK support for the 10G/25G IP.

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
**NOTE:** U-Boot validation for 1G interface only - 10G drivers currently only exist for Kernel.
```
ZynqMP> dhcp
BOOTP broadcast 1
BOOTP broadcast 2
BOOTP broadcast 3
DHCP client bound to address 123.234.10.31 (1047 ms)
ZynqMP> ping 123.234.10.1
Using ethernet@ff0e0000 device
host 123.234.10.1 is alive
ZynqMP>
```
### **Kernel:**
**NOTE:** The interfaces are assigned as follows:
 - `eth0` -> 1G
 - `eth1` -> 10G
```
root@plnx:~# ifconfig
eth0      Link encap:Ethernet  HWaddr DE:AD:BE:EF:00:00
          inet addr:123.234.10.18  Bcast:123.234.10.255  Mask:255.255.255.0
          inet6 addr: fe80::dcad:beff:feef:0/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:53 errors:0 dropped:0 overruns:0 frame:0
          TX packets:113 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:4485 (4.3 KiB)  TX bytes:24804 (24.2 KiB)
          Interrupt:30

eth1      Link encap:Ethernet  HWaddr DE:AD:BE:EF:00:01
          inet addr:123.234.10.19  Bcast:123.234.10.255  Mask:255.255.255.0
          UP BROADCAST RUNNING  MTU:1500  Metric:1
          RX packets:129 errors:0 dropped:0 overruns:0 frame:0
          TX packets:11 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:16124 (15.7 KiB)  TX bytes:2728 (2.6 KiB)

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
64 bytes from 123.234.10.1: seq=0 ttl=64 time=0.252 ms
64 bytes from 123.234.10.1: seq=1 ttl=64 time=0.177 ms
64 bytes from 123.234.10.1: seq=2 ttl=64 time=0.157 ms
64 bytes from 123.234.10.1: seq=3 ttl=64 time=0.171 ms
64 bytes from 123.234.10.1: seq=4 ttl=64 time=0.166 ms
64 bytes from 123.234.10.1: seq=5 ttl=64 time=0.154 ms
64 bytes from 123.234.10.1: seq=6 ttl=64 time=0.164 ms
64 bytes from 123.234.10.1: seq=7 ttl=64 time=0.163 ms
64 bytes from 123.234.10.1: seq=8 ttl=64 time=0.176 ms

--- 123.234.10.1 ping statistics ---
9 packets transmitted, 9 packets received, 0% packet loss
round-trip min/avg/max = 0.154/0.175/0.252 ms
root@plnx:~# ping -I eth1 123.234.10.1 -c 9
PING 123.234.10.1 (123.234.10.1): 56 data bytes
64 bytes from 123.234.10.1: seq=0 ttl=64 time=0.208 ms
64 bytes from 123.234.10.1: seq=1 ttl=64 time=0.183 ms
64 bytes from 123.234.10.1: seq=2 ttl=64 time=0.155 ms
64 bytes from 123.234.10.1: seq=3 ttl=64 time=0.088 ms
64 bytes from 123.234.10.1: seq=4 ttl=64 time=0.148 ms
64 bytes from 123.234.10.1: seq=5 ttl=64 time=0.149 ms
64 bytes from 123.234.10.1: seq=6 ttl=64 time=0.180 ms
64 bytes from 123.234.10.1: seq=7 ttl=64 time=0.177 ms
64 bytes from 123.234.10.1: seq=8 ttl=64 time=0.195 ms

--- 123.234.10.1 ping statistics ---
9 packets transmitted, 9 packets received, 0% packet loss
round-trip min/avg/max = 0.088/0.164/0.208 ms
root@plnx:~#
```

---

## **Known Issues**

---
