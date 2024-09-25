module custom_axi_ip (
    input logic clk_i,
    input logic rst_ni,

    // Register to Hardware interface
    input logic reg2hw,
    output logic hw2reg,
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
            // Write to registers based on reg2hw inputs
            if (reg2hw.reg0[0].de) reg0 <= reg2hw.reg0[0].q;
            if (reg2hw.reg1[0].de) reg1 <= reg2hw.reg1[0].q;
            if (reg2hw.reg2[0].de) reg2 <= reg2hw.reg2[0].q;
        end
    end

    // Read logic would populate hw2reg based on internal state
    always_ff @(posedge clk_i) begin
        hw2reg.reg0[0].d <= reg0;
        hw2reg.reg0[0].de <= 1'b1; // Set data ready flag
        hw2reg.reg1[0].d <= reg1;
        hw2reg.reg1[0].de <= 1'b1;
        hw2reg.reg2[0].d <= reg2;
        hw2reg.reg2[0].de <= 1'b1;
    end

endmodule
