module gpio_controller #(
  parameter AMM_WIDTH  = 8,
  parameter GPIO_WIDTH = 8
)(
  input rst_i,
  input clk_i,

  amm_if  amm_if,

  input   [GPIO_WIDTH-1:0] gpio_buf_i,
  output  [GPIO_WIDTH-1:0] gpio_buf_oe_o,
  output  [GPIO_WIDTH-1:0] gpio_buf_data_o
);

//******************************************************************************
// Avalon-MM interface logic
//******************************************************************************

logic [31:0] mem [1:0];

logic         readdatavalid;
logic [15:0]  readdata;

always_ff @( posedge clk_i )
  if( amm_if.write )
    mem[amm_if.address] <= amm_if.writedata;

always_ff @( posedge clk_i, posedge rst_i )
  if( rst_i )
    readdatavalid <= 1'b0;
  else
    readdatavalid <= amm_if.read;

always_ff @( posedge clk_i )
  if( amm_if.read )
    readdata <= gpio_i;

assign amm_if.readdatavalid = readdatavalid;
assign amm_if.readdata      = readdata;
assign amm_if.waitrequest   = 1'b0;

//******************************************************************************
// CSR mapping
//******************************************************************************

logic [31:0] cr_regs;
logic [31:0] sr_regs;

endmodule
