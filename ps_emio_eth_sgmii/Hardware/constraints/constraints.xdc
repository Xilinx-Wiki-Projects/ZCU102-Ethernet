#sfp1
set_property PACKAGE_PIN A13 [get_ports {sfp_tx_dis[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sfp_tx_dis[0]}]
set_property PACKAGE_PIN D6 [get_ports s*_txp]
set_property PACKAGE_PIN D5 [get_ports s*_txn]
set_property PACKAGE_PIN C4 [get_ports s*_rxp]
set_property PACKAGE_PIN C3 [get_ports s*_rxn]

#USER_MGT_SI570_CLOCK2_C_P
set_property PACKAGE_PIN C7 [get_ports gtrefclk_in_clk_n]
set_property PACKAGE_PIN C8 [get_ports gtrefclk_in_clk_p]

#set_property IOSTANDARD LVCMOS25 [get_ports mgt_clk_*]
create_clock -name gt_ref_clk -period 6.4 [get_ports gtrefclk_in_clk_p]


#LEDs
set_property IOSTANDARD LVCMOS25 [get_ports *led]
#GPIO_LED[0]
set_property PACKAGE_PIN AG14 [get_ports {xcvr_rst_done_led[0]}]
#GPIO_LED[1]
set_property PACKAGE_PIN AF13 [get_ports {link_status_led[0]}]
#GPIO_LED[2]
set_property PACKAGE_PIN AE13 [get_ports {link_sync_led[0]}]
#GPIO_LED[3]
set_property PACKAGE_PIN AJ14 [get_ports {pcs_clk_led[0]}]
#GPIO_LED[4]
#set_property PACKAGE_PIN    aj15  [get_ports rx_clk_led]
#GPIO_LED[5]
set_property PACKAGE_PIN AH13 [get_ports {pl_reset_led[0]}]
#GPIO_LED[6]
set_property PACKAGE_PIN AH14 [get_ports {mdc_clk_led[0]}]
#GPIO_LED[7]
set_property PACKAGE_PIN AL12 [get_ports {gmii_rx_clk_led[0]}]

