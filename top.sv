`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "ahb_slave.sv"
`include "ahb_intf.sv"
`include "ahb_tx.sv"
`include "ahb_err_tx.sv"
`include "ahb_driver.sv"
`include "ahb_sqr.sv"
`include "ahb_mon.sv"
`include "ahb_cov.sv"
`include "ahb_agent.sv"
`include "ahb_env.sv"
`include "ahb_seq_lib.sv"
module top;
//IN SV
//1. dut
//2. itnerface
//3. clock, rst and generation
//4. program block
//5. assertions
//6. logic to end the simulation

//IN UVM
//1. dut
ahb_slave dut();
//2. clock, rst and generation
reg hclk, hrstn;
//3. itnerface
ahb_intf pif(hclk, hrstn);
initial begin
	//creating a virtual itnerface entry in the configuration data base
		//any compoentn in the TB will be to access this elment from the configuration data base
	uvm_config_db#(virtual ahb_intf)::set(uvm_root::get(), "*", "vif", pif);
		//uvm_root::get(), "*"  : which all compoentns in the TB have access to above variable
		//uvm_root::get => top & * => everything below top
end

initial begin
	hclk = 0;
	forever #5 hclk = ~hclk;
end

initial begin
	hrstn = 0;
	repeat(2) @(posedge hclk);
	hrstn = 1;
end

//4. include test lib and call run_test method 
`include "test_lib.sv"
initial begin
	run_test("ahb_base_test");  //global task defined as part of UVM source code
end

//5. assertions
endmodule
