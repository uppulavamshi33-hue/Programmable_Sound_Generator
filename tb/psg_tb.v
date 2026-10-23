`timescale 1ns/1ps

module tb_psg;

    reg clk;
    reg reset;
    reg enable;
    reg [1:0] tone_select;
    wire sound_out;

    psg #(
        .CLK_HZ(25000000)
    ) dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .tone_select(tone_select),
        .sound_out(sound_out)
    );

    // 25 MHz clock: 40 ns period
    initial clk = 1'b0;
    always #20 clk = ~clk;

    initial begin
        $dumpfile("simulation/psg.vcd");
        $dumpvars(0, tb_psg);

        reset = 1'b1;
        enable = 1'b0;
        tone_select = 2'b00;

        #100;
        reset = 1'b0;
        enable = 1'b1;

        // Test all four selectable tones
        tone_select = 2'b00;
        #200000;

        tone_select = 2'b01;
        #200000;

        tone_select = 2'b10;
        #200000;

        tone_select = 2'b11;
        #200000;

        // Test disable
        enable = 1'b0;
        #100;

        $finish;
    end

endmodule
