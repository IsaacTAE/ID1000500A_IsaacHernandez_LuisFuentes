onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /conv_TB/conv_DUT/done_out
add wave -noupdate /conv_TB/conv_DUT/clk
add wave -noupdate /conv_TB/conv_DUT/busy_out
add wave -noupdate /conv_TB/conv_DUT/writeZ
add wave -noupdate -radix unsigned /conv_TB/conv_DUT/dataZ
add wave -noupdate -radix unsigned /conv_TB/conv_DUT/dataY
add wave -noupdate -radix unsigned /conv_TB/conv_DUT/dataX
add wave -noupdate /conv_TB/conv_DUT/comp_j_sizeX
add wave -noupdate /conv_TB/conv_DUT/comp_j_i
add wave -noupdate /conv_TB/conv_DUT/comp_i_sizeY
add wave -noupdate /conv_TB/conv_DUT/comp_i_sizeX
add wave -noupdate -childformat {{{/conv_TB/memZ_ram/RAM_structure[18]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[17]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[16]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[15]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[14]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[13]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[12]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[11]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[10]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[9]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[8]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[7]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[6]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[5]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[4]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[3]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[2]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[1]} -radix unsigned} {{/conv_TB/memZ_ram/RAM_structure[0]} -radix unsigned}} -expand -subitemconfig {{/conv_TB/memZ_ram/RAM_structure[18]} {-height 17 -radix unsigned} {/conv_TB/memZ_ram/RAM_structure[17]} {-height 17 -radix unsigned} {/conv_TB/memZ_ram/RAM_structure[16]} {-height 17 -radix unsigned} {/conv_TB/memZ_ram/RAM_structure[15]} {-height 17 -radix unsigned} {/conv_TB/memZ_ram/RAM_structure[14]} {-height 17 -radix unsigned} {/conv_TB/memZ_ram/RAM_structure[13]} {-height 17 -radix unsigned} {/conv_TB/memZ_ram/RAM_structure[12]} {-height 17 -radix unsigned} {/conv_TB/memZ_ram/RAM_structure[11]} {-height 17 -radix unsigned} {/conv_TB/memZ_ram/RAM_structure[10]} {-height 17 -radix unsigned} {/conv_TB/memZ_ram/RAM_structure[9]} {-radix unsigned} {/conv_TB/memZ_ram/RAM_structure[8]} {-radix unsigned} {/conv_TB/memZ_ram/RAM_structure[7]} {-radix unsigned} {/conv_TB/memZ_ram/RAM_structure[6]} {-radix unsigned} {/conv_TB/memZ_ram/RAM_structure[5]} {-radix unsigned} {/conv_TB/memZ_ram/RAM_structure[4]} {-radix unsigned} {/conv_TB/memZ_ram/RAM_structure[3]} {-radix unsigned} {/conv_TB/memZ_ram/RAM_structure[2]} {-radix unsigned} {/conv_TB/memZ_ram/RAM_structure[1]} {-radix unsigned} {/conv_TB/memZ_ram/RAM_structure[0]} {-radix unsigned}} /conv_TB/memZ_ram/RAM_structure
add wave -noupdate {/conv_TB/memY_ram/RAM_structure[6]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6652 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {12928 ps}
