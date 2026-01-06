# ZCU102 PS and PL based 1G/10G Ethernet
This repository contains ZCU102 design files for PS and PL based 1G/10G Ethernet on a rolling release.

There are 6 available designs:

- **pl_eth_1g** - PL 1000BASE-X design utilizing the AXI Ethernet 1G/2.5G Subsystem.

- **pl_eth_sgmii** - PL SGMII design utilizing the AXI Ethernet 1G/2.5G Subsystem.

- **pl_eth_10g** - PL 10GBASE-R design utilizing the AXI Ethernet 10G/25G Subsystem.

- **ps_emio_eth_1g** - PS 1000BASE-X design utilizing the GEM over EMIO to a 1G/2.5G Ethernet PCS/PMA or SGMII IP.

- **ps_emio_eth_sgmii** - PS SGMII design utilizing the GEM over EMIO to a 1G/2.5G Ethernet PCS/PMA or SGMII IP.

- **ps_mio_eth_1g** - PS 10/100/1000BASE-T design utilizing the GEM over MIO to the TI DP83867 PHY onboard the ZCU102.

---
## **Getting Started**

### Cloning the Repository

To get started with these designs, clone this repository to your local machine:

```bash
git clone https://github.com/Xilinx-Wiki-Projects/ZCU102-Ethernet.git
cd ZCU102-Ethernet
```

### Working with Tagged Versions

This repository uses a rolling release model with tagged commits for version management. Each Xilinx tool version is marked with Start of Life (SOL) and End of Life (EOL) tags.

#### Viewing Available Tags

To see all available tagged versions:

```bash
git tag -l
```

This will display tags such as `xilinx-v2023.1-SOL`, `xilinx-v2023.2-SOL`, `xilinx-v2024.1-SOL`, etc.

#### Checking Out a Specific Version

To work with a specific version, checkout the corresponding SOL tag:

```bash
# Checkout a specific version (e.g., 2024.1)
git checkout xilinx-v2024.1-SOL
```

Or to checkout the latest EOL tag for a version that has reached end of life:

```bash
# Checkout the final state of a version before removal
git checkout xilinx-v2023.1-EOL
```

#### Returning to the Latest Version

To return to the latest version on the main branch:

```bash
git checkout main
```

**Note:** After checking out a tag, you'll be in a "detached HEAD" state. This is normal and allows you to explore that version. If you need to make changes, create a new branch from the tag:

```bash
git checkout -b my-branch-name xilinx-v2024.1-SOL
```

---
## **What to Expect**
When a new version is added that commit is tagged with SOL (Start of Life)

Ex:

`xilinx-v<VERSION>-SOL`

When a version falls off the back of our support window, the final commit will be tagged EOL (End of Life) indicating that no more updates will be made to that design. The directory will then be deleted from the repository.

Ex:

`xilinx-v<VERSION>-EOL`

For more information on a particular version, see the README.md contained within that version's directory.

---
## **Troubleshooting / Assistance**
If you find you are having difficulty bringing up one of the designs, or need some additional assistance, please reach out on the [Xilinx Community Forums](https://forums.xilinx.com).

Be sure to [search](https://forums.xilinx.com/t5/forums/searchpage/tab/message?advanced=false&allow_punctuation=false&inactive=false) the forums first before posting, as someone may already have the solution!

---

---

## **Copyright**

© Copyright 2025 Advanced Micro Devices, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
