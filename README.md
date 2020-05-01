# Wiki Project Template Repository
This repository contains the template for creating a repository for the Xilinx Wiki.

This top-level README serves as a high-level entry point to the rest of your repository.

**IMPORTANT:** Follow the guidelines laid out in this README.md to create your own, using the same layout and headings.

A repository may be made up of one or more of the `template_project` directories, each containing their own design.

---
## **What to Expect**
The `template_project` contains the following structure:

```
<design>
├── Hardware
│   └── constraints
│       └── constraints.xdc
├── README.md
├── Scripts
│   ├── <design>.ui
│   ├── <design>_bd.tcl
│   └── project_top.tcl
└── Software
    ├── PetaLinux
    └── SDK
````
Each design's `README.md` will provide:

- **Design Summary** - Brief summary of the design.

- **Required Hardware** - Listing of required hardware

- **Build Instructions** - Instructions on how to re-build the designs

- **Validation** - List of exact validation hardware, and results of validation tests run against the design

- **Known Issues** - Current known issues with the design and/or workarounds for these issues.
---
## **Troubleshooting / Assistance**
If you find you are having difficulty bringing up one of the designs, or need some additional assistance, please reach out on the [Xilinx Community Forums](https://forums.xilinx.com).

Be sure to [search](https://forums.xilinx.com/t5/forums/searchpage/tab/message?advanced=false&allow_punctuation=false&inactive=false) the forums first before posting, as someone may already have the solution!

---