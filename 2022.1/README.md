# ZCU102 PS and PL based 1G/10G Ethernet v2022.1
This repository contains ZCU102 design files for PS and PL based 1G/10G Ethernet.

There are 6 available designs:

- **pl_eth_1g** - PL 1000BASE-X design utilizing the AXI Ethernet 1G/2.5G Subsystem.

- **pl_eth_sgmii** - PL SGMII design utilizing the AXI Ethernet 1G/2.5G Subsystem.

- **pl_eth_10g** - PL 10GBASE-R design utilizing the AXI Ethernet 10G/25G Subsystem.

- **ps_emio_eth_1g** - PS 1000BASE-X design utilizing the GEM over EMIO to a 1G/2.5G Ethernet PCS/PMA or SGMII IP.

- **ps_emio_eth_1g** - PS SGMII design utilizing the GEM over EMIO to a 1G/2.5G Ethernet PCS/PMA or SGMII IP.

- **ps_mio_eth_1g** - PS 10/100/1000BASE-T design utilizing the GEM over MIO to the TI DP83867 PHY onboard the ZCU102.
---
## **What to Expect**
Each design directory contains the following general structure:

```
<design>
├── Hardware
│   └── constraints
│       └── <design>.xdc
├── README.md
├── Scripts
│   ├── <design>.ui
│   ├── <design>_bd.tcl
│   └── <design>_top.tcl
└── Software
    ├── Vitis
    └── PetaLinux

````
Each design's `README.md` will provide:

- **Design Summary** - Brief summary of the design.

- **Required Hardware** - Listing of required hardware

- **Build Instructions** - Instructions on how to re-build the designs

- **Validation** - Setup and results of validation tests run against the design

- **Known Issues** - Current known issues with the design and/or workarounds for these issues.

---
## **Troubleshooting / Assistance**
If you find you are having difficulty bringing up one of the designs, or need some additional assistance, please reach out on the [Xilinx Community Forums](https://forums.xilinx.com).

Be sure to [search](https://forums.xilinx.com/t5/forums/searchpage/tab/message?advanced=false&allow_punctuation=false&inactive=false) the forums first before posting, as someone may already have the solution!

---
