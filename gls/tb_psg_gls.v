
`timescale 1ns/1ps

module tb_psg_gls;

    reg clk;
    reg reset;
    reg enable;
    reg [1:0] tone_select;
    wire sound_out;

    // Gate-level design under test
    psg dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .tone_select(tone_select),
        .sound_out(sound_out)
    );

    // 25 MHz clock: 40 ns period
    initial clk = 1'b0;
    always #20 clk = ~clk;

    // Check whether the output has a valid logic value
    task check_valid_output;
        input [127:0] test_name;
        begin
            if ((sound_out === 1'b0) || (sound_out === 1'b1))
                $display("PASS: %0s - sound_out=%b",
                         test_name, sound_out);
            else
                $display("FAIL: %0s - invalid sound_out=%b",
                         test_name, sound_out);
        end
    endtask

    initial begin
        $dumpfile("simulation/psg_gls.vcd");
        $dumpvars(0, tb_psg_gls);

        $monitor("time=%0t reset=%b enable=%b tone=%b sound_out=%b",
                 $time, reset, enable, tone_select, sound_out);

        // Initialize inputs
        reset       = 1'b1;
        enable      = 1'b0;
        tone_select = 2'b00;

        // Apply reset
        repeat (5) @(posedge clk);
        #1;
        check_valid_output("Reset");

        reset = 1'b0;
        repeat (2) @(posedge clk);

        // Tone 00: approximately 440 Hz
        tone_select = 2'b00;
        enable = 1'b1;
        #1200000;
        check_valid_output("Tone 00");

        // Tone 01: approximately 523 Hz
        enable = 1'b0;
        repeat (2) @(posedge clk);
        tone_select = 2'b01;
        enable = 1'b1;
        #1050000;
        check_valid_output("Tone 01");

        // Tone 10: approximately 659 Hz
        enable = 1'b0;
        repeat (2) @(posedge clk);
        tone_select = 2'b10;
        enable = 1'b1;
        #850000;
        check_valid_output("Tone 10");

        // Tone 11: approximately 784 Hz
        enable = 1'b0;
        repeat (2) @(posedge clk);
        tone_select = 2'b11;
        enable = 1'b1;
        #700000;
        check_valid_output("Tone 11");

        // Disable and check that output clears
        enable = 1'b0;
        repeat (3) @(posedge clk);
        #1;

        if (sound_out === 1'b0)
            $display("PASS: Output cleared when disabled");
        else
            $display("FAIL: Expected sound_out=0 when disabled; got %b",
                     sound_out);

        $display("GLS testbench completed.");
        $finish;
    end

    // Stop simulation if it runs unexpectedly long
    initial begin
        #5000000;
        $display("ERROR: Simulation timeout.");
        $finish;
    end

endmodule
