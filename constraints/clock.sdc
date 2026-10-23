
# ============================================================
# Programmable Sound Generator (PSG)
# Static Timing Analysis Constraints
# Target: SKY130A
# Clock frequency: 25 MHz
# Clock period: 40 ns
# ============================================================

# Define the main clock
create_clock -name clk -period 40.000 [get_ports clk]

# Clock uncertainty
set_clock_uncertainty 0.200 [get_clocks clk]

# Input delays relative to the main clock
set_input_delay 8.000 -clock clk [get_ports {reset enable tone_select[0] tone_select[1]}]

# Output delay relative to the main clock
set_output_delay 8.000 -clock clk [get_ports sound_out]
