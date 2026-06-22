`timescale 1ns/1ps
module uart_tb;
    reg        clk;
    reg        rst_n;
    reg        tx_start;
    reg  [7:0] tx_data;
    wire       tx_line;
    wire       tx_busy;
    uart_tx #(
        .CLK_FREQ  (50_000_000),
        .BAUD_RATE (9600)
    ) dut (
        .clk      (clk),
        .rst_n    (rst_n),
        .tx_start (tx_start),
        .tx_data  (tx_data),
        .tx_line  (tx_line),
        .tx_busy  (tx_busy)
    );
    initial clk = 0;
    always #10 clk = ~clk;
    initial begin
        $dumpfile("uart_tb.vcd");
        $dumpvars(0, uart_tb);
        rst_n    = 0;
        tx_start = 0;
        tx_data  = 8'h00;
        #100;
        rst_n = 1;
        #100;
        tx_data  = 8'h41;
        tx_start = 1;
        #20;
        tx_start = 0;
        #11_000_000;
        tx_data  = 8'h42;
        tx_start = 1;
        #20;
        tx_start = 0;
        #11_000_000;
        tx_data  = 8'h55;
        tx_start = 1;
        #20;
        tx_start = 0;
        #11_000_000;
        $dumpflush;
        $display("Simulation complete!");
        $finish;
    end
endmodule
