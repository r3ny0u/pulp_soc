module custom_axi_ip_top
    #(
        parameter int unsigned AXI_ADDR_WIDTH = 32,
        parameter int unsigned AXI_DATA_WIDTH = 32,
        parameter int unsigned AXI_ID_WIDTH,
        parameter int unsigned AXI_USER_WIDTH
    )
    (
        input logic clk_i,        // Clock input
        input logic rst_ni,      // Reset, active low
        input logic test_mode_i,  // Test mode input

        // AXI Slave interface
        AXI_BUS.Slave axi_slave
    );

    // Instantiate the custom AXI IP
    custom_axi_ip u_custom_axi_ip (
        .clk(clk_i),
        .rst_n(rst_ni),
        .axi_awaddr(axi_slave.awaddr),
        .axi_awvalid(axi_slave.awvalid),
        .axi_awready(axi_slave.awready),
        .axi_wdata(axi_slave.wdata),
        .axi_wstrb(axi_slave.wstrb),
        .axi_wvalid(axi_slave.wvalid),
        .axi_wready(axi_slave.wready),
        .axi_bresp(axi_slave.bresp),
        .axi_bvalid(axi_slave.bvalid),
        .axi_bready(axi_slave.bready),
        .axi_araddr(axi_slave.araddr),
        .axi_arvalid(axi_slave.arvalid),
        .axi_arready(axi_slave.arready),
        .axi_rdata(axi_slave.rdata),
        .axi_rresp(axi_slave.rresp),
        .axi_rvalid(axi_slave.rvalid),
        .axi_rready(axi_slave.rready)
    );

endmodule