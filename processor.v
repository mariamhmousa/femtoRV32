`timescale 1ns / 1ps
module processor(input ssdclk, input uart_in, output [15:0] out, output  [6:0] LED_out, output [3:0] Anode);
    
    UART_receiver_multiple_Keys uart(ssdclk, uart_in, out[7:0]);
    
    wire [12:0] num;
    
    RISCV_pipeline DP( out[0], out[1], out [3:2], out[7:4],  out[15:8], num );
    Four_Digit_Seven_Segment_Driver display(ssdclk, num, Anode, LED_out);

endmodule
