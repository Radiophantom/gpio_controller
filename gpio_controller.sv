module gpio_controller #(
  parameter AMM_WIDTH  = 8,
  parameter GPIO_WIDTH = 8
)(
  input rst_i,
  input clk_i,

  output [GPIO_WIDTH-1:0] gpio_buf_o,
  input  [GPIO_WIDTH-1:0] gpio_buf_oe_i,
  input  [GPIO_WIDTH-1:0] gpio_buf_data_i
);

always_comb
  for( int i = 0; i < WIDTH; i++ )
    gpio_oe[i] = mem[0][i];

always_comb
  for( int i = WIDTH; i < 2*WIDTH; i++ )
    gpio_o[i] = mem[0][i];

always_comb
  for( int i = 0; i < WIDTH; i++ )
    gpio_io[i] = gpio_oe[i] ? ( gpio_o ) : ( 1'bZ );

always_comb
  for( int i = 0; i < WIDTH; i++ )
    gpio_i[i] = gpio_io[i];

endmodule
