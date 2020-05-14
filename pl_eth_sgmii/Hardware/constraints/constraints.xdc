# Copyright 2020 Xilinx Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#sfp1
set_property PACKAGE_PIN A13 [get_ports sfp_tx_dis]
set_property IOSTANDARD LVCMOS33 [get_ports sfp_tx_dis]
set_property PACKAGE_PIN D6 [get_ports s*_txp]
set_property PACKAGE_PIN D5 [get_ports s*_txn]
set_property PACKAGE_PIN C4 [get_ports s*_rxp]
set_property PACKAGE_PIN C3 [get_ports s*_rxn]

#USER_MGT_SI570_CLOCK2_C_P
set_property PACKAGE_PIN C8      [get_ports mgt_clk_clk_p]

#set_property IOSTANDARD LVCMOS25 [get_ports mgt_clk_*]
create_clock -name gt_ref_clk -period 6.4 [get_ports mgt_clk_clk_p]

#LED 2 and 3
# led 0 .. 7 => ag14, af13, ae13, aj14, aj15, ah13, ah14, al12
set_property IOSTANDARD LVCMOS25 [get_ports *led]
#set_property PACKAGE_PIN    ag14  [get_ports axil_resetN_led]
set_property PACKAGE_PIN    af13  [get_ports axil_reset_led]
#set_property PACKAGE_PIN    ae13  [get_ports axi_lite_clkN_led]
set_property PACKAGE_PIN    aj14  [get_ports axi_lite_clk_led]
#set_property PACKAGE_PIN    aj15  [get_ports mgt_clkN_led]
set_property PACKAGE_PIN    ah13  [get_ports mgt_clk_led]
set_property PACKAGE_PIN    ah14  [get_ports rx_clk_led]