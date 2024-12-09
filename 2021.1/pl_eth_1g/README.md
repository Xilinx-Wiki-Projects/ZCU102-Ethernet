# PL 1000BASE-X v2021.1

## **Design Summary**

This project utilizes AXI 1G/2.5G Ethernet Subsystem configured for 1000BASE-X. This has been routed to the SFP cage on SFP0 for use on a ZCU102 board. System is configured to use the ZCU102 si570 at 156.25MHz.

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

### **Vitis**:

To build the Baremetal Example Applications for this project, create a new Vitis workspace in the `Software/Vitis` directory. Once created, build a new platform project targeting your exported xsa file from Vivado.

You can now create a new application project. Select `File > New > New Application Project`

Vitis offers several Ethernet-based example application projects which leverage the LwIP Library. These can be selected on the second page of the New Application Project dialogue.

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
```
ZynqMP> dhcp
ethernet@80000000 Waiting for PHY auto negotiation to complete...... done
BOOTP broadcast 1
BOOTP broadcast 2
BOOTP broadcast 3
DHCP client bound to address 123.234.1.70 (1256 ms)
ZynqMP> ping 123.234.1.1
ethernet@80000000 Waiting for PHY auto negotiation to complete...... done
Using ethernet@80000000 device
host 123.234.1.1 is alive
ZynqMP>
```

### **Kernel:**
```
root@plnx:~# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:0A:35:00:22:01
          inet addr:123.234.1.10  Bcast:123.234.1.255  Mask:255.255.255.0
          inet6 addr: fe80::20a:35ff:fe00:2201/64 Scope:Link
          UP BROADCAST RUNNING  MTU:1500  Metric:1
          RX packets:4 errors:0 dropped:0 overruns:0 frame:0
          TX packets:12 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:806 (806.0 B)  TX bytes:1648 (1.6 KiB)

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
64 bytes from 123.234.1.1: seq=0 ttl=64 time=0.218 ms
64 bytes from 123.234.1.1: seq=1 ttl=64 time=0.187 ms
64 bytes from 123.234.1.1: seq=2 ttl=64 time=0.189 ms
64 bytes from 123.234.1.1: seq=3 ttl=64 time=0.250 ms
64 bytes from 123.234.1.1: seq=4 ttl=64 time=0.211 ms
64 bytes from 123.234.1.1: seq=5 ttl=64 time=0.209 ms
64 bytes from 123.234.1.1: seq=6 ttl=64 time=0.177 ms
64 bytes from 123.234.1.1: seq=7 ttl=64 time=0.220 ms
64 bytes from 123.234.1.1: seq=8 ttl=64 time=0.213 ms
64 bytes from 123.234.1.1: seq=9 ttl=64 time=0.179 ms
64 bytes from 123.234.1.1: seq=10 ttl=64 time=0.257 ms
^C
--- 123.234.1.1 ping statistics ---
11 packets transmitted, 11 packets received, 0% packet loss
round-trip min/avg/max = 0.177/0.210/0.257 ms
root@plnx:~#
```
### **Performance:**
**NOTE:** These are rough performance numbers - your actual performance may vary based on a variety of factors such as network topology and kernel load.

These performance numbers reflect an MTU of 9000.
```
root@plnx:~# iperf3 -c 123.234.10.1
Connecting to host 123.234.10.1, port 5201
[  5] local 123.234.10.18 port 36440 connected to 123.234.10.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   119 MBytes   999 Mbits/sec    0    411 KBytes
[  5]   1.00-2.00   sec   118 MBytes   993 Mbits/sec    0    411 KBytes
[  5]   2.00-3.00   sec   118 MBytes   991 Mbits/sec    0    411 KBytes
[  5]   3.00-4.00   sec   118 MBytes   987 Mbits/sec    0    411 KBytes
[  5]   4.00-5.00   sec   118 MBytes   991 Mbits/sec    0    411 KBytes
[  5]   5.00-6.00   sec   118 MBytes   992 Mbits/sec    0    411 KBytes
[  5]   6.00-7.00   sec   118 MBytes   990 Mbits/sec    0    411 KBytes
[  5]   7.00-8.00   sec   118 MBytes   988 Mbits/sec    0    411 KBytes
[  5]   8.00-9.00   sec   118 MBytes   990 Mbits/sec    0    411 KBytes
[  5]   9.00-10.00  sec   118 MBytes   990 Mbits/sec    0    411 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  1.15 GBytes   991 Mbits/sec    0             sender
[  5]   0.00-10.00  sec  1.15 GBytes   990 Mbits/sec                  receiver

iperf Done.
root@plnx:~#
```
---

## **Known Issues**

---
