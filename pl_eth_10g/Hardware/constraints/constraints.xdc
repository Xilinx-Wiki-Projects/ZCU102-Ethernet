## enable tx by forcing 0 from design. sfp0,1,2,3 => a12, a13, b13, c13
set_property PACKAGE_PIN B13 [get_ports {sfp_tx_dis[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sfp_tx_dis[0]}]

#sfp2
set_property PACKAGE_PIN B2 [get_ports gt_rx_gt_port_0_p]
set_property PACKAGE_PIN B1 [get_ports gt_rx_gt_port_0_n]
set_property PACKAGE_PIN B6 [get_ports gt_tx_gt_port_0_p]
set_property PACKAGE_PIN B5 [get_ports gt_tx_gt_port_0_n]

#USER_MGT_SI570_CLOCK2_C_P
set_property PACKAGE_PIN C8 [get_ports gt_ref_clk_clk_p]
#create_clock -period 6.400 -name gt_ref_clk [get_ports gt_ref_clk_clk_p]

#LED 2 and 3
# led 0 .. 7 => ag14, af13, ae13, aj14, aj15, ah13, ah14, al12
#set_property IOSTANDARD LVCMOS25 [get_ports *led]
#set_property PACKAGE_PIN AF13 [get_ports axil_reset_led]
#set_property PACKAGE_PIN AJ14 [get_ports {axi_lite_clk_led[0]}]
#set_property PACKAGE_PIN AH13 [get_ports {mgt_clk_led[0]}]
#set_property PACKAGE_PIN AH14 [get_ports {rx_clk_led[0]}]
#set_property PACKAGE_PIN AG14 [get_ports {sys_reset_led}]
#set_property PACKAGE_PIN AL12 [get_ports {gtwiz_rst_led}]

#CR 965826
#set_max_delay -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] -datapath_only 6.40
#set_max_delay -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] -datapath_only 6.40
#set_max_delay -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] -to [get_clocks clk_pl_0] -datapath_only 6.40
#set_max_delay -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks clk_pl_0] -datapath_only 6.40
#set_max_delay -from [get_clocks clk_pl_0] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] -datapath_only 10.000
#set_max_delay -from [get_clocks clk_pl_0] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] -datapath_only 10.000


