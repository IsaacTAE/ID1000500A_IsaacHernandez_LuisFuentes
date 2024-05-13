onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Red /conv_TB/start
add wave -noupdate /conv_TB/rstn
add wave -noupdate /conv_TB/done
add wave -noupdate /conv_TB/busy
add wave -noupdate -color Yellow /conv_TB/clk
add wave -noupdate -expand -group memX /conv_TB/conv_DUT/memX_addr_en_ff
add wave -noupdate -expand -group memX -radix unsigned /conv_TB/memX_addr
add wave -noupdate -expand -group memX -radix unsigned /conv_TB/dataX
add wave -noupdate -expand -group memY /conv_TB/conv_DUT/memY_addr_en_ff
add wave -noupdate -expand -group memY -radix unsigned /conv_TB/memY_addr
add wave -noupdate -expand -group memY -radix unsigned /conv_TB/dataY
add wave -noupdate -expand -group memZ /conv_TB/writeZ
add wave -noupdate -expand -group memZ -radix unsigned /conv_TB/memZ_addr
add wave -noupdate -expand -group memZ -radix unsigned -childformat {{{/conv_TB/dataZ[15]} -radix unsigned} {{/conv_TB/dataZ[14]} -radix unsigned} {{/conv_TB/dataZ[13]} -radix unsigned} {{/conv_TB/dataZ[12]} -radix unsigned} {{/conv_TB/dataZ[11]} -radix unsigned} {{/conv_TB/dataZ[10]} -radix unsigned} {{/conv_TB/dataZ[9]} -radix unsigned} {{/conv_TB/dataZ[8]} -radix unsigned} {{/conv_TB/dataZ[7]} -radix unsigned} {{/conv_TB/dataZ[6]} -radix unsigned} {{/conv_TB/dataZ[5]} -radix unsigned} {{/conv_TB/dataZ[4]} -radix unsigned} {{/conv_TB/dataZ[3]} -radix unsigned} {{/conv_TB/dataZ[2]} -radix unsigned} {{/conv_TB/dataZ[1]} -radix unsigned} {{/conv_TB/dataZ[0]} -radix unsigned}} -subitemconfig {{/conv_TB/dataZ[15]} {-height 17 -radix unsigned} {/conv_TB/dataZ[14]} {-height 17 -radix unsigned} {/conv_TB/dataZ[13]} {-height 17 -radix unsigned} {/conv_TB/dataZ[12]} {-height 17 -radix unsigned} {/conv_TB/dataZ[11]} {-height 17 -radix unsigned} {/conv_TB/dataZ[10]} {-height 17 -radix unsigned} {/conv_TB/dataZ[9]} {-height 17 -radix unsigned} {/conv_TB/dataZ[8]} {-height 17 -radix unsigned} {/conv_TB/dataZ[7]} {-height 17 -radix unsigned} {/conv_TB/dataZ[6]} {-height 17 -radix unsigned} {/conv_TB/dataZ[5]} {-height 17 -radix unsigned} {/conv_TB/dataZ[4]} {-height 17 -radix unsigned} {/conv_TB/dataZ[3]} {-height 17 -radix unsigned} {/conv_TB/dataZ[2]} {-height 17 -radix unsigned} {/conv_TB/dataZ[1]} {-height 17 -radix unsigned} {/conv_TB/dataZ[0]} {-height 17 -radix unsigned}} /conv_TB/dataZ
add wave -noupdate -expand -group i -radix unsigned /conv_TB/conv_DUT/i_reg
add wave -noupdate -expand -group i -radix unsigned /conv_TB/conv_DUT/i_nxt
add wave -noupdate -expand -group j -radix unsigned /conv_TB/conv_DUT/j_reg
add wave -noupdate -expand -group j -radix unsigned /conv_TB/conv_DUT/j_nxt
add wave -noupdate -group k -radix unsigned /conv_TB/conv_DUT/k_reg
add wave -noupdate -group comp_i_sizeY /conv_TB/conv_DUT/FSM/comp_i_sizeY_in
add wave -noupdate -group comp_i_sizeY -radix unsigned /conv_TB/conv_DUT/comparator_I_sizeY/A_i
add wave -noupdate -group comp_i_sizeY -radix unsigned /conv_TB/conv_DUT/comparator_I_sizeY/B_i
add wave -noupdate -expand -group comp_j_valid /conv_TB/conv_DUT/comp_j_valid
add wave -noupdate -expand -group comp_j_valid /conv_TB/conv_DUT/comp_j_sizeX
add wave -noupdate -expand -group comp_j_valid /conv_TB/conv_DUT/comp_j_i
add wave -noupdate /conv_TB/conv_DUT/FSM/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {960 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 191
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
WaveRestoreZoom {667 ps} {973 ps}
