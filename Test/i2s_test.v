/* ------------------------------------------------ *
 * Title       : I2S Master Test                    *
 * Project     : Simple I2S                         *
 * ------------------------------------------------ *
 * File        : i2s_test.v                         *
 * Author      : Yigit Suoglu                       *
 * Last Edit   : 23/01/2021                         *
 * ------------------------------------------------ *
 * Description : Simulate I2S master module         *
 * ------------------------------------------------ */

// `include "Sources/i2s.v"
// `include "Test/btn_debouncer.v"

module testBoard(
  input clk,
  input rst,
  input [15:0] sw,
  output BCLK, //JB4
  output LRCLK, //JB1
  output SDATA, //JB3
  output RightNLeft, //JB2
  input clkModBTN,
  input external_CLK, //JB7
  output [15:0] led);

  wire chCLK, BCLK_gen;
  reg clkmode;

  assign led = {clkmode,11'd0,RightNLeft,SDATA,LRCLK,BCLK};

  assign BCLK_t = (clkmode) ? external_CLK : BCLK_gen;

  debouncer dbBTN(clk, rst, clkModBTN, chCLK);
  bitClkGen#(700, 10) clkGenerator(clk,rst,BCLK_gen);
  i2sMaster#(16) uut(rst,BCLK,LRCLK,SDATA,BCLK_t,{sw[7:0],sw[7:0]},{sw[15:8],sw[15:8]},1'b1,RightNLeft);

  always@(posedge clk or posedge rst)
    begin
      if(rst)
        clkmode <= 1'b0;
      else
        clkmode <= (chCLK) ? ~clkmode : clkmode;
    end
endmodule//testBoard
