
# ============================================================
# Programmable Sound Generator (PSG)
# OpenLane Configuration - SKY130A
# ============================================================

set ::env(DESIGN_NAME) "psg"

# RTL source inside the OpenLane design directory
set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/src/*.v]

# Clock configuration
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "40.000"

# Die dimensions: 100 um x 100 um
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 100 100"

# Floorplan configuration
set ::env(CELL_PAD) 4
set ::env(FP_CORE_UTIL) 30

# Placement configuration
set ::env(PL_TARGET_DENSITY) 0.40

# Synthesis configuration
set ::env(SYNTH_MAX_FANOUT) 6
