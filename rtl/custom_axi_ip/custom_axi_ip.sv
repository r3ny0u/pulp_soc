module custom_axi_ip 
  #(
    parameter DATA_WIDTH = 96   
  )(
    input logic clk_i,
    input logic rst_ni,

    // Register to Hardware interface
    input  logic [DATA_WIDTH-1:0] reg2ip_data,
    input  logic [2:0] reg2ip_en_in,
    output logic [2:0] reg2ip_en_out,
    output logic [DATA_WIDTH+2:0] ip2reg_data,
    output logic [2:0] ip2reg_en
);

  // Internal registers to store data
  logic [31:0] reg0;
  logic [31:0] reg1;
  logic [31:0] reg2;
  logic [31:0] reg3 = 32'h2468;
  logic [31:0] reg4 = 32'h369C;
  logic [31:0] reg5 = 32'h48D0;

  // Read
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      //Reset all registers
      reg0 <= 32'h0;
      reg1 <= 32'h0;
      reg2 <= 32'h0;
      reg2ip_en_out <= 3'b0;
    end else begin
      // $display("reg2ip_en_in: %h", reg2ip_en_in);
      // $display("reg2ip_en_out: %h", reg2ip_en_out);
      // Write to registers based on reg2ip inputs
      if (reg2ip_en_in[0]) begin
        reg0 <= reg2ip_data[95:64];
        reg2ip_en_out[0] <= 1'b0;
        $display("reg2ip_en_in: %h", reg2ip_en_in);
        $display("reg2in_en_out: %h", reg2ip_en_out);
        $display("reg0_data: %h", reg2ip_data[0]);
        $display("reg0: %h", reg0);
      end

      if (reg2ip_en_in[1]) begin 
        reg1 <= reg2ip_data[63:32];
        reg2ip_en_out[1] <= 1'b0;
        $display("reg2ip_en_in: %h", reg2ip_en_in);
        $display("reg2in_en_out: %h", reg2ip_en_out);
        $display("reg1_data: %h", reg2ip_data[1]);
        $display("reg1: %h", reg1);
      end

      if (reg2ip_en_in[2]) begin
        reg2 <= reg2ip_data[31:0];
        reg2ip_en_out[2] <= 1'b0;
        $display("reg2ip_en_in: %h", reg2ip_en_in);
        $display("reg2in_en_out: %h", reg2ip_en_out);
        $display("reg2_data: %h", reg2ip_data[2]);
        $display("reg2: %h", reg2);
      end
    end
  end

  // Read logic would populate ip2reg based on internal state
  always_ff @(posedge clk_i) begin
    if (reg2ip_en_in[2:0] == 3'b000) begin
      ip2reg_data <= {reg3, 1'b1, reg4, 1'b1, reg5, 1'b1};
      $display("ip2reg_data: %h", {reg3, 1'b1, reg4, 1'b1, reg5, 1'b1});
    end
  end

endmodule
