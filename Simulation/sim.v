/* ------------------------------------------------ *
 * Title       : I2S Master Simulation              *
 * Project     : Simple I2S                         *
 * ------------------------------------------------ *
 * File        : sim.v                              *
 * Author      : Yigit Suoglu                       *
 * Last Edit   : 23/01/2021                         *
 * ------------------------------------------------ *
 * Description : Simulate I2S master module         *
 * ------------------------------------------------ */
`timescale 1ns / 1ps

`include "Sources/i2s.v"

module i2cMtestbench();
  reg clk, rst, enable;
  wire BCLK,LRCLK, SDATA, RightNLeft;
  reg [11:0] rightAudio, leftAudio;
  
  i2sMaster uut(rst,,LRCLK,SDATA,BCLK,rightAudio,leftAudio,enable,RightNLeft);
  bitClkGen clkgen(clk, rst, BCLK);

  always #5 clk = ~clk;

  

  initial
    begin
      $dumpfile("sim.vcd");
      $dumpvars(0, clk);
      $dumpvars(1, rst);
      $dumpvars(2, enable);
      $dumpvars(3, BCLK);
      $dumpvars(4, LRCLK);
      $dumpvars(5, SDATA);
      $dumpvars(6, RightNLeft);
      $dumpvars(7, rightAudio);
      $dumpvars(8, leftAudio);
      #40000
      $finish;
    end

  initial 
    begin
      clk <= 0;
      rst <= 0;
      rightAudio <= 12'hfff;
      leftAudio <= 12'h000;
      enable <= 1;
      #12
      rst <= 1;
      #12
      rst <= 0;

    end
endmodule//sim