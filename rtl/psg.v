`timescale 1ns/1ps

module psg #(
    parameter integer CLK_HZ = 25000000
)(
    input  wire       clk,
    input  wire       reset,
    input  wire       enable,
    input  wire [1:0] tone_select,
    output reg        sound_out
);

    // Frequency-divider counter
    reg [15:0] counter;
    reg [15:0] terminal_count;

    // Select the half-period count for each tone.
    // CLK_HZ must match the actual input clock frequency.
    always @(*) begin
        case (tone_select)
            2'b00: terminal_count = CLK_HZ / (2 * 440);
            2'b01: terminal_count = CLK_HZ / (2 * 523);
            2'b10: terminal_count = CLK_HZ / (2 * 659);
            2'b11: terminal_count = CLK_HZ / (2 * 784);
            default: terminal_count = CLK_HZ / (2 * 440);
        endcase
    end

    // Sequential tone generator
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter   <= 16'd0;
            sound_out <= 1'b0;
        end else if (!enable) begin
            counter   <= 16'd0;
            sound_out <= 1'b0;
        end else if (counter >= terminal_count - 1'b1) begin
            counter   <= 16'd0;
            sound_out <= ~sound_out;
        end else begin
            counter <= counter + 1'b1;
        end
    end

endmodule
