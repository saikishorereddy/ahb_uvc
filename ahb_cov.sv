class ahb_cov extends uvm_subscriber#(ahb_tx);
	ahb_tx tx;
	`uvm_component_utils(ahb_cov)

	covergroup ahb_cg;
		BURST_CP : coverpoint tx.burst_type {
			bins SINGLE = {SINGLE};
			bins INCR = {INCR};
			bins WRAP4 = {WRAP4};
			bins INCR4 = {INCR4};
			bins WRAP8 = {WRAP8};
			bins INCR8 = {INCR8};
			bins WRAP16 = {WRAP16};
			bins INCR16 = {INCR16};
		}
	endgroup

	function new(string name="", uvm_component parent=null);
		super.new(name, parent);
		ahb_cg = new();
	endfunction

	function void build_phase(uvm_phase phase);
		`uvm_info("ahb_cov", "build_phase", UVM_LOW)
	endfunction

  function void write(T t);
	  $cast(tx, t);
	  ahb_cg.sample();
  endfunction
endclass



