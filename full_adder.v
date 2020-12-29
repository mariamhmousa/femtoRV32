`timescale 1ns/1ns

module full_adder(x,y,cin,s,cout);

    input x,y,cin;
    output s,cout;

assign {cout,s}=x+y+cin;
   
endmodule