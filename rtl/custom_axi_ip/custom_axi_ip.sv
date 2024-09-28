module custom_axi_ip (
    input logic clk_i,
    input logic rst_ni,

    // Register to Hardware interface
    input  logic [2:0] reg2ip_data,
    input  logic [2:0] reg2ip_en,
    output logic [2:0] ip2reg_data,
    output logic [2:0] ip2reg_en
);

  // Internal registers to store data
  logic [31:0] reg0;
  logic [31:0] reg1;
  logic [31:0] reg2;

  // Write logic for registers
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      // Reset all registers
      reg0 <= 32'h0;
      reg1 <= 32'h0;
      reg2 <= 32'h0;
    end else begin
      // Write to registers based on reg2ip inputs
      $display("reg2ip_en: %b", reg2ip_en[2:0]);
      if (reg2ip_en[0]) begin
        reg0 <= reg2ip_data[0];
        reg2ip_en[0] <= 0;  // Clear data ready flag
        $display("reg0: %b", reg0);
      end
      if (reg2ip_en[1]) begin 
        reg1 <= reg2ip_data[1];
        reg2ip_en[1] <= 0;
        $display("reg1: %b", reg1);
      end
      if (reg2ip_en[2]) begin 
        reg2 <= reg2ip_data[2];
        reg2ip_en[2] <= 0;
        $display("reg2: %b", reg2);
      end
    end
  end

  // Read logic would populate ip2reg based on internal state
  always_ff @(posedge clk_i) begin
    ip2reg_data[0] <= reg0;
    ip2reg_en[0]   <= 1'b1;  // Set data ready flag
    ip2reg_data[1] <= reg1;
    ip2reg_en[1]   <= 1'b1;
    ip2reg_data[2] <= reg2;
    ip2reg_en[2]   <= 1'b1;
  end

endmodule
