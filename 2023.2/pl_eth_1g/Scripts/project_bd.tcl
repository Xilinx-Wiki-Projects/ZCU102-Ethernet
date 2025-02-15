
################################################################
# This is a generated script based on design: pl_eth_1g
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2023.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   if { [string compare $scripts_vivado_version $current_vivado_version] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2042 -severity "ERROR" " This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Sourcing the script failed since it was created with a future version of Vivado."}

   } else {
     catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   }

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source pl_eth_1g_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu9eg-ffvb1156-2-e
   set_property BOARD_PART xilinx.com:zcu102:part0:3.3 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name pl_eth_1g

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

  # Add USER_COMMENTS on $design_name
  set_property USER_COMMENTS.comment_0 "PL ETHERNET SGMII DESIGN" [get_bd_designs $design_name]
  set_property USER_COMMENTS.comment_1 "PL ETHERNET SGMII DESIGN" [get_bd_designs $design_name]
  set_property USER_COMMENTS.comment_2 "PL ETHERNET SGMII DESIGN" [get_bd_designs $design_name]

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_ethernet:7.2\
xilinx.com:ip:axi_dma:7.1\
xilinx.com:ip:axi_timer:2.0\
xilinx.com:ip:util_reduced_logic:2.0\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:zynq_ultra_ps_e:3.5\
xilinx.com:ip:c_counter_binary:12.0\
xilinx.com:ip:xlslice:1.0\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: rx_clk_led
proc create_hier_cell_rx_clk_led { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_rx_clk_led() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -type clk CLK
  create_bd_pin -dir O -from 0 -to 0 Dout

  # Create instance: c_counter_binary_0, and set properties
  set c_counter_binary_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary:12.0 c_counter_binary_0 ]
  set_property -dict [list \
    CONFIG.Output_Width {32} \
    CONFIG.Restrict_Count {false} \
  ] $c_counter_binary_0


  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {24} \
    CONFIG.DIN_TO {24} \
    CONFIG.DOUT_WIDTH {1} \
  ] $xlslice_0


  # Create port connections
  connect_bd_net -net CLK_1 [get_bd_pins CLK] [get_bd_pins c_counter_binary_0/CLK]
  connect_bd_net -net c_counter_binary_0_Q [get_bd_pins c_counter_binary_0/Q] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins xlslice_0/Dout] [get_bd_pins Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: mgt_tx_clk_led
proc create_hier_cell_mgt_tx_clk_led { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_mgt_tx_clk_led() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -type clk CLK
  create_bd_pin -dir O -from 0 -to 0 Dout

  # Create instance: c_counter_binary_0, and set properties
  set c_counter_binary_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary:12.0 c_counter_binary_0 ]
  set_property -dict [list \
    CONFIG.Output_Width {32} \
    CONFIG.Restrict_Count {false} \
  ] $c_counter_binary_0


  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {24} \
    CONFIG.DIN_TO {24} \
    CONFIG.DOUT_WIDTH {1} \
  ] $xlslice_0


  # Create port connections
  connect_bd_net -net CLK_1 [get_bd_pins CLK] [get_bd_pins c_counter_binary_0/CLK]
  connect_bd_net -net c_counter_binary_0_Q [get_bd_pins c_counter_binary_0/Q] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins xlslice_0/Dout] [get_bd_pins Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: axi_clk_led
proc create_hier_cell_axi_clk_led { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_axi_clk_led() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -type clk CLK
  create_bd_pin -dir O -from 0 -to 0 Dout

  # Create instance: c_counter_binary_0, and set properties
  set c_counter_binary_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary:12.0 c_counter_binary_0 ]
  set_property -dict [list \
    CONFIG.Output_Width {32} \
    CONFIG.Restrict_Count {false} \
  ] $c_counter_binary_0


  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {24} \
    CONFIG.DIN_TO {24} \
    CONFIG.DOUT_WIDTH {1} \
  ] $xlslice_0


  # Create port connections
  connect_bd_net -net CLK_1 [get_bd_pins CLK] [get_bd_pins c_counter_binary_0/CLK]
  connect_bd_net -net c_counter_binary_0_Q [get_bd_pins c_counter_binary_0/Q] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins xlslice_0/Dout] [get_bd_pins Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: zynq_ps
proc create_hier_cell_zynq_ps { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_zynq_ps() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M02_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S01_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S02_AXI


  # Create pins
  create_bd_pin -dir I In0
  create_bd_pin -dir I In1
  create_bd_pin -dir I In2
  create_bd_pin -dir I In3
  create_bd_pin -dir O -type clk clk_50
  create_bd_pin -dir O -type clk clk_75
  create_bd_pin -dir O -from 94 -to 0 emio_gpio_o
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_reset
  create_bd_pin -dir O -from 0 -to 0 -type rst perph_aresetn_75

  # Create instance: axi_pl_ps, and set properties
  set axi_pl_ps [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_pl_ps ]
  set_property -dict [list \
    CONFIG.NUM_MI {1} \
    CONFIG.NUM_SI {3} \
  ] $axi_pl_ps


  # Create instance: ps_axi_periph, and set properties
  set ps_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 ps_axi_periph ]
  set_property -dict [list \
    CONFIG.NUM_MI {3} \
    CONFIG.NUM_SI {2} \
  ] $ps_axi_periph


  # Create instance: ps_irq_concat, and set properties
  set ps_irq_concat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 ps_irq_concat ]
  set_property CONFIG.NUM_PORTS {4} $ps_irq_concat


  # Create instance: ps_rst_75, and set properties
  set ps_rst_75 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 ps_rst_75 ]

  # Create instance: zusp_ps, and set properties
  set zusp_ps [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.5 zusp_ps ]
  set_property -dict [list \
    CONFIG.CAN0_BOARD_INTERFACE {custom} \
    CONFIG.CAN1_BOARD_INTERFACE {custom} \
    CONFIG.CSU_BOARD_INTERFACE {custom} \
    CONFIG.DP_BOARD_INTERFACE {custom} \
    CONFIG.GEM0_BOARD_INTERFACE {custom} \
    CONFIG.GEM1_BOARD_INTERFACE {custom} \
    CONFIG.GEM2_BOARD_INTERFACE {custom} \
    CONFIG.GEM3_BOARD_INTERFACE {custom} \
    CONFIG.GPIO_BOARD_INTERFACE {custom} \
    CONFIG.IIC0_BOARD_INTERFACE {custom} \
    CONFIG.IIC1_BOARD_INTERFACE {custom} \
    CONFIG.NAND_BOARD_INTERFACE {custom} \
    CONFIG.PCIE_BOARD_INTERFACE {custom} \
    CONFIG.PJTAG_BOARD_INTERFACE {custom} \
    CONFIG.PMU_BOARD_INTERFACE {custom} \
    CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS18} \
    CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS18} \
    CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS18} \
    CONFIG.PSU_BANK_3_IO_STANDARD {LVCMOS18} \
    CONFIG.PSU_DDR_RAM_HIGHADDR {0xFFFFFFFF} \
    CONFIG.PSU_DDR_RAM_HIGHADDR_OFFSET {0x800000000} \
    CONFIG.PSU_DDR_RAM_LOWADDR_OFFSET {0x80000000} \
    CONFIG.PSU_DYNAMIC_DDR_CONFIG_EN {1} \
    CONFIG.PSU_IMPORT_BOARD_PRESET {} \
    CONFIG.PSU_MIO_0_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_0_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_0_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_0_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_0_SLEW {slow} \
    CONFIG.PSU_MIO_10_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_10_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_10_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_10_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_10_SLEW {slow} \
    CONFIG.PSU_MIO_11_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_11_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_11_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_11_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_11_SLEW {slow} \
    CONFIG.PSU_MIO_12_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_12_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_12_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_12_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_12_SLEW {slow} \
    CONFIG.PSU_MIO_13_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_13_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_13_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_13_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_13_SLEW {slow} \
    CONFIG.PSU_MIO_14_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_14_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_14_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_14_SLEW {slow} \
    CONFIG.PSU_MIO_15_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_15_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_15_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_15_SLEW {slow} \
    CONFIG.PSU_MIO_16_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_16_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_16_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_16_SLEW {slow} \
    CONFIG.PSU_MIO_17_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_17_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_17_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_17_SLEW {slow} \
    CONFIG.PSU_MIO_18_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_18_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_19_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_19_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_19_SLEW {slow} \
    CONFIG.PSU_MIO_1_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_1_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_1_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_1_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_1_SLEW {slow} \
    CONFIG.PSU_MIO_20_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_20_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_20_SLEW {slow} \
    CONFIG.PSU_MIO_21_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_21_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_22_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_22_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_22_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_22_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_22_SLEW {slow} \
    CONFIG.PSU_MIO_23_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_23_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_23_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_23_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_23_SLEW {slow} \
    CONFIG.PSU_MIO_24_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_24_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_24_SLEW {slow} \
    CONFIG.PSU_MIO_25_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_25_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_26_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_26_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_26_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_26_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_26_SLEW {slow} \
    CONFIG.PSU_MIO_27_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_27_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_27_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_27_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_27_SLEW {slow} \
    CONFIG.PSU_MIO_28_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_28_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_28_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_28_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_28_SLEW {slow} \
    CONFIG.PSU_MIO_29_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_29_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_29_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_29_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_29_SLEW {slow} \
    CONFIG.PSU_MIO_2_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_2_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_2_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_2_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_2_SLEW {slow} \
    CONFIG.PSU_MIO_30_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_30_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_30_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_30_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_30_SLEW {slow} \
    CONFIG.PSU_MIO_31_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_31_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_31_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_31_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_31_SLEW {slow} \
    CONFIG.PSU_MIO_32_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_32_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_32_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_32_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_32_SLEW {slow} \
    CONFIG.PSU_MIO_33_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_33_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_33_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_33_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_33_SLEW {slow} \
    CONFIG.PSU_MIO_34_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_34_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_34_SLEW {slow} \
    CONFIG.PSU_MIO_35_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_35_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_35_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_35_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_35_SLEW {slow} \
    CONFIG.PSU_MIO_36_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_36_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_36_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_36_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_36_SLEW {slow} \
    CONFIG.PSU_MIO_37_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_37_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_37_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_37_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_37_SLEW {slow} \
    CONFIG.PSU_MIO_38_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_38_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_38_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_38_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_38_SLEW {slow} \
    CONFIG.PSU_MIO_39_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_39_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_39_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_39_SLEW {slow} \
    CONFIG.PSU_MIO_3_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_3_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_3_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_3_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_3_SLEW {slow} \
    CONFIG.PSU_MIO_40_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_40_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_40_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_40_SLEW {slow} \
    CONFIG.PSU_MIO_41_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_41_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_41_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_41_SLEW {slow} \
    CONFIG.PSU_MIO_42_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_42_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_42_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_42_SLEW {slow} \
    CONFIG.PSU_MIO_43_DIRECTION {out} \
    CONFIG.PSU_MIO_43_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_43_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_43_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_43_SLEW {slow} \
    CONFIG.PSU_MIO_44_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_44_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_45_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_45_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_46_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_46_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_46_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_46_SLEW {slow} \
    CONFIG.PSU_MIO_47_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_47_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_47_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_47_SLEW {slow} \
    CONFIG.PSU_MIO_48_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_48_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_48_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_48_SLEW {slow} \
    CONFIG.PSU_MIO_49_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_49_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_49_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_49_SLEW {slow} \
    CONFIG.PSU_MIO_4_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_4_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_4_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_4_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_4_SLEW {slow} \
    CONFIG.PSU_MIO_50_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_50_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_50_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_50_SLEW {slow} \
    CONFIG.PSU_MIO_51_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_51_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_51_SLEW {slow} \
    CONFIG.PSU_MIO_52_DIRECTION {in} \
    CONFIG.PSU_MIO_52_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_52_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_52_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_52_SLEW {fast} \
    CONFIG.PSU_MIO_53_DIRECTION {in} \
    CONFIG.PSU_MIO_53_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_53_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_53_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_53_SLEW {fast} \
    CONFIG.PSU_MIO_54_DIRECTION {inout} \
    CONFIG.PSU_MIO_54_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_54_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_54_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_54_SLEW {slow} \
    CONFIG.PSU_MIO_55_DIRECTION {in} \
    CONFIG.PSU_MIO_55_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_55_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_55_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_55_SLEW {fast} \
    CONFIG.PSU_MIO_56_DIRECTION {inout} \
    CONFIG.PSU_MIO_56_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_56_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_56_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_56_SLEW {slow} \
    CONFIG.PSU_MIO_57_DIRECTION {inout} \
    CONFIG.PSU_MIO_57_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_57_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_57_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_57_SLEW {slow} \
    CONFIG.PSU_MIO_58_DIRECTION {out} \
    CONFIG.PSU_MIO_58_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_58_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_58_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_58_SLEW {slow} \
    CONFIG.PSU_MIO_59_DIRECTION {inout} \
    CONFIG.PSU_MIO_59_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_59_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_59_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_59_SLEW {slow} \
    CONFIG.PSU_MIO_5_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_5_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_5_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_5_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_5_SLEW {slow} \
    CONFIG.PSU_MIO_60_DIRECTION {inout} \
    CONFIG.PSU_MIO_60_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_60_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_60_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_60_SLEW {slow} \
    CONFIG.PSU_MIO_61_DIRECTION {inout} \
    CONFIG.PSU_MIO_61_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_61_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_61_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_61_SLEW {slow} \
    CONFIG.PSU_MIO_62_DIRECTION {inout} \
    CONFIG.PSU_MIO_62_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_62_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_62_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_62_SLEW {slow} \
    CONFIG.PSU_MIO_63_DIRECTION {inout} \
    CONFIG.PSU_MIO_63_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_63_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_63_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_63_SLEW {slow} \
    CONFIG.PSU_MIO_64_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_64_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_64_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_64_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_64_SLEW {slow} \
    CONFIG.PSU_MIO_65_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_65_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_65_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_65_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_65_SLEW {slow} \
    CONFIG.PSU_MIO_66_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_66_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_66_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_66_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_66_SLEW {slow} \
    CONFIG.PSU_MIO_67_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_67_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_67_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_67_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_67_SLEW {slow} \
    CONFIG.PSU_MIO_68_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_68_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_68_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_68_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_68_SLEW {slow} \
    CONFIG.PSU_MIO_69_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_69_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_69_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_69_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_69_SLEW {slow} \
    CONFIG.PSU_MIO_6_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_6_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_6_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_6_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_6_SLEW {slow} \
    CONFIG.PSU_MIO_70_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_70_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_70_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_70_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_70_SLEW {slow} \
    CONFIG.PSU_MIO_71_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_71_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_71_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_71_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_71_SLEW {slow} \
    CONFIG.PSU_MIO_72_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_72_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_72_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_72_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_72_SLEW {slow} \
    CONFIG.PSU_MIO_73_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_73_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_73_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_73_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_73_SLEW {slow} \
    CONFIG.PSU_MIO_74_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_74_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_74_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_74_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_74_SLEW {slow} \
    CONFIG.PSU_MIO_75_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_75_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_75_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_75_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_75_SLEW {slow} \
    CONFIG.PSU_MIO_76_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_76_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_76_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_76_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_76_SLEW {slow} \
    CONFIG.PSU_MIO_77_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_77_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_77_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_77_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_77_SLEW {slow} \
    CONFIG.PSU_MIO_7_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_7_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_7_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_7_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_7_SLEW {slow} \
    CONFIG.PSU_MIO_8_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_8_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_8_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_8_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_8_SLEW {slow} \
    CONFIG.PSU_MIO_9_DIRECTION {<Select>} \
    CONFIG.PSU_MIO_9_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_9_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_9_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_9_SLEW {slow} \
    CONFIG.PSU_MIO_TREE_PERIPHERALS {##############I2C 0#I2C 0#I2C 1#I2C 1#UART 0#UART 0#UART 1#UART 1###CAN 1#CAN 1#########PMU GPO 2#####SD 1#SD 1#SD 1#SD 1##SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1##########################}\
\
    CONFIG.PSU_MIO_TREE_SIGNALS {##############scl_out#sda_out#scl_out#sda_out#rxd#txd#txd#rxd###phy_tx#phy_rx#########gpo[2]#####sdio1_data_out[4]#sdio1_data_out[5]#sdio1_data_out[6]#sdio1_data_out[7]##sdio1_wp#sdio1_cd_n#sdio1_data_out[0]#sdio1_data_out[1]#sdio1_data_out[2]#sdio1_data_out[3]#sdio1_cmd_out#sdio1_clk_out##########################}\
\
    CONFIG.PSU_PERIPHERAL_BOARD_PRESET {} \
    CONFIG.PSU_SD0_INTERNAL_BUS_WIDTH {8} \
    CONFIG.PSU_SD1_INTERNAL_BUS_WIDTH {8} \
    CONFIG.PSU_SMC_CYCLE_T0 {NA} \
    CONFIG.PSU_SMC_CYCLE_T1 {NA} \
    CONFIG.PSU_SMC_CYCLE_T2 {NA} \
    CONFIG.PSU_SMC_CYCLE_T3 {NA} \
    CONFIG.PSU_SMC_CYCLE_T4 {NA} \
    CONFIG.PSU_SMC_CYCLE_T5 {NA} \
    CONFIG.PSU_SMC_CYCLE_T6 {NA} \
    CONFIG.PSU_USB3__DUAL_CLOCK_ENABLE {0} \
    CONFIG.PSU_VALUE_SILVERSION {3} \
    CONFIG.PSU__ACPU0__POWER__ON {1} \
    CONFIG.PSU__ACPU1__POWER__ON {1} \
    CONFIG.PSU__ACPU2__POWER__ON {1} \
    CONFIG.PSU__ACPU3__POWER__ON {1} \
    CONFIG.PSU__ACTUAL__IP {1} \
    CONFIG.PSU__ACT_DDR_FREQ_MHZ {1066.560059} \
    CONFIG.PSU__AUX_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__CAN0_LOOP_CAN1__ENABLE {0} \
    CONFIG.PSU__CAN0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__CAN1__GRP_CLK__ENABLE {0} \
    CONFIG.PSU__CAN1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__CAN1__PERIPHERAL__IO {MIO 24 .. 25} \
    CONFIG.PSU__CRF_APB__ACPU_CTRL__ACT_FREQMHZ {1199.880127} \
    CONFIG.PSU__CRF_APB__ACPU_CTRL__FREQMHZ {1200} \
    CONFIG.PSU__CRF_APB__ACPU_CTRL__SRCSEL {APLL} \
    CONFIG.PSU__CRF_APB__ACPU__FRAC_ENABLED {0} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI0_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI1_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI2_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI3_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI4_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI5_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__APLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRF_APB__APLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRF_APB__APM_CTRL__ACT_FREQMHZ {1} \
    CONFIG.PSU__CRF_APB__APM_CTRL__DIVISOR0 {1} \
    CONFIG.PSU__CRF_APB__APM_CTRL__FREQMHZ {1} \
    CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__ACT_FREQMHZ {249.975021} \
    CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__ACT_FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__ACT_FREQMHZ {249.975021} \
    CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__DDR_CTRL__ACT_FREQMHZ {533.280029} \
    CONFIG.PSU__CRF_APB__DDR_CTRL__FREQMHZ {1067} \
    CONFIG.PSU__CRF_APB__DDR_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__ACT_FREQMHZ {599.940063} \
    CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__FREQMHZ {600} \
    CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__SRCSEL {APLL} \
    CONFIG.PSU__CRF_APB__DPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRF_APB__DPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__ACT_FREQMHZ {24.997501} \
    CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__FREQMHZ {25} \
    CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__ACT_FREQMHZ {26.783037} \
    CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__FREQMHZ {27} \
    CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__ACT_FREQMHZ {299.970032} \
    CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__FREQMHZ {300} \
    CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__SRCSEL {VPLL} \
    CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__ACT_FREQMHZ {599.940063} \
    CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__FREQMHZ {600} \
    CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__SRCSEL {APLL} \
    CONFIG.PSU__CRF_APB__GPU_REF_CTRL__ACT_FREQMHZ {499.950043} \
    CONFIG.PSU__CRF_APB__GPU_REF_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRF_APB__GPU_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__ACT_FREQMHZ {-1} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__DIVISOR0 {-1} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__FREQMHZ {-1} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__SRCSEL {NA} \
    CONFIG.PSU__CRF_APB__GTGREF0__ENABLE {NA} \
    CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__ACT_FREQMHZ {249.975021} \
    CONFIG.PSU__CRF_APB__SATA_REF_CTRL__ACT_FREQMHZ {249.975021} \
    CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ {99.990005} \
    CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__ACT_FREQMHZ {533.280029} \
    CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__FREQMHZ {533.33} \
    CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__VPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRF_APB__VPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__ACT_FREQMHZ {499.950043} \
    CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__ACT_FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__AFI6__ENABLE {0} \
    CONFIG.PSU__CRL_APB__AMS_REF_CTRL__ACT_FREQMHZ {49.995003} \
    CONFIG.PSU__CRL_APB__AMS_REF_CTRL__FREQMHZ {50} \
    CONFIG.PSU__CRL_APB__AMS_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__ACT_FREQMHZ {99.990005} \
    CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CPU_R5_CTRL__ACT_FREQMHZ {499.950043} \
    CONFIG.PSU__CRL_APB__CPU_R5_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__CPU_R5_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__ACT_FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__DIVISOR0 {3} \
    CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__FREQMHZ {400} \
    CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__ACT_FREQMHZ {249.975021} \
    CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__ACT_FREQMHZ {1000} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__DIVISOR0 {6} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__FREQMHZ {1000} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__DLL_REF_CTRL__ACT_FREQMHZ {1499.850098} \
    CONFIG.PSU__CRL_APB__DLL_REF_CTRL__FREQMHZ {1500} \
    CONFIG.PSU__CRL_APB__DLL_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__ACT_FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__ACT_FREQMHZ {124.987511} \
    CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__ACT_FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__ACT_FREQMHZ {124.987511} \
    CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__ACT_FREQMHZ {249.975021} \
    CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__ACT_FREQMHZ {99.990005} \
    CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__ACT_FREQMHZ {99.990005} \
    CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__IOPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRL_APB__IOPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__ACT_FREQMHZ {249.975021} \
    CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ {99.990005} \
    CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__ACT_FREQMHZ {499.950043} \
    CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__NAND_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__NAND_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__NAND_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__ACT_FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__DIVISOR0 {3} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__PCAP_CTRL__ACT_FREQMHZ {187.481262} \
    CONFIG.PSU__CRL_APB__PCAP_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__PCAP_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__PL0_REF_CTRL__ACT_FREQMHZ {74.992508} \
    CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {75} \
    CONFIG.PSU__CRL_APB__PL0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__PL1_REF_CTRL__ACT_FREQMHZ {49.995003} \
    CONFIG.PSU__CRL_APB__PL1_REF_CTRL__FREQMHZ {50} \
    CONFIG.PSU__CRL_APB__PL1_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__PL2_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__PL3_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__ACT_FREQMHZ {124.987511} \
    CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__RPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRL_APB__RPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__ACT_FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__ACT_FREQMHZ {187.481262} \
    CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__ACT_FREQMHZ {214} \
    CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__ACT_FREQMHZ {214} \
    CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__ACT_FREQMHZ {99.990005} \
    CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__UART0_REF_CTRL__ACT_FREQMHZ {99.990005} \
    CONFIG.PSU__CRL_APB__UART0_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__UART0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__UART1_REF_CTRL__ACT_FREQMHZ {99.990005} \
    CONFIG.PSU__CRL_APB__UART1_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__UART1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__ACT_FREQMHZ {249.975021} \
    CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__ACT_FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__ACT_FREQMHZ {19.998001} \
    CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__FREQMHZ {20} \
    CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB3__ENABLE {0} \
    CONFIG.PSU__CSUPMU__PERIPHERAL__VALID {1} \
    CONFIG.PSU__CSU__CSU_TAMPER_0__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_10__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_11__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_12__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_1__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_2__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_3__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_4__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_5__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_6__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_7__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_8__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_9__ENABLE {0} \
    CONFIG.PSU__CSU__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__DDRC__AL {0} \
    CONFIG.PSU__DDRC__BG_ADDR_COUNT {2} \
    CONFIG.PSU__DDRC__BRC_MAPPING {ROW_BANK_COL} \
    CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
    CONFIG.PSU__DDRC__CL {15} \
    CONFIG.PSU__DDRC__CLOCK_STOP_EN {0} \
    CONFIG.PSU__DDRC__COMPONENTS {UDIMM} \
    CONFIG.PSU__DDRC__CWL {14} \
    CONFIG.PSU__DDRC__DDR4_ADDR_MAPPING {0} \
    CONFIG.PSU__DDRC__DDR4_CAL_MODE_ENABLE {0} \
    CONFIG.PSU__DDRC__DDR4_CRC_CONTROL {0} \
    CONFIG.PSU__DDRC__DDR4_MAXPWR_SAVING_EN {0} \
    CONFIG.PSU__DDRC__DDR4_T_REF_MODE {0} \
    CONFIG.PSU__DDRC__DDR4_T_REF_RANGE {Normal (0-85)} \
    CONFIG.PSU__DDRC__DEVICE_CAPACITY {4096 MBits} \
    CONFIG.PSU__DDRC__DM_DBI {DM_NO_DBI} \
    CONFIG.PSU__DDRC__DRAM_WIDTH {8 Bits} \
    CONFIG.PSU__DDRC__ECC {Disabled} \
    CONFIG.PSU__DDRC__ECC_SCRUB {0} \
    CONFIG.PSU__DDRC__ENABLE {1} \
    CONFIG.PSU__DDRC__ENABLE_2T_TIMING {0} \
    CONFIG.PSU__DDRC__ENABLE_DP_SWITCH {0} \
    CONFIG.PSU__DDRC__EN_2ND_CLK {0} \
    CONFIG.PSU__DDRC__FGRM {1X} \
    CONFIG.PSU__DDRC__FREQ_MHZ {1066.50} \
    CONFIG.PSU__DDRC__LPDDR3_DUALRANK_SDP {0} \
    CONFIG.PSU__DDRC__LP_ASR {manual normal} \
    CONFIG.PSU__DDRC__MEMORY_TYPE {DDR 4} \
    CONFIG.PSU__DDRC__PARITY_ENABLE {0} \
    CONFIG.PSU__DDRC__PER_BANK_REFRESH {0} \
    CONFIG.PSU__DDRC__PHY_DBI_MODE {0} \
    CONFIG.PSU__DDRC__PLL_BYPASS {0} \
    CONFIG.PSU__DDRC__PWR_DOWN_EN {0} \
    CONFIG.PSU__DDRC__RANK_ADDR_COUNT {0} \
    CONFIG.PSU__DDRC__RD_DQS_CENTER {0} \
    CONFIG.PSU__DDRC__ROW_ADDR_COUNT {15} \
    CONFIG.PSU__DDRC__SELF_REF_ABORT {0} \
    CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2133P} \
    CONFIG.PSU__DDRC__STATIC_RD_MODE {0} \
    CONFIG.PSU__DDRC__TRAIN_DATA_EYE {1} \
    CONFIG.PSU__DDRC__TRAIN_READ_GATE {1} \
    CONFIG.PSU__DDRC__TRAIN_WRITE_LEVEL {1} \
    CONFIG.PSU__DDRC__T_FAW {30.0} \
    CONFIG.PSU__DDRC__T_RAS_MIN {33} \
    CONFIG.PSU__DDRC__T_RC {47.06} \
    CONFIG.PSU__DDRC__T_RCD {15} \
    CONFIG.PSU__DDRC__T_RP {15} \
    CONFIG.PSU__DDRC__VIDEO_BUFFER_SIZE {0} \
    CONFIG.PSU__DDRC__VREF {1} \
    CONFIG.PSU__DDR_HIGH_ADDRESS_GUI_ENABLE {1} \
    CONFIG.PSU__DDR_QOS_ENABLE {0} \
    CONFIG.PSU__DDR_QOS_HP0_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP0_WRQOS {} \
    CONFIG.PSU__DDR_QOS_HP1_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP1_WRQOS {} \
    CONFIG.PSU__DDR_QOS_HP2_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP2_WRQOS {} \
    CONFIG.PSU__DDR_QOS_HP3_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP3_WRQOS {} \
    CONFIG.PSU__DDR_SW_REFRESH_ENABLED {1} \
    CONFIG.PSU__DDR__INTERFACE__FREQMHZ {533.500} \
    CONFIG.PSU__DEVICE_TYPE {EG} \
    CONFIG.PSU__DISPLAYPORT__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__DLL__ISUSED {1} \
    CONFIG.PSU__ENABLE__DDR__REFRESH__SIGNALS {0} \
    CONFIG.PSU__ENET0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__ENET1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__ENET2__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__ENET3__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__EN_AXI_STATUS_PORTS {0} \
    CONFIG.PSU__EN_EMIO_TRACE {0} \
    CONFIG.PSU__EP__IP {0} \
    CONFIG.PSU__EXPAND__CORESIGHT {0} \
    CONFIG.PSU__EXPAND__FPD_SLAVES {0} \
    CONFIG.PSU__EXPAND__GIC {0} \
    CONFIG.PSU__EXPAND__LOWER_LPS_SLAVES {1} \
    CONFIG.PSU__EXPAND__UPPER_LPS_SLAVES {0} \
    CONFIG.PSU__FPD_SLCR__WDT1__ACT_FREQMHZ {99.990005} \
    CONFIG.PSU__FPGA_PL0_ENABLE {1} \
    CONFIG.PSU__FPGA_PL1_ENABLE {1} \
    CONFIG.PSU__FPGA_PL2_ENABLE {0} \
    CONFIG.PSU__FPGA_PL3_ENABLE {0} \
    CONFIG.PSU__FP__POWER__ON {1} \
    CONFIG.PSU__FTM__CTI_IN_0 {0} \
    CONFIG.PSU__FTM__CTI_IN_1 {0} \
    CONFIG.PSU__FTM__CTI_IN_2 {0} \
    CONFIG.PSU__FTM__CTI_IN_3 {0} \
    CONFIG.PSU__FTM__CTI_OUT_0 {0} \
    CONFIG.PSU__FTM__CTI_OUT_1 {0} \
    CONFIG.PSU__FTM__CTI_OUT_2 {0} \
    CONFIG.PSU__FTM__CTI_OUT_3 {0} \
    CONFIG.PSU__FTM__GPI {0} \
    CONFIG.PSU__FTM__GPO {0} \
    CONFIG.PSU__GEN_IPI_0__MASTER {APU} \
    CONFIG.PSU__GEN_IPI_10__MASTER {NONE} \
    CONFIG.PSU__GEN_IPI_1__MASTER {RPU0} \
    CONFIG.PSU__GEN_IPI_2__MASTER {RPU1} \
    CONFIG.PSU__GEN_IPI_3__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_4__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_5__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_6__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_7__MASTER {NONE} \
    CONFIG.PSU__GEN_IPI_8__MASTER {NONE} \
    CONFIG.PSU__GEN_IPI_9__MASTER {NONE} \
    CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__GPIO2_MIO__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__GPIO_EMIO_WIDTH {95} \
    CONFIG.PSU__GPIO_EMIO__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__GPIO_EMIO__WIDTH {[94:0]} \
    CONFIG.PSU__GPU_PP0__POWER__ON {1} \
    CONFIG.PSU__GPU_PP1__POWER__ON {1} \
    CONFIG.PSU__GT_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__HPM0_FPD__NUM_READ_THREADS {4} \
    CONFIG.PSU__HPM0_FPD__NUM_WRITE_THREADS {4} \
    CONFIG.PSU__HPM0_LPD__NUM_READ_THREADS {4} \
    CONFIG.PSU__HPM0_LPD__NUM_WRITE_THREADS {4} \
    CONFIG.PSU__HPM1_FPD__NUM_READ_THREADS {4} \
    CONFIG.PSU__HPM1_FPD__NUM_WRITE_THREADS {4} \
    CONFIG.PSU__I2C0_LOOP_I2C1__ENABLE {0} \
    CONFIG.PSU__I2C0__GRP_INT__ENABLE {0} \
    CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__I2C0__PERIPHERAL__IO {MIO 14 .. 15} \
    CONFIG.PSU__I2C1__GRP_INT__ENABLE {0} \
    CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__I2C1__PERIPHERAL__IO {MIO 16 .. 17} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC0_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC1_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC2_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC3_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__TTC0__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__TTC1__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__TTC2__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__TTC3__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__WDT0__ACT_FREQMHZ {99.990005} \
    CONFIG.PSU__IRQ_P2F_ADMA_CHAN__INT {0} \
    CONFIG.PSU__IRQ_P2F_AIB_AXI__INT {0} \
    CONFIG.PSU__IRQ_P2F_AMS__INT {0} \
    CONFIG.PSU__IRQ_P2F_APM_FPD__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_COMM__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_CPUMNT__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_CTI__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_EXTERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_IPI__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_L2ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_PMU__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_REGS__INT {0} \
    CONFIG.PSU__IRQ_P2F_ATB_LPD__INT {0} \
    CONFIG.PSU__IRQ_P2F_CAN1__INT {0} \
    CONFIG.PSU__IRQ_P2F_CLKMON__INT {0} \
    CONFIG.PSU__IRQ_P2F_CSUPMU_WDT__INT {0} \
    CONFIG.PSU__IRQ_P2F_DDR_SS__INT {0} \
    CONFIG.PSU__IRQ_P2F_DPDMA__INT {0} \
    CONFIG.PSU__IRQ_P2F_EFUSE__INT {0} \
    CONFIG.PSU__IRQ_P2F_FPD_APB__INT {0} \
    CONFIG.PSU__IRQ_P2F_FPD_ATB_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_FP_WDT__INT {0} \
    CONFIG.PSU__IRQ_P2F_GDMA_CHAN__INT {0} \
    CONFIG.PSU__IRQ_P2F_GPIO__INT {0} \
    CONFIG.PSU__IRQ_P2F_GPU__INT {0} \
    CONFIG.PSU__IRQ_P2F_I2C0__INT {0} \
    CONFIG.PSU__IRQ_P2F_I2C1__INT {0} \
    CONFIG.PSU__IRQ_P2F_LPD_APB__INT {0} \
    CONFIG.PSU__IRQ_P2F_LPD_APM__INT {0} \
    CONFIG.PSU__IRQ_P2F_LP_WDT__INT {0} \
    CONFIG.PSU__IRQ_P2F_OCM_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_DMA__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_LEGACY__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_MSC__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_MSI__INT {0} \
    CONFIG.PSU__IRQ_P2F_PL_IPI__INT {0} \
    CONFIG.PSU__IRQ_P2F_R5_CORE0_ECC_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_R5_CORE1_ECC_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_RPU_IPI__INT {0} \
    CONFIG.PSU__IRQ_P2F_RPU_PERMON__INT {0} \
    CONFIG.PSU__IRQ_P2F_RTC_ALARM__INT {0} \
    CONFIG.PSU__IRQ_P2F_RTC_SECONDS__INT {0} \
    CONFIG.PSU__IRQ_P2F_SATA__INT {0} \
    CONFIG.PSU__IRQ_P2F_SDIO1_WAKE__INT {0} \
    CONFIG.PSU__IRQ_P2F_SDIO1__INT {0} \
    CONFIG.PSU__IRQ_P2F_TTC0__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC0__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC0__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_TTC1__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC1__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC1__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_TTC2__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC2__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC2__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_TTC3__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC3__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC3__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_UART0__INT {0} \
    CONFIG.PSU__IRQ_P2F_UART1__INT {0} \
    CONFIG.PSU__IRQ_P2F_USB3_ENDPOINT__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_ENDPOINT__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_OTG__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_OTG__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_PMU_WAKEUP__INT {0} \
    CONFIG.PSU__IRQ_P2F_XMPU_FPD__INT {0} \
    CONFIG.PSU__IRQ_P2F_XMPU_LPD__INT {0} \
    CONFIG.PSU__IRQ_P2F__INTF_FPD_SMMU__INT {0} \
    CONFIG.PSU__IRQ_P2F__INTF_PPD_CCI__INT {0} \
    CONFIG.PSU__L2_BANK0__POWER__ON {1} \
    CONFIG.PSU__LPDMA0_COHERENCY {0} \
    CONFIG.PSU__LPDMA1_COHERENCY {0} \
    CONFIG.PSU__LPDMA2_COHERENCY {0} \
    CONFIG.PSU__LPDMA3_COHERENCY {0} \
    CONFIG.PSU__LPDMA4_COHERENCY {0} \
    CONFIG.PSU__LPDMA5_COHERENCY {0} \
    CONFIG.PSU__LPDMA6_COHERENCY {0} \
    CONFIG.PSU__LPDMA7_COHERENCY {0} \
    CONFIG.PSU__LPD_SLCR__CSUPMU_WDT_CLK_SEL__SELECT {APB} \
    CONFIG.PSU__LPD_SLCR__CSUPMU__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__MAXIGP0__DATA_WIDTH {128} \
    CONFIG.PSU__MAXIGP1__DATA_WIDTH {128} \
    CONFIG.PSU__M_AXI_GP0_SUPPORTS_NARROW_BURST {1} \
    CONFIG.PSU__M_AXI_GP1_SUPPORTS_NARROW_BURST {1} \
    CONFIG.PSU__M_AXI_GP2_SUPPORTS_NARROW_BURST {1} \
    CONFIG.PSU__NAND__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__NAND__READY_BUSY__ENABLE {0} \
    CONFIG.PSU__NUM_FABRIC_RESETS {1} \
    CONFIG.PSU__OCM_BANK0__POWER__ON {1} \
    CONFIG.PSU__OCM_BANK1__POWER__ON {1} \
    CONFIG.PSU__OCM_BANK2__POWER__ON {1} \
    CONFIG.PSU__OCM_BANK3__POWER__ON {1} \
    CONFIG.PSU__OVERRIDE_HPX_QOS {0} \
    CONFIG.PSU__OVERRIDE__BASIC_CLOCK {0} \
    CONFIG.PSU__PCIE__ACS_VIOLAION {0} \
    CONFIG.PSU__PCIE__AER_CAPABILITY {0} \
    CONFIG.PSU__PCIE__CLASS_CODE_BASE {0x06} \
    CONFIG.PSU__PCIE__CLASS_CODE_INTERFACE {} \
    CONFIG.PSU__PCIE__CLASS_CODE_SUB {0x4} \
    CONFIG.PSU__PCIE__DEVICE_ID {0xD021} \
    CONFIG.PSU__PCIE__INTX_GENERATION {0} \
    CONFIG.PSU__PCIE__MSIX_CAPABILITY {0} \
    CONFIG.PSU__PCIE__MSI_CAPABILITY {0} \
    CONFIG.PSU__PCIE__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__PCIE__PERIPHERAL__ENDPOINT_ENABLE {1} \
    CONFIG.PSU__PCIE__PERIPHERAL__ROOTPORT_ENABLE {0} \
    CONFIG.PSU__PCIE__RESET__POLARITY {Active Low} \
    CONFIG.PSU__PCIE__REVISION_ID {} \
    CONFIG.PSU__PCIE__SUBSYSTEM_ID {} \
    CONFIG.PSU__PCIE__SUBSYSTEM_VENDOR_ID {} \
    CONFIG.PSU__PCIE__VENDOR_ID {} \
    CONFIG.PSU__PJTAG__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__PL_CLK0_BUF {TRUE} \
    CONFIG.PSU__PL_CLK1_BUF {TRUE} \
    CONFIG.PSU__PL__POWER__ON {1} \
    CONFIG.PSU__PMU_COHERENCY {0} \
    CONFIG.PSU__PMU__AIBACK__ENABLE {0} \
    CONFIG.PSU__PMU__EMIO_GPI__ENABLE {0} \
    CONFIG.PSU__PMU__EMIO_GPO__ENABLE {0} \
    CONFIG.PSU__PMU__GPI0__ENABLE {0} \
    CONFIG.PSU__PMU__GPI1__ENABLE {0} \
    CONFIG.PSU__PMU__GPI2__ENABLE {0} \
    CONFIG.PSU__PMU__GPI3__ENABLE {0} \
    CONFIG.PSU__PMU__GPI4__ENABLE {0} \
    CONFIG.PSU__PMU__GPI5__ENABLE {0} \
    CONFIG.PSU__PMU__GPO0__ENABLE {0} \
    CONFIG.PSU__PMU__GPO1__ENABLE {0} \
    CONFIG.PSU__PMU__GPO2__ENABLE {1} \
    CONFIG.PSU__PMU__GPO2__IO {MIO 34} \
    CONFIG.PSU__PMU__GPO2__POLARITY {high} \
    CONFIG.PSU__PMU__GPO3__ENABLE {0} \
    CONFIG.PSU__PMU__GPO4__ENABLE {0} \
    CONFIG.PSU__PMU__GPO5__ENABLE {0} \
    CONFIG.PSU__PMU__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__PMU__PLERROR__ENABLE {0} \
    CONFIG.PSU__PRESET_APPLIED {1} \
    CONFIG.PSU__PROTECTION__DDR_SEGMENTS {NONE} \
    CONFIG.PSU__PROTECTION__ENABLE {0} \
    CONFIG.PSU__PROTECTION__FPD_SEGMENTS {SA:0xFD1A0000 ;SIZE:1280;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware       |       SA:0xFD000000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure\
;WrAllowed:Read/Write;subsystemId:PMU Firmware       |       SA:0xFD010000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware       |       SA:0xFD020000 ;SIZE:64;UNIT:KB\
;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware       |       SA:0xFD030000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware       |       SA:0xFD040000\
;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware       |       SA:0xFD050000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware       |   \
   SA:0xFD610000 ;SIZE:512;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware       |       SA:0xFD5D0000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware}\
\
    CONFIG.PSU__PROTECTION__LPD_SEGMENTS {SA:0xFF980000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFF5E0000 ;SIZE:2560;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU\
Firmware|SA:0xFFCC0000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFF180000 ;SIZE:768;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFF410000\
;SIZE:640;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFFA70000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFF9A0000 ;SIZE:64;UNIT:KB\
;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware} \
    CONFIG.PSU__PROTECTION__MASTERS {USB1:NonSecure;0|USB0:NonSecure;0|S_AXI_LPD:NA;0|S_AXI_HPC1_FPD:NA;0|S_AXI_HPC0_FPD:NA;0|S_AXI_HP3_FPD:NA;0|S_AXI_HP2_FPD:NA;0|S_AXI_HP1_FPD:NA;0|S_AXI_HP0_FPD:NA;1|S_AXI_ACP:NA;0|S_AXI_ACE:NA;0|SD1:NonSecure;1|SD0:NonSecure;0|SATA1:NonSecure;0|SATA0:NonSecure;0|RPU1:Secure;1|RPU0:Secure;1|QSPI:NonSecure;0|PMU:NA;1|PCIe:NonSecure;0|NAND:NonSecure;0|LDMA:NonSecure;1|GPU:NonSecure;1|GEM3:NonSecure;0|GEM2:NonSecure;0|GEM1:NonSecure;0|GEM0:NonSecure;0|FDMA:NonSecure;1|DP:NonSecure;0|DAP:NA;1|Coresight:NA;1|CSU:NA;1|APU:NA;1}\
\
    CONFIG.PSU__PROTECTION__MASTERS_TZ {GEM0:NonSecure|SD1:NonSecure|GEM2:NonSecure|GEM1:NonSecure|GEM3:NonSecure|PCIe:NonSecure|DP:NonSecure|NAND:NonSecure|GPU:NonSecure|USB1:NonSecure|USB0:NonSecure|LDMA:NonSecure|FDMA:NonSecure|QSPI:NonSecure|SD0:NonSecure}\
\
    CONFIG.PSU__PROTECTION__OCM_SEGMENTS {NONE} \
    CONFIG.PSU__PROTECTION__PRESUBSYSTEMS {NONE} \
    CONFIG.PSU__PROTECTION__SLAVES {LPD;USB3_1_XHCI;FE300000;FE3FFFFF;0|LPD;USB3_1;FF9E0000;FF9EFFFF;0|LPD;USB3_0_XHCI;FE200000;FE2FFFFF;0|LPD;USB3_0;FF9D0000;FF9DFFFF;0|LPD;UART1;FF010000;FF01FFFF;1|LPD;UART0;FF000000;FF00FFFF;1|LPD;TTC3;FF140000;FF14FFFF;1|LPD;TTC2;FF130000;FF13FFFF;1|LPD;TTC1;FF120000;FF12FFFF;1|LPD;TTC0;FF110000;FF11FFFF;1|FPD;SWDT1;FD4D0000;FD4DFFFF;1|LPD;SWDT0;FF150000;FF15FFFF;1|LPD;SPI1;FF050000;FF05FFFF;0|LPD;SPI0;FF040000;FF04FFFF;0|FPD;SMMU_REG;FD5F0000;FD5FFFFF;1|FPD;SMMU;FD800000;FDFFFFFF;1|FPD;SIOU;FD3D0000;FD3DFFFF;1|FPD;SERDES;FD400000;FD47FFFF;1|LPD;SD1;FF170000;FF17FFFF;1|LPD;SD0;FF160000;FF16FFFF;0|FPD;SATA;FD0C0000;FD0CFFFF;0|LPD;RTC;FFA60000;FFA6FFFF;1|LPD;RSA_CORE;FFCE0000;FFCEFFFF;1|LPD;RPU;FF9A0000;FF9AFFFF;1|LPD;R5_TCM_RAM_GLOBAL;FFE00000;FFE3FFFF;1|LPD;R5_1_Instruction_Cache;FFEC0000;FFECFFFF;1|LPD;R5_1_Data_Cache;FFED0000;FFEDFFFF;1|LPD;R5_1_BTCM_GLOBAL;FFEB0000;FFEBFFFF;1|LPD;R5_1_ATCM_GLOBAL;FFE90000;FFE9FFFF;1|LPD;R5_0_Instruction_Cache;FFE40000;FFE4FFFF;1|LPD;R5_0_Data_Cache;FFE50000;FFE5FFFF;1|LPD;R5_0_BTCM_GLOBAL;FFE20000;FFE2FFFF;1|LPD;R5_0_ATCM_GLOBAL;FFE00000;FFE0FFFF;1|LPD;QSPI_Linear_Address;C0000000;DFFFFFFF;1|LPD;QSPI;FF0F0000;FF0FFFFF;0|LPD;PMU_RAM;FFDC0000;FFDDFFFF;1|LPD;PMU_GLOBAL;FFD80000;FFDBFFFF;1|FPD;PCIE_MAIN;FD0E0000;FD0EFFFF;0|FPD;PCIE_LOW;E0000000;EFFFFFFF;0|FPD;PCIE_HIGH2;8000000000;BFFFFFFFFF;0|FPD;PCIE_HIGH1;600000000;7FFFFFFFF;0|FPD;PCIE_DMA;FD0F0000;FD0FFFFF;0|FPD;PCIE_ATTRIB;FD480000;FD48FFFF;0|LPD;OCM_XMPU_CFG;FFA70000;FFA7FFFF;1|LPD;OCM_SLCR;FF960000;FF96FFFF;1|OCM;OCM;FFFC0000;FFFFFFFF;1|LPD;NAND;FF100000;FF10FFFF;0|LPD;MBISTJTAG;FFCF0000;FFCFFFFF;1|LPD;LPD_XPPU_SINK;FF9C0000;FF9CFFFF;1|LPD;LPD_XPPU;FF980000;FF98FFFF;1|LPD;LPD_SLCR_SECURE;FF4B0000;FF4DFFFF;1|LPD;LPD_SLCR;FF410000;FF4AFFFF;1|LPD;LPD_GPV;FE100000;FE1FFFFF;1|LPD;LPD_DMA_7;FFAF0000;FFAFFFFF;1|LPD;LPD_DMA_6;FFAE0000;FFAEFFFF;1|LPD;LPD_DMA_5;FFAD0000;FFADFFFF;1|LPD;LPD_DMA_4;FFAC0000;FFACFFFF;1|LPD;LPD_DMA_3;FFAB0000;FFABFFFF;1|LPD;LPD_DMA_2;FFAA0000;FFAAFFFF;1|LPD;LPD_DMA_1;FFA90000;FFA9FFFF;1|LPD;LPD_DMA_0;FFA80000;FFA8FFFF;1|LPD;IPI_CTRL;FF380000;FF3FFFFF;1|LPD;IOU_SLCR;FF180000;FF23FFFF;1|LPD;IOU_SECURE_SLCR;FF240000;FF24FFFF;1|LPD;IOU_SCNTRS;FF260000;FF26FFFF;1|LPD;IOU_SCNTR;FF250000;FF25FFFF;1|LPD;IOU_GPV;FE000000;FE0FFFFF;1|LPD;I2C1;FF030000;FF03FFFF;1|LPD;I2C0;FF020000;FF02FFFF;1|FPD;GPU;FD4B0000;FD4BFFFF;1|LPD;GPIO;FF0A0000;FF0AFFFF;1|LPD;GEM3;FF0E0000;FF0EFFFF;0|LPD;GEM2;FF0D0000;FF0DFFFF;0|LPD;GEM1;FF0C0000;FF0CFFFF;0|LPD;GEM0;FF0B0000;FF0BFFFF;0|FPD;FPD_XMPU_SINK;FD4F0000;FD4FFFFF;1|FPD;FPD_XMPU_CFG;FD5D0000;FD5DFFFF;1|FPD;FPD_SLCR_SECURE;FD690000;FD6CFFFF;1|FPD;FPD_SLCR;FD610000;FD68FFFF;1|FPD;FPD_DMA_CH7;FD570000;FD57FFFF;1|FPD;FPD_DMA_CH6;FD560000;FD56FFFF;1|FPD;FPD_DMA_CH5;FD550000;FD55FFFF;1|FPD;FPD_DMA_CH4;FD540000;FD54FFFF;1|FPD;FPD_DMA_CH3;FD530000;FD53FFFF;1|FPD;FPD_DMA_CH2;FD520000;FD52FFFF;1|FPD;FPD_DMA_CH1;FD510000;FD51FFFF;1|FPD;FPD_DMA_CH0;FD500000;FD50FFFF;1|LPD;EFUSE;FFCC0000;FFCCFFFF;1|FPD;Display\
Port;FD4A0000;FD4AFFFF;0|FPD;DPDMA;FD4C0000;FD4CFFFF;0|FPD;DDR_XMPU5_CFG;FD050000;FD05FFFF;1|FPD;DDR_XMPU4_CFG;FD040000;FD04FFFF;1|FPD;DDR_XMPU3_CFG;FD030000;FD03FFFF;1|FPD;DDR_XMPU2_CFG;FD020000;FD02FFFF;1|FPD;DDR_XMPU1_CFG;FD010000;FD01FFFF;1|FPD;DDR_XMPU0_CFG;FD000000;FD00FFFF;1|FPD;DDR_QOS_CTRL;FD090000;FD09FFFF;1|FPD;DDR_PHY;FD080000;FD08FFFF;1|DDR;DDR_LOW;0;7FFFFFFF;1|DDR;DDR_HIGH;800000000;87FFFFFFF;1|FPD;DDDR_CTRL;FD070000;FD070FFF;1|LPD;Coresight;FE800000;FEFFFFFF;1|LPD;CSU_DMA;FFC80000;FFC9FFFF;1|LPD;CSU;FFCA0000;FFCAFFFF;1|LPD;CRL_APB;FF5E0000;FF85FFFF;1|FPD;CRF_APB;FD1A0000;FD2DFFFF;1|FPD;CCI_REG;FD5E0000;FD5EFFFF;1|LPD;CAN1;FF070000;FF07FFFF;1|LPD;CAN0;FF060000;FF06FFFF;0|FPD;APU;FD5C0000;FD5CFFFF;1|LPD;APM_INTC_IOU;FFA20000;FFA2FFFF;1|LPD;APM_FPD_LPD;FFA30000;FFA3FFFF;1|FPD;APM_5;FD490000;FD49FFFF;1|FPD;APM_0;FD0B0000;FD0BFFFF;1|LPD;APM2;FFA10000;FFA1FFFF;1|LPD;APM1;FFA00000;FFA0FFFF;1|LPD;AMS;FFA50000;FFA5FFFF;1|FPD;AFI_5;FD3B0000;FD3BFFFF;1|FPD;AFI_4;FD3A0000;FD3AFFFF;1|FPD;AFI_3;FD390000;FD39FFFF;1|FPD;AFI_2;FD380000;FD38FFFF;1|FPD;AFI_1;FD370000;FD37FFFF;1|FPD;AFI_0;FD360000;FD36FFFF;1|LPD;AFIFM6;FF9B0000;FF9BFFFF;1|FPD;ACPU_GIC;F9010000;F907FFFF;1}\
\
    CONFIG.PSU__PROTECTION__SUBSYSTEMS {PMU Firmware:PMU} \
    CONFIG.PSU__PSS_ALT_REF_CLK__ENABLE {0} \
    CONFIG.PSU__PSS_ALT_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__PSS_REF_CLK__FREQMHZ {33.330} \
    CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__REPORT__DBGLOG {0} \
    CONFIG.PSU__RPU_COHERENCY {0} \
    CONFIG.PSU__RPU__POWER__ON {1} \
    CONFIG.PSU__SATA__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SAXIGP2__DATA_WIDTH {128} \
    CONFIG.PSU__SD0__CLK_100_SDR_OTAP_DLY {0x3} \
    CONFIG.PSU__SD0__CLK_200_SDR_OTAP_DLY {0x3} \
    CONFIG.PSU__SD0__CLK_50_DDR_ITAP_DLY {0x3D} \
    CONFIG.PSU__SD0__CLK_50_DDR_OTAP_DLY {0x4} \
    CONFIG.PSU__SD0__CLK_50_SDR_ITAP_DLY {0x15} \
    CONFIG.PSU__SD0__CLK_50_SDR_OTAP_DLY {0x5} \
    CONFIG.PSU__SD0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SD0__RESET__ENABLE {0} \
    CONFIG.PSU__SD1_COHERENCY {0} \
    CONFIG.PSU__SD1_ROUTE_THROUGH_FPD {0} \
    CONFIG.PSU__SD1__CLK_100_SDR_OTAP_DLY {0x3} \
    CONFIG.PSU__SD1__CLK_200_SDR_OTAP_DLY {0x3} \
    CONFIG.PSU__SD1__CLK_50_DDR_ITAP_DLY {0x3D} \
    CONFIG.PSU__SD1__CLK_50_DDR_OTAP_DLY {0x4} \
    CONFIG.PSU__SD1__CLK_50_SDR_ITAP_DLY {0x15} \
    CONFIG.PSU__SD1__CLK_50_SDR_OTAP_DLY {0x5} \
    CONFIG.PSU__SD1__DATA_TRANSFER_MODE {8Bit} \
    CONFIG.PSU__SD1__GRP_CD__ENABLE {1} \
    CONFIG.PSU__SD1__GRP_CD__IO {MIO 45} \
    CONFIG.PSU__SD1__GRP_POW__ENABLE {0} \
    CONFIG.PSU__SD1__GRP_WP__ENABLE {1} \
    CONFIG.PSU__SD1__GRP_WP__IO {MIO 44} \
    CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 39 .. 51} \
    CONFIG.PSU__SD1__SLOT_TYPE {SD 3.0} \
    CONFIG.PSU__SPI0_LOOP_SPI1__ENABLE {0} \
    CONFIG.PSU__SPI0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SPI1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SWDT0__CLOCK__ENABLE {0} \
    CONFIG.PSU__SWDT0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__SWDT0__PERIPHERAL__IO {NA} \
    CONFIG.PSU__SWDT0__RESET__ENABLE {0} \
    CONFIG.PSU__SWDT1__CLOCK__ENABLE {0} \
    CONFIG.PSU__SWDT1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__SWDT1__PERIPHERAL__IO {NA} \
    CONFIG.PSU__SWDT1__RESET__ENABLE {0} \
    CONFIG.PSU__TCM0A__POWER__ON {1} \
    CONFIG.PSU__TCM0B__POWER__ON {1} \
    CONFIG.PSU__TCM1A__POWER__ON {1} \
    CONFIG.PSU__TCM1B__POWER__ON {1} \
    CONFIG.PSU__TESTSCAN__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__TRACE__INTERNAL_WIDTH {32} \
    CONFIG.PSU__TRACE__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__TRISTATE__INVERTED {1} \
    CONFIG.PSU__TTC0__CLOCK__ENABLE {0} \
    CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC0__PERIPHERAL__IO {MIO 6 .. 7} \
    CONFIG.PSU__TTC0__WAVEOUT__ENABLE {0} \
    CONFIG.PSU__TTC1__CLOCK__ENABLE {0} \
    CONFIG.PSU__TTC1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC1__PERIPHERAL__IO {MIO 12 .. 13} \
    CONFIG.PSU__TTC1__WAVEOUT__ENABLE {0} \
    CONFIG.PSU__TTC2__CLOCK__ENABLE {0} \
    CONFIG.PSU__TTC2__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC2__PERIPHERAL__IO {MIO 50 .. 51} \
    CONFIG.PSU__TTC2__WAVEOUT__ENABLE {0} \
    CONFIG.PSU__TTC3__CLOCK__ENABLE {0} \
    CONFIG.PSU__TTC3__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC3__PERIPHERAL__IO {MIO 56 .. 57} \
    CONFIG.PSU__TTC3__WAVEOUT__ENABLE {0} \
    CONFIG.PSU__UART0_LOOP_UART1__ENABLE {0} \
    CONFIG.PSU__UART0__BAUD_RATE {115200} \
    CONFIG.PSU__UART0__MODEM__ENABLE {0} \
    CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 18 .. 19} \
    CONFIG.PSU__UART1__BAUD_RATE {115200} \
    CONFIG.PSU__UART1__MODEM__ENABLE {0} \
    CONFIG.PSU__UART1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__UART1__PERIPHERAL__IO {MIO 20 .. 21} \
    CONFIG.PSU__USB0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__USB0__RESET__ENABLE {0} \
    CONFIG.PSU__USB1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__USB1__RESET__ENABLE {0} \
    CONFIG.PSU__USE_DIFF_RW_CLK_GP2 {0} \
    CONFIG.PSU__USE__ADMA {0} \
    CONFIG.PSU__USE__APU_LEGACY_INTERRUPT {0} \
    CONFIG.PSU__USE__AUDIO {0} \
    CONFIG.PSU__USE__CLK {0} \
    CONFIG.PSU__USE__CLK0 {0} \
    CONFIG.PSU__USE__CLK1 {0} \
    CONFIG.PSU__USE__CLK2 {0} \
    CONFIG.PSU__USE__CLK3 {0} \
    CONFIG.PSU__USE__CROSS_TRIGGER {0} \
    CONFIG.PSU__USE__DDR_INTF_REQUESTED {0} \
    CONFIG.PSU__USE__DEBUG__TEST {0} \
    CONFIG.PSU__USE__EVENT_RPU {0} \
    CONFIG.PSU__USE__FABRIC__RST {1} \
    CONFIG.PSU__USE__FTM {0} \
    CONFIG.PSU__USE__GDMA {0} \
    CONFIG.PSU__USE__IRQ {0} \
    CONFIG.PSU__USE__IRQ0 {1} \
    CONFIG.PSU__USE__IRQ1 {0} \
    CONFIG.PSU__USE__M_AXI_GP0 {1} \
    CONFIG.PSU__USE__M_AXI_GP1 {1} \
    CONFIG.PSU__USE__M_AXI_GP2 {0} \
    CONFIG.PSU__USE__PROC_EVENT_BUS {0} \
    CONFIG.PSU__USE__RPU_LEGACY_INTERRUPT {0} \
    CONFIG.PSU__USE__RST0 {0} \
    CONFIG.PSU__USE__RST1 {0} \
    CONFIG.PSU__USE__RST2 {0} \
    CONFIG.PSU__USE__RST3 {0} \
    CONFIG.PSU__USE__RTC {0} \
    CONFIG.PSU__USE__STM {0} \
    CONFIG.PSU__USE__S_AXI_ACE {0} \
    CONFIG.PSU__USE__S_AXI_ACP {0} \
    CONFIG.PSU__USE__S_AXI_GP0 {0} \
    CONFIG.PSU__USE__S_AXI_GP1 {0} \
    CONFIG.PSU__USE__S_AXI_GP2 {1} \
    CONFIG.PSU__USE__S_AXI_GP3 {0} \
    CONFIG.PSU__USE__S_AXI_GP4 {0} \
    CONFIG.PSU__USE__S_AXI_GP5 {0} \
    CONFIG.PSU__USE__S_AXI_GP6 {0} \
    CONFIG.PSU__USE__USB3_0_HUB {0} \
    CONFIG.PSU__USE__USB3_1_HUB {0} \
    CONFIG.PSU__USE__VIDEO {0} \
    CONFIG.PSU__VIDEO_REF_CLK__ENABLE {0} \
    CONFIG.PSU__VIDEO_REF_CLK__FREQMHZ {33.333} \
    CONFIG.QSPI_BOARD_INTERFACE {custom} \
    CONFIG.SATA_BOARD_INTERFACE {custom} \
    CONFIG.SD0_BOARD_INTERFACE {custom} \
    CONFIG.SD1_BOARD_INTERFACE {custom} \
    CONFIG.SPI0_BOARD_INTERFACE {custom} \
    CONFIG.SPI1_BOARD_INTERFACE {custom} \
    CONFIG.SUBPRESET1 {Custom} \
    CONFIG.SUBPRESET2 {Custom} \
    CONFIG.SWDT0_BOARD_INTERFACE {custom} \
    CONFIG.SWDT1_BOARD_INTERFACE {custom} \
    CONFIG.TRACE_BOARD_INTERFACE {custom} \
    CONFIG.TTC0_BOARD_INTERFACE {custom} \
    CONFIG.TTC1_BOARD_INTERFACE {custom} \
    CONFIG.TTC2_BOARD_INTERFACE {custom} \
    CONFIG.TTC3_BOARD_INTERFACE {custom} \
    CONFIG.UART0_BOARD_INTERFACE {custom} \
    CONFIG.UART1_BOARD_INTERFACE {custom} \
    CONFIG.USB0_BOARD_INTERFACE {custom} \
    CONFIG.USB1_BOARD_INTERFACE {custom} \
  ] $zusp_ps


  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins axi_pl_ps/S00_AXI]
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins ps_axi_periph/S00_AXI] [get_bd_intf_pins zusp_ps/M_AXI_HPM0_FPD]
  connect_bd_intf_net -intf_net S01_AXI_1 [get_bd_intf_pins S01_AXI] [get_bd_intf_pins axi_pl_ps/S01_AXI]
  connect_bd_intf_net -intf_net S02_AXI_1 [get_bd_intf_pins S02_AXI] [get_bd_intf_pins axi_pl_ps/S02_AXI]
  connect_bd_intf_net -intf_net axi_pl_ps_M00_AXI [get_bd_intf_pins axi_pl_ps/M00_AXI] [get_bd_intf_pins zusp_ps/S_AXI_HP0_FPD]
  connect_bd_intf_net -intf_net ps_axi_periph_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins ps_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net ps_axi_periph_M01_AXI [get_bd_intf_pins M01_AXI] [get_bd_intf_pins ps_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net ps_axi_periph_M02_AXI [get_bd_intf_pins M02_AXI] [get_bd_intf_pins ps_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net zusp_ps_M_AXI_HPM1_FPD [get_bd_intf_pins ps_axi_periph/S01_AXI] [get_bd_intf_pins zusp_ps/M_AXI_HPM1_FPD]

  # Create port connections
  connect_bd_net -net ACLK_1 [get_bd_pins zusp_ps/pl_clk0] [get_bd_pins clk_75] [get_bd_pins axi_pl_ps/ACLK] [get_bd_pins axi_pl_ps/S00_ACLK] [get_bd_pins axi_pl_ps/M00_ACLK] [get_bd_pins axi_pl_ps/S01_ACLK] [get_bd_pins axi_pl_ps/S02_ACLK] [get_bd_pins ps_axi_periph/ACLK] [get_bd_pins ps_axi_periph/S00_ACLK] [get_bd_pins ps_axi_periph/M00_ACLK] [get_bd_pins ps_axi_periph/M01_ACLK] [get_bd_pins ps_axi_periph/S01_ACLK] [get_bd_pins ps_axi_periph/M02_ACLK] [get_bd_pins ps_rst_75/slowest_sync_clk] [get_bd_pins zusp_ps/maxihpm0_fpd_aclk] [get_bd_pins zusp_ps/maxihpm1_fpd_aclk] [get_bd_pins zusp_ps/saxihp0_fpd_aclk]
  connect_bd_net -net ARESETN_1 [get_bd_pins ps_rst_75/interconnect_aresetn] [get_bd_pins axi_pl_ps/ARESETN] [get_bd_pins ps_axi_periph/ARESETN]
  connect_bd_net -net In0_1 [get_bd_pins In0] [get_bd_pins ps_irq_concat/In0]
  connect_bd_net -net In1_1 [get_bd_pins In1] [get_bd_pins ps_irq_concat/In1]
  connect_bd_net -net In2_1 [get_bd_pins In2] [get_bd_pins ps_irq_concat/In2]
  connect_bd_net -net In3_1 [get_bd_pins In3] [get_bd_pins ps_irq_concat/In3]
  connect_bd_net -net M00_ARESETN_1 [get_bd_pins ps_rst_75/peripheral_aresetn] [get_bd_pins perph_aresetn_75] [get_bd_pins axi_pl_ps/S00_ARESETN] [get_bd_pins axi_pl_ps/M00_ARESETN] [get_bd_pins axi_pl_ps/S01_ARESETN] [get_bd_pins axi_pl_ps/S02_ARESETN] [get_bd_pins ps_axi_periph/S00_ARESETN] [get_bd_pins ps_axi_periph/M00_ARESETN] [get_bd_pins ps_axi_periph/M01_ARESETN] [get_bd_pins ps_axi_periph/S01_ARESETN] [get_bd_pins ps_axi_periph/M02_ARESETN]
  connect_bd_net -net ps_irq_concat_dout [get_bd_pins ps_irq_concat/dout] [get_bd_pins zusp_ps/pl_ps_irq0]
  connect_bd_net -net ps_rst_75_peripheral_reset [get_bd_pins ps_rst_75/peripheral_reset] [get_bd_pins peripheral_reset]
  connect_bd_net -net zusp_ps_pl_clk1 [get_bd_pins zusp_ps/pl_clk1] [get_bd_pins clk_50]
  connect_bd_net -net zusp_ps_pl_resetn0 [get_bd_pins zusp_ps/pl_resetn0] [get_bd_pins ps_rst_75/ext_reset_in]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: other_perph
proc create_hier_cell_other_perph { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_other_perph() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI


  # Create pins
  create_bd_pin -dir I -type clk CLK
  create_bd_pin -dir I -type clk CLK1
  create_bd_pin -dir O -from 0 -to 0 Dout1
  create_bd_pin -dir O -from 0 -to 0 Dout2
  create_bd_pin -dir O -from 0 -to 0 Dout3
  create_bd_pin -dir O Res
  create_bd_pin -dir O -from 0 -to 0 dout
  create_bd_pin -dir O -type intr interrupt
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: axi_clk_led
  create_hier_cell_axi_clk_led $hier_obj axi_clk_led

  # Create instance: axi_timer_1, and set properties
  set axi_timer_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_1 ]

  # Create instance: mgt_tx_clk_led
  create_hier_cell_mgt_tx_clk_led $hier_obj mgt_tx_clk_led

  # Create instance: reset_invert_led, and set properties
  set reset_invert_led [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reset_invert_led ]
  set_property CONFIG.C_SIZE {1} $reset_invert_led


  # Create instance: rx_clk_led
  create_hier_cell_rx_clk_led $hier_obj rx_clk_led

  # Create instance: sfp_tx_disable, and set properties
  set sfp_tx_disable [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 sfp_tx_disable ]
  set_property -dict [list \
    CONFIG.CONST_VAL {1} \
    CONFIG.CONST_WIDTH {1} \
  ] $sfp_tx_disable


  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_timer_1/S_AXI]

  # Create port connections
  connect_bd_net -net CLK1_1 [get_bd_pins CLK1] [get_bd_pins mgt_tx_clk_led/CLK]
  connect_bd_net -net CLK_1 [get_bd_pins CLK] [get_bd_pins rx_clk_led/CLK]
  connect_bd_net -net axi_clk_led_Dout [get_bd_pins axi_clk_led/Dout] [get_bd_pins Dout3]
  connect_bd_net -net axi_timer_1_interrupt [get_bd_pins axi_timer_1/interrupt] [get_bd_pins interrupt]
  connect_bd_net -net mgt_tx_clk_led_Dout [get_bd_pins mgt_tx_clk_led/Dout] [get_bd_pins Dout2]
  connect_bd_net -net reset_invert_led_Res [get_bd_pins reset_invert_led/Res] [get_bd_pins Res]
  connect_bd_net -net rx_clk_led_Dout [get_bd_pins rx_clk_led/Dout] [get_bd_pins Dout1]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_clk_led/CLK] [get_bd_pins axi_timer_1/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins axi_timer_1/s_axi_aresetn] [get_bd_pins reset_invert_led/Op1]
  connect_bd_net -net sfp_tx_disable_dout [get_bd_pins sfp_tx_disable/dout] [get_bd_pins dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set mgt_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 mgt_clk ]

  set sfp [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:sfp_rtl:1.0 sfp ]


  # Create ports
  set axi_lite_clk_led [ create_bd_port -dir O -from 0 -to 0 axi_lite_clk_led ]
  set axil_reset_led [ create_bd_port -dir O axil_reset_led ]
  set mgt_clk_led [ create_bd_port -dir O -from 0 -to 0 mgt_clk_led ]
  set rx_clk_led [ create_bd_port -dir O -from 0 -to 0 rx_clk_led ]
  set sfp_tx_dis [ create_bd_port -dir O -from 0 -to 0 sfp_tx_dis ]

  # Create instance: axi_eth_0, and set properties
  set axi_eth_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernet:7.2 axi_eth_0 ]
  set_property -dict [list \
    CONFIG.PHYADDR {2} \
    CONFIG.PHY_TYPE {1000BaseX} \
    CONFIG.RXCSUM {Full} \
    CONFIG.RXMEM {32k} \
    CONFIG.Statistics_Reset {true} \
    CONFIG.TXCSUM {Full} \
    CONFIG.TXMEM {32k} \
    CONFIG.gtlocation {X1Y12} \
    CONFIG.gtrefclkrate {156.25} \
  ] $axi_eth_0


  # Create instance: axi_eth_0_dma, and set properties
  set axi_eth_0_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_eth_0_dma ]
  set_property -dict [list \
    CONFIG.c_include_mm2s_dre {1} \
    CONFIG.c_include_s2mm_dre {1} \
    CONFIG.c_sg_length_width {16} \
    CONFIG.c_sg_use_stsapp_length {1} \
  ] $axi_eth_0_dma


  # Create instance: other_perph
  create_hier_cell_other_perph [current_bd_instance .] other_perph

  # Create instance: zynq_ps
  create_hier_cell_zynq_ps [current_bd_instance .] zynq_ps

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins other_perph/S_AXI] [get_bd_intf_pins zynq_ps/M02_AXI]
  connect_bd_intf_net -intf_net axi_eth_0_dma_M_AXIS_CNTRL [get_bd_intf_pins axi_eth_0/s_axis_txc] [get_bd_intf_pins axi_eth_0_dma/M_AXIS_CNTRL]
  connect_bd_intf_net -intf_net axi_eth_0_dma_M_AXIS_MM2S [get_bd_intf_pins axi_eth_0/s_axis_txd] [get_bd_intf_pins axi_eth_0_dma/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net axi_eth_0_dma_M_AXI_MM2S [get_bd_intf_pins axi_eth_0_dma/M_AXI_MM2S] [get_bd_intf_pins zynq_ps/S01_AXI]
  connect_bd_intf_net -intf_net axi_eth_0_dma_M_AXI_S2MM [get_bd_intf_pins axi_eth_0_dma/M_AXI_S2MM] [get_bd_intf_pins zynq_ps/S02_AXI]
  connect_bd_intf_net -intf_net axi_eth_0_dma_M_AXI_SG [get_bd_intf_pins axi_eth_0_dma/M_AXI_SG] [get_bd_intf_pins zynq_ps/S00_AXI]
  connect_bd_intf_net -intf_net axi_eth_0_m_axis_rxd [get_bd_intf_pins axi_eth_0/m_axis_rxd] [get_bd_intf_pins axi_eth_0_dma/S_AXIS_S2MM]
  connect_bd_intf_net -intf_net axi_eth_0_m_axis_rxs [get_bd_intf_pins axi_eth_0/m_axis_rxs] [get_bd_intf_pins axi_eth_0_dma/S_AXIS_STS]
  connect_bd_intf_net -intf_net axi_eth_0_sfp [get_bd_intf_ports sfp] [get_bd_intf_pins axi_eth_0/sfp]
  connect_bd_intf_net -intf_net mgt_clk_1 [get_bd_intf_ports mgt_clk] [get_bd_intf_pins axi_eth_0/mgt_clk]
  connect_bd_intf_net -intf_net zynq_ps_M00_AXI [get_bd_intf_pins axi_eth_0_dma/S_AXI_LITE] [get_bd_intf_pins zynq_ps/M00_AXI]
  connect_bd_intf_net -intf_net zynq_ps_M01_AXI [get_bd_intf_pins axi_eth_0/s_axi] [get_bd_intf_pins zynq_ps/M01_AXI]

  # Create port connections
  connect_bd_net -net axi_eth_0_dma_mm2s_cntrl_reset_out_n [get_bd_pins axi_eth_0_dma/mm2s_cntrl_reset_out_n] [get_bd_pins axi_eth_0/axi_txc_arstn]
  connect_bd_net -net axi_eth_0_dma_mm2s_introut [get_bd_pins axi_eth_0_dma/mm2s_introut] [get_bd_pins zynq_ps/In0]
  connect_bd_net -net axi_eth_0_dma_mm2s_prmry_reset_out_n [get_bd_pins axi_eth_0_dma/mm2s_prmry_reset_out_n] [get_bd_pins axi_eth_0/axi_txd_arstn]
  connect_bd_net -net axi_eth_0_dma_s2mm_introut [get_bd_pins axi_eth_0_dma/s2mm_introut] [get_bd_pins zynq_ps/In1]
  connect_bd_net -net axi_eth_0_dma_s2mm_prmry_reset_out_n [get_bd_pins axi_eth_0_dma/s2mm_prmry_reset_out_n] [get_bd_pins axi_eth_0/axi_rxd_arstn]
  connect_bd_net -net axi_eth_0_dma_s2mm_sts_reset_out_n [get_bd_pins axi_eth_0_dma/s2mm_sts_reset_out_n] [get_bd_pins axi_eth_0/axi_rxs_arstn]
  connect_bd_net -net axi_eth_0_interrupt [get_bd_pins axi_eth_0/interrupt] [get_bd_pins zynq_ps/In2]
  connect_bd_net -net axi_eth_0_rxuserclk2_out [get_bd_pins axi_eth_0/rxuserclk2_out] [get_bd_pins other_perph/CLK]
  connect_bd_net -net axi_eth_0_userclk2_out [get_bd_pins axi_eth_0/userclk2_out] [get_bd_pins other_perph/CLK1]
  connect_bd_net -net other_perph_Dout1 [get_bd_pins other_perph/Dout1] [get_bd_ports rx_clk_led]
  connect_bd_net -net other_perph_Dout2 [get_bd_pins other_perph/Dout2] [get_bd_ports mgt_clk_led]
  connect_bd_net -net other_perph_Dout3 [get_bd_pins other_perph/Dout3] [get_bd_ports axi_lite_clk_led]
  connect_bd_net -net other_perph_Res [get_bd_pins other_perph/Res] [get_bd_ports axil_reset_led]
  connect_bd_net -net other_perph_dout [get_bd_pins other_perph/dout] [get_bd_ports sfp_tx_dis]
  connect_bd_net -net other_perph_interrupt [get_bd_pins other_perph/interrupt] [get_bd_pins zynq_ps/In3]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins zynq_ps/clk_75] [get_bd_pins other_perph/s_axi_aclk] [get_bd_pins axi_eth_0/s_axi_lite_clk] [get_bd_pins axi_eth_0/axis_clk] [get_bd_pins axi_eth_0_dma/s_axi_lite_aclk] [get_bd_pins axi_eth_0_dma/m_axi_sg_aclk] [get_bd_pins axi_eth_0_dma/m_axi_mm2s_aclk] [get_bd_pins axi_eth_0_dma/m_axi_s2mm_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins zynq_ps/perph_aresetn_75] [get_bd_pins other_perph/s_axi_aresetn] [get_bd_pins axi_eth_0/s_axi_lite_resetn] [get_bd_pins axi_eth_0_dma/axi_resetn]
  connect_bd_net -net zynq_ps_clk_50 [get_bd_pins zynq_ps/clk_50] [get_bd_pins axi_eth_0/ref_clk]

  # Create address segments
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_MM2S] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_DDR_LOW] -force
  assign_bd_address -offset 0xFFFC0000 -range 0x00040000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_MM2S] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_OCM] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_S2MM] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_DDR_LOW] -force
  assign_bd_address -offset 0xFFFC0000 -range 0x00040000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_S2MM] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_OCM] -force
  assign_bd_address -offset 0xFF9B0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_AFIFM6] -force
  assign_bd_address -offset 0xFFA50000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_AMS] -force
  assign_bd_address -offset 0xFFA00000 -range 0x00040000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_APM] -force
  assign_bd_address -offset 0xFF5E0000 -range 0x00020000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_CRL_APB] -force
  assign_bd_address -offset 0xFFCA0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_CSU] -force
  assign_bd_address -offset 0xFFC80000 -range 0x00020000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_CSUDMA] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_DDR_LOW] -force
  assign_bd_address -offset 0xFFCC0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_EFUSE] -force
  assign_bd_address -offset 0xFF020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_I2C0] -force
  assign_bd_address -offset 0xFF030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_I2C1] -force
  assign_bd_address -offset 0xFF180000 -range 0x00080000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_IOUSLCR] -force
  assign_bd_address -offset 0xFF300000 -range 0x00100000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_IPI] -force
  assign_bd_address -offset 0xFF990000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_IPI_BUFFERS] -force
  assign_bd_address -offset 0xFFA80000 -range 0x00080000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_LDMA] -force
  assign_bd_address -offset 0xFF400000 -range 0x00100000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_LPD_SLCR] -force
  assign_bd_address -offset 0xFF980000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_LPD_XPPU] -force
  assign_bd_address -offset 0xFF9C0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_LPD_XPPU_SINK] -force
  assign_bd_address -offset 0xFFCF0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_MBISTJTAG] -force
  assign_bd_address -offset 0xFFFC0000 -range 0x00040000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_OCM] -force
  assign_bd_address -offset 0xFF960000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_OCM_CTRL] -force
  assign_bd_address -offset 0xFFA70000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_OCM_XMPU_CFG] -force
  assign_bd_address -offset 0xFFD80000 -range 0x00040000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_PMU_GLOBAL] -force
  assign_bd_address -offset 0xFF9A0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_RPU] -force
  assign_bd_address -offset 0xFFCE0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_RSA] -force
  assign_bd_address -offset 0xFFA60000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_RTC] -force
  assign_bd_address -offset 0xFF170000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_SD1] -force
  assign_bd_address -offset 0xFF110000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_TTC0] -force
  assign_bd_address -offset 0xFF120000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_TTC1] -force
  assign_bd_address -offset 0xFF130000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_TTC2] -force
  assign_bd_address -offset 0xFF140000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_TTC3] -force
  assign_bd_address -offset 0xFF000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_UART0] -force
  assign_bd_address -offset 0xFF010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_eth_0_dma/Data_SG] [get_bd_addr_segs zynq_ps/zusp_ps/SAXIGP2/HP0_UART1] -force
  assign_bd_address -offset 0xA0000000 -range 0x00040000 -target_address_space [get_bd_addr_spaces zynq_ps/zusp_ps/Data] [get_bd_addr_segs axi_eth_0/s_axi/Reg0] -force
  assign_bd_address -offset 0xA0040000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ps/zusp_ps/Data] [get_bd_addr_segs axi_eth_0_dma/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0050000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ps/zusp_ps/Data] [get_bd_addr_segs other_perph/axi_timer_1/S_AXI/Reg] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


