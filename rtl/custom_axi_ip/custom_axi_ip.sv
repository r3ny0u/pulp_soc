`include "/register_interface/typedef.svh"
`include "/register_interface/assign.svh"

module custom_axi_ip (
    input logic clk,
    input logic rst_n,

    // AXI Lite interface
    input wire [31:0] axi_awaddr,   // Write Address
    input wire axi_awvalid,         // Write Address Valid
    output reg axi_awready,         // Write Address Ready

    input wire [31:0] axi_wdata,    // Write Data
    input wire [3:0] axi_wstrb,     // Write Strobe
    input wire axi_wvalid,          // Write Data Valid
    output reg axi_wready,           // Write Data Ready

    output reg [1:0] axi_bresp,     // Write Response
    output reg axi_bvalid,          // Write Response Valid
    input reg axi_bready,          // Write Response Ready

    input wire [31:0] axi_araddr,   // Read Address
    input wire axi_arvalid,         // Read Address Valid
    output reg axi_arready,          // Read Address Ready

    output reg [31:0] axi_rdata,   // Read Data
    output reg [1:0] axi_rresp,    // Read Response
    output reg axi_rvalid,         // Read Data Valid
    input reg axi_rready          // Read Data Ready
);

    // Define a small group of registers
    reg [31:0] reg0;
    reg [31:0] reg1;
    reg [31:0] reg2;

    // Register write logic
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            axi_awready <= 1'b0;
            axi_wready <= 1'b0;
            axi_bvalid <= 1'b0;
            axi_arready <= 1'b0;
            axi_rvalid <= 1'b0;
            reg0 <= 32'h0;
            reg1 <= 32'h0;
            reg2 <= 32'h0;
        end else begin
            // Handle write Address
            if (axi_awvalid && !axi_awready && !axi_wready) begin
                axi_awready <= 1'b1;
            end else begin
                axi_awready <= 1'b0;
            end

            // Handle write Data
            if (axi_wvalid && axi_awready && !axi_wready) begin
                axi_wready <= 1'b1;
                case (axi_awaddr)
                    32'h0: reg0 <= axi_wdata;
                    32'h4: reg1 <= axi_wdata;
                    32'h8: reg2 <= axi_wdata;
                endcase
            end else begin
                axi_wready <= 1'b0;
            end

            // Handle write Response
            if (axi_wready && axi_wvalid && !axi_bvalid) begin
                axi_bvalid <= 1'b1;
                axi_bresp <= 2'b0; // OKAY response
            end else if (axi_bvalid && axi_bready) begin
                axi_bvalid <= 1'b0;
            end

            // Handle read Address
            if (axi_arvalid && !axi_arready) begin
                axi_arready <= 1'b1;
            end else begin
                axi_arready <= 1'b0;
            end

            // Handle read Data
            if (axi_arready && axi_arvalid && !axi_rvalid) begin
                axi_rvalid <= 1'b1;
                axi_rresp <= 2'b0; // OKAY response
                case (axi_araddr)
                    32'h0: axi_rdata <= reg0;
                    32'h4: axi_rdata <= reg1;
                    32'h8: axi_rdata <= reg2;
                    default: axi_rdata <= 32'h0;
                endcase
            end else if (axi_rvalid && axi_rready) begin
                axi_rvalid <= 1'b0;
            end
        end
    end


endmodule
