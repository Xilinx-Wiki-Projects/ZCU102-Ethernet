# PL 10GBASE-R v2019.2

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

### **Vitis**:

There is currently no baremetal Vitis support for the 10G/25G IP.

### **PetaLinux**:

Enter the `Software/PetaLinux/` directory. From the command line run the following:

`petalinux-config --get-hw-description ../../Hardware/pre-built/ --silentconfig`

followed by:

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
ethernet@ff0e0000 Waiting for PHY auto negotiation to complete. done
BOOTP broadcast 1
BOOTP broadcast 2
BOOTP broadcast 3
DHCP client bound to address 123.234.1.70 (1259 ms)
ZynqMP> ping 123.234.1.1
Using ethernet@ff0e0000 device
host 123.234.1.1 is alive
ZynqMP>
```
### **Kernel:**
**NOTE:** The interfaces are assigned as follows:
 - `eth0` -> 1G
 - `eth1` -> 10G
```
root@plnx:~# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:0A:35:00:22:01
          inet addr:123.234.1.10  Bcast:123.234.1.255  Mask:255.255.255.0
          inet6 addr: fe80::20a:35ff:fe00:2201/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:4 errors:0 dropped:0 overruns:0 frame:0
          TX packets:20 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:750 (750.0 B)  TX bytes:3358 (3.2 KiB)
          Interrupt:30

eth1      Link encap:Ethernet  HWaddr 00:0A:35:00:00:01
          inet addr:123.234.10.13  Bcast:123.234.10.255  Mask:255.255.255.0
          UP BROADCAST RUNNING  MTU:1500  Metric:1
          RX packets:48 errors:0 dropped:0 overruns:0 frame:0
          TX packets:14 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:3446 (3.3 KiB)  TX bytes:3480 (3.3 KiB)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:14 errors:0 dropped:0 overruns:0 frame:0
          TX packets:14 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1176 (1.1 KiB)  TX bytes:1176 (1.1 KiB)

root@plnx:~# ping 123.234.1.1
PING 123.234.1.1 (123.234.1.1): 56 data bytes
64 bytes from 123.234.1.1: seq=0 ttl=64 time=0.291 ms
64 bytes from 123.234.1.1: seq=1 ttl=64 time=0.288 ms
64 bytes from 123.234.1.1: seq=2 ttl=64 time=0.208 ms
64 bytes from 123.234.1.1: seq=3 ttl=64 time=0.265 ms
64 bytes from 123.234.1.1: seq=4 ttl=64 time=0.285 ms
64 bytes from 123.234.1.1: seq=5 ttl=64 time=0.249 ms
64 bytes from 123.234.1.1: seq=6 ttl=64 time=0.283 ms
64 bytes from 123.234.1.1: seq=7 ttl=64 time=0.280 ms
64 bytes from 123.234.1.1: seq=8 ttl=64 time=0.284 ms
^C
--- 123.234.1.1 ping statistics ---
9 packets transmitted, 9 packets received, 0% packet loss
round-trip min/avg/max = 0.208/0.270/0.291 ms
root@plnx:~# ping 123.234.10.1
PING 123.234.10.1 (123.234.10.1): 56 data bytes
64 bytes from 123.234.10.1: seq=0 ttl=64 time=0.265 ms
64 bytes from 123.234.10.1: seq=1 ttl=64 time=0.279 ms
64 bytes from 123.234.10.1: seq=2 ttl=64 time=0.205 ms
64 bytes from 123.234.10.1: seq=3 ttl=64 time=0.274 ms
64 bytes from 123.234.10.1: seq=4 ttl=64 time=0.279 ms
64 bytes from 123.234.10.1: seq=5 ttl=64 time=0.272 ms
64 bytes from 123.234.10.1: seq=6 ttl=64 time=0.281 ms
64 bytes from 123.234.10.1: seq=7 ttl=64 time=0.194 ms
64 bytes from 123.234.10.1: seq=8 ttl=64 time=0.276 ms
64 bytes from 123.234.10.1: seq=9 ttl=64 time=0.250 ms
^C
--- 123.234.10.1 ping statistics ---
10 packets transmitted, 10 packets received, 0% packet loss
round-trip min/avg/max = 0.194/0.257/0.281 ms
root@plnx:~#
```
### **Performance:**
**NOTE:** These are rough performance numbers - your actual performance may vary based on a variety of factors such as network topology and kernel load.

These performance numbers reflect an MTU of 9000.
```
root@plnx:~# iperf3 -c 123.234.10.1
Connecting to host 123.234.10.1, port 5201
[  5] local 123.234.10.19 port 35430 connected to 123.234.10.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   381 MBytes  3.19 Gbits/sec    0    472 KBytes
[  5]   1.00-2.00   sec   381 MBytes  3.20 Gbits/sec    0    472 KBytes
[  5]   2.00-3.00   sec   381 MBytes  3.20 Gbits/sec    0    472 KBytes
[  5]   3.00-4.00   sec   381 MBytes  3.20 Gbits/sec    0    472 KBytes
[  5]   4.00-5.00   sec   381 MBytes  3.20 Gbits/sec    0    472 KBytes
[  5]   5.00-6.00   sec   381 MBytes  3.20 Gbits/sec    0    472 KBytes
[  5]   6.00-7.00   sec   379 MBytes  3.17 Gbits/sec    0    472 KBytes
[  5]   7.00-8.00   sec   378 MBytes  3.17 Gbits/sec    0    472 KBytes
[  5]   8.00-9.00   sec   378 MBytes  3.17 Gbits/sec    0    472 KBytes
[  5]   9.00-10.00  sec   378 MBytes  3.16 Gbits/sec    0    472 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  3.71 GBytes  3.19 Gbits/sec    0             sender
[  5]   0.00-10.00  sec  3.71 GBytes  3.19 Gbits/sec                  receiver

iperf Done.
root@plnx:~#
```
---

## **Known Issues**

---
