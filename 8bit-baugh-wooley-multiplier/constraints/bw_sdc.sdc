# SDC File for 8-bit Baugh-Wooley Multiplier
# (Combinational Design - No Internal Clock)
# 1. Virtual Clock Definition
# Used only for timing reference (not physically present)
create_clock -name virtual_clk -period 10
# 2. Input Delay Constraints
# Inputs arrive 2ns after reference clock edge
set_input_delay -clock virtual_clk 2 [get_ports a]
set_input_delay -clock virtual_clk 2 [get_ports b]
# 3. Output Delay Constraints
# Outputs required within 2ns before next clock edge
set_output_delay -clock virtual_clk 2 [get_ports p]
# 4. Input Driving Cell
# Models the source driving strength
set_driving_cell -lib_cell INVX1 [get_ports a]
set_driving_cell -lib_cell INVX1 [get_ports b]
# 5. Output Load
# Models load capacitance on outputs

set_load 0.05 [get_ports p]
# 6. Input Transition
# Slew at inputs
set_input_transition 0.1 [get_ports a]
set_input_transition 0.1 [get_ports b]
# 7. Operating Conditions
# Best case / worst case analysis
set_operating_conditions -analysis_type bc_wc
# NOTES:
# - No create_clock on ports (since no clk in RTL)
# - No set_false_path (we WANT timing analysis)
# - No clock uncertainty (not needed for virtual clock)