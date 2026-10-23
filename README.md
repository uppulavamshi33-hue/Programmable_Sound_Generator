# Programmable Sound Generator (PSG) — RTL to GDSII Using SKY130

| | |
|---|---|
| **Name** | U.VAMSHI |
| **Roll No** | 24EG104C63 |
| **Branch** | ECE-C |
| **PDK / Library** | SKY130A / `sky130_fd_sc_hd`|

<img width="1536" height="1024" alt="PSG VLSI_ Real-World Sound Solutions" src="https://github.com/user-attachments/assets/2e5d6d9f-ab26-4d60-a761-0640523e1cb8" />

## 📌 Project Overview

The **Programmable Sound Generator (PSG)** is a digital VLSI design implemented using Verilog HDL and targeted for the **SkyWater SKY130 standard-cell technology**. The design generates square-wave audio tones using counter-based frequency division and programmable tone selection.

The project demonstrates the complete ASIC implementation flow, starting from RTL design and functional simulation through logic synthesis, static timing analysis (STA), physical design using OpenLane, and final GDSII layout generation.

The primary objective is to design, simulate, synthesize, and physically implement a compact sequential digital circuit while analyzing its timing, area, and physical verification results.

## 🎯 Project Objectives

- Design a synthesizable Programmable Sound Generator using Verilog HDL.
- Implement sequential logic using counters and registers.
- Generate selectable audio tones using frequency-divider logic.
- Verify the RTL functionality through testbench simulation.
- Perform logic synthesis using Yosys.
- Analyze timing constraints and critical paths using OpenSTA.
- Implement the physical design using OpenLane and SKY130 standard cells.
- Generate the final GDSII layout.
- Evaluate area, timing, and physical verification reports.
- Target a die size of **100 µm × 100 µm**.

## ⚙️ Design Specifications

| Parameter | Specification |
|---|---|
| Project name | Programmable Sound Generator |
| Design name | `psg` |
| Hardware description language | Verilog HDL |
| Target technology | SKY130A |
| Standard-cell library | `sky130_fd_sc_hd` |
| RTL top module | `psg` |
| Clock input | `clk` |
| Reset input | `reset` |
| Enable input | `enable` |
| Tone selection | `tone_select[1:0]` |
| Audio output | `sound_out` |
| Counter width | 16 bits |
| Target die size | 100 µm × 100 µm |
| Configured clock period | 40 ns |
| Configured clock frequency | 25 MHz |
| Physical design flow | OpenLane |
| Layout output | GDSII |

*Note: The clock frequency is the configured digital design clock frequency. The generated audio tone frequency is determined by the counter-divider logic and the actual implemented RTL.*

## 🧩 Design Architecture

The PSG design uses a clock-driven counter and programmable tone-selection logic to generate a square-wave output.

```text
                 +----------------------+
 Clock (clk) --->|                      |
 Reset (reset) ->|  Counter and Control |
 Enable -------->|                      |
                 +-----------+----------+
                             |
                             v
                 +----------------------+
 Tone Selection->| Frequency Selection  |
 tone_select[1:0]| / Terminal Count     |
                 +-----------+----------+
                             |
                             v
                 +----------------------+
                 | Output Toggle Logic  |
                 +-----------+----------+
                             |
                             v
                       sound_out
```

### Main Functional Blocks

**1. Clock and Reset Logic**

- `clk` synchronizes the sequential logic.
- `reset` initializes the counter and output state.
- The reset behavior follows the implementation in the RTL source.

**2. Counter**

- A 16-bit counter tracks clock cycles.
- The counter is used to determine when the output should toggle.

**3. Tone Selection Logic**

- `tone_select[1:0]` selects between four tone settings.
- The nominal target tone options are 440 Hz, 523 Hz, 659 Hz, and 784 Hz.
- The exact output frequencies depend on the terminal-count values, clock frequency, and toggle behavior implemented in the RTL.

**4. Output Toggle Logic**

- The `sound_out` signal changes state when the programmed terminal count is reached.
- The resulting waveform is a digital square wave.

**5. Enable Control**

- `enable` controls tone generation according to the RTL implementation.

## 🔌 Input and Output Signals

| Signal | Direction | Width | Description |
|---|---|---:|---|
| `clk` | Input | 1 bit | System clock |
| `reset` | Input | 1 bit | Reset control |
| `enable` | Input | 1 bit | Enables tone generation |
| `tone_select` | Input | 2 bits | Selects one of four tone settings |
| `sound_out` | Output | 1 bit | Generated digital audio waveform |

## 🛠️ Tools and Technologies

| Tool / Technology | Purpose |
|---|---|
| Verilog HDL | RTL design |
| Icarus Verilog | RTL simulation |
| GTKWave | Waveform inspection |
| Yosys | Logic synthesis |
| OpenSTA | Static timing analysis |
| OpenLane | ASIC physical design flow |
| SKY130A PDK | Target process design kit |
| Magic | Layout inspection and physical verification |
| KLayout | GDSII layout viewing and inspection |

## 🔄 Complete RTL-to-GDSII Flow

The project follows the standard digital ASIC design flow:

```text
        Verilog RTL Design
                 |
                 v
        RTL Testbench Simulation
                 |
                 v
        Functional Waveform Check
                 |
                 v
        Logic Synthesis (Yosys)
                 |
                 v
        Static Timing Analysis
                 |
                 v
        Floorplanning
                 |
                 v
        Standard-Cell Placement
                 |
                 v
        Clock-Tree Synthesis
                 |
                 v
        Global and Detailed Routing
                 |
                 v
        Parasitic Extraction (SPEF)
                 |
                 v
        Post-Route Timing Analysis
                 |
                 v
        Physical Verification
                 |
                 v
        Final GDSII Layout
```

## 📁 Repository Structure

```text
PSG_Project/
│
├── README.md
│
├── rtl/
│   └── psg.v
│
├── tb/
│   └── psg_tb.v
|__ gls/
|    |__psg_gls
│    |__tb_psg_gls.v
|
├── constraints/
│   └── clock.sdc
│
├── simulation/
│   ├── psg.sim
|   |__psg_sky_130_power.v
│   
│
├── synthesis/
│   ├── psg_synth.v
│   └── psg_sky130.v
│ 
│
├── openlane/
│   ├── config.tcl
│   |── config.json
|   |__pin_order_cfg  
│
├── timing/
│   └── reports/
│       ├── postlayout_setup_hold_report.txt
│       └── prelayout_setup_hold_report.txt
│
├── results/
│   |
|   ├── reports/
│   │   └── final_summary.txt
│   └──psg.gds
│       
│
├── screenshots/
|    ├── rtl/
|    ├── simulation/
|    ├── synthesis/
|    ├── floorplan/
|    ├── placement/
|    ├── cts/
|    ├── routing/
|    
|___verification_report
      |__ psg_antenna_report.rpt
      |__ psg_drc_report.txt
      |__ psg_lvs_report.log  
      |

``` 

*This is a recommended documentation structure. Keep only files and directories that actually exist in your repository, or create them before linking them here.*

## 🧪 RTL Simulation

RTL simulation verifies the functional behavior of the design before synthesis.

### Simulation Objectives

- Verify reset operation.
- Verify tone generation when `enable` is asserted.
- Check tone-selection changes.
- Inspect the output waveform.
- Verify behavior when tone generation is disabled.

### Example Commands

Run these commands from the project root, assuming the RTL and testbench paths shown above:

```bash
mkdir -p simulation
iverilog -g2012 -o simulation/psg_sim rtl/psg.v tb/psg_tb.v
vvp simulation/psg_sim
gtkwave simulation/psg.vcd
```

The testbench must contain the appropriate `$dumpfile` and `$dumpvars` statements for the VCD output to be generated at that path.

### Expected Waveform Observations

- The clock toggles continuously.
- Reset initializes the sequential state.
- Enabling the circuit allows the tone-generation logic to operate.
- Different tone selections change the output-toggle interval.
- `sound_out` produces a digital square wave when tone generation is active.

**Evidence:** Add a genuine GTKWave screenshot to `evidences/simulation/` and link it here once available.

## 🔧 Logic Synthesis

Logic synthesis converts the Verilog RTL into a mapped gate-level implementation using the target standard-cell library.

### Synthesis Tool

**Yosys**

### Example Synthesis Command

Run from the directory containing the `rtl/` folder:

```bash
mkdir -p reports
yosys -p "read_verilog rtl/psg.v; hierarchy -check -top psg; synth -top psg; stat; write_verilog reports/psg_synth.v"
```

### Synthesis Objectives

- Check the RTL hierarchy.
- Synthesize the top-level module.
- Map the design to available logic cells.
- Inspect the cell statistics.
- Record the synthesized cell area and sequential-cell count.

### Reported Synthesis Snapshot

A previously recorded synthesis result showed:

| Metric | Recorded value |
|---|---:|
| Mapped cell count | 123 |
| Cell area | 1148.6016 µm² |

These values are a **previously recorded snapshot** and should be reconfirmed against the final synthesis report before being treated as the definitive result.

## ⏱️ Static Timing Analysis (STA)

Static timing analysis evaluates whether the implemented logic satisfies the configured timing constraints.

### Timing Configuration

| Parameter | Value |
|---|---:|
| Clock period | 40 ns |
| Clock frequency | 25 MHz |
| Input delay | 8 ns |
| Output delay | 8 ns |
| Timing tool | OpenSTA |

### Selected Reported Timing Checks

The following values were recorded from the project's timing reports:

| Timing check | Reported slack | Status |
|---|---:|---|
| Reset removal | +8.05 ns | MET |
| Register-to-register hold | +0.26 ns | MET |
| Reset recovery | +31.42 ns | MET |
| Input-to-register setup | +28.35 ns | MET |

These are selected checks from the recorded SPEF timing report, not a substitute for complete timing sign-off. Confirm the final reports, timing corners, clock definitions, and all required setup and hold paths before claiming that all timing requirements pass.

The recorded summary reports also showed:

- Worst negative slack (WNS): 0.00 ns
- Total negative slack (TNS): 0.00 ns

A zero WNS/TNS summary should be interpreted alongside the detailed timing reports, particularly where reports indicate that no paths were found.

## 🏗️ Physical Design Using OpenLane

OpenLane automates the major stages of digital ASIC implementation using the SKY130 technology platform.

### Physical Design Stages

**1. Floorplanning**

Defines the die/core boundaries and establishes the initial physical layout.

**2. Placement**

Places the synthesized standard cells within the core area.

**3. Clock-Tree Synthesis (CTS)**

Builds the clock distribution network for sequential cells.

**4. Routing**

Creates interconnections between standard cells and design pins using metal layers.

**5. Parasitic Extraction**

Extracts interconnect parasitics for more realistic post-layout timing analysis.

**6. GDSII Generation**

Produces the physical layout database used in the final layout deliverable.

### OpenLane Configuration Snapshot

The project's recorded configuration included:

```tcl
set ::env(DESIGN_NAME) "psg"
set ::env(CLOCK_PERIOD) "40.000"
set ::env(CLOCK_PORT) "clk"
set ::env(CELL_PAD) 4
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 100 100"
set ::env(SYNTH_MAX_FANOUT) 6
set ::env(FP_CORE_UTIL) 30
set ::env(PL_TARGET_DENSITY) 0.40
```

These are selected settings from the recorded configuration. Check the actual `config.tcl` for the complete and current configuration.

### Physical Design Area

The configured die boundary is:

- Width: 100 µm
- Height: 100 µm
- Total die area: 10,000 µm²

A recorded floorplan core boundary was approximately:

- Core width: 88.96 µm
- Core height: 78.24 µm

The configured core utilization target was 30%. The final measured utilization should be obtained from the completed OpenLane reports rather than inferred from the configuration.

## 🖼️ Physical Design Evidence
<img width="1007" height="757" alt="psg_floorplan" src="https://github.com/user-attachments/assets/cf257847-eb2d-4b21-92a8-e7921e1870c3" />

<img width="1010" height="742" alt="psg_cts" src="https://github.com/user-attachments/assets/2d0b19ad-736d-4349-b817-a56f87cec233" />

<img width="1010" height="755" alt="psg_placement" src="https://github.com/user-attachments/assets/239c050f-0292-4451-b502-81d88f774d78" />

<img width="1001" height="750" alt="psg_routing" src="https://github.com/user-attachments/assets/dea190ba-4e2b-4cb2-924d-8ec4bf3e3add" />

<img width="1003" height="748" alt="psg_gds" src="https://github.com/user-attachments/assets/50e5a355-0ee4-422c-ab27-93fc68f99ba6" />

| Stage | Suggested evidence file |
|---|---|
| RTL simulation | `evidences/simulation/psg_waveform.png` |
| Synthesis | `evidences/synthesis/psg_synthesis.png` |
| Floorplan | `evidences/floorplan/psg_floorplan.png` |
| Placement | `evidences/placement/psg_placement.png` |
| Clock-tree synthesis | `evidences/cts/psg_cts.png` |
| Routing | `evidences/routing/psg_routing.png` |
| Final layout | `evidences/routing/psg_gds_layout.png` |
| Timing analysis | `evidences/timing/psg_timing_report.png` |
| Physical verification | `evidences/verification/psg_verification.png` |

<img width="997" height="742" alt="psg_vcd" src="https://github.com/user-attachments/assets/0683b41e-1145-4535-b5a3-e708946d9aa8" />


<img width="1006" height="746" alt="psg_gls_vcd(2)" src="https://github.com/user-attachments/assets/1f8e6ea7-7b11-4cc3-bb21-7dfb5712d5d0" />

## ✅ Physical Verification

Physical verification checks whether the layout satisfies the applicable design rules and connectivity requirements.

The project run included physical verification stages such as DRC, LVS, and antenna checks.

### Recorded Verification Notes

| Check | Recorded information |
|---|---|
| Magic DRC | 0 violations reported in the recorded notes |
| Antenna violations | 0 pin violations and 0 net violations recorded |
| KLayout violation field | `-1` in the recorded result; status requires investigation |
| LVS | Final pass/fail status not yet confirmed |

The final repository should include the full DRC, LVS, and antenna reports. A stage appearing in a log does not by itself prove that verification passed.

## 📊 Results Summary

| Parameter | Project information |
|---|---|
| RTL top module | `psg` |
| Target technology | SKY130A |
| Standard-cell library | `sky130_fd_sc_hd` |
| Configured die size | 100 µm × 100 µm |
| Configured clock period | 40 ns |
| Recorded mapped cells | 123 |
| Previously recorded synthesis cell area | 1148.6016 µm² |
| Selected reported timing checks | Positive slack; marked MET |
| Recorded Magic DRC | 0 violations |
| Final LVS status | To be confirmed |
| Final GDSII output | Generated during the recorded run; verify the final file |

### Final Deliverables

- Synthesizable Verilog RTL.
- RTL testbench.
- RTL simulation waveform.
- Synthesis netlist and statistics.
- Timing constraints and STA reports.
- OpenLane configuration.
- Floorplan, placement, CTS, and routing evidence.
- Physical verification reports.
- Final GDSII layout.

## 🚀 Reproducing the Project

1. Obtain the project RTL, testbench, and OpenLane configuration.
2. Set up the required Verilog simulation tools and SKY130/OpenLane environment.
3. Run the RTL simulation and inspect the waveform.
4. Synthesize the RTL using Yosys.
5. Review synthesis statistics and timing constraints.
6. Run the OpenLane physical design flow.
7. Review floorplan, placement, CTS, routing, and parasitic-extraction results.
8. Examine the final timing and physical verification reports.
9. Confirm the final GDSII file and document the measured results.

Exact commands for the physical flow depend on the OpenLane installation and version used for this project.

## 📚 Documentation

Detailed project documentation can be maintained in the `docs/` directory:

- Project overview and architecture
- RTL design explanation
- Testbench design and verification
- RTL simulation and waveform analysis
- Logic synthesis and cell statistics
- OpenLane physical implementation
- Static timing analysis
- Physical verification
- Final area, timing, and layout results

## 🔮 Future Improvements

- Add additional programmable tone options.
- Improve testbench coverage for reset, enable, and tone-selection transitions.
- Add automated waveform checks and assertions.
- Compare pre-layout and post-layout timing results.
- Document timing results across all required supported corners.
- Investigate any unresolved physical verification or timing-report warnings.
- Add reproducible scripts for simulation, synthesis, and report collection.

## 👨‍💻 Author

**U VAMSHI**  
Branch: ECE-C
Roll No:24EG104C63
