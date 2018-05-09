class ahb_sqr extends uvm_sequencer#(ahb_tx);
	`uvm_component_utils(ahb_sqr)
	function new(string name="", uvm_component parent=null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		`uvm_info("ahb_sqr", "build_phase", UVM_LOW)
	endfunction
endclass

