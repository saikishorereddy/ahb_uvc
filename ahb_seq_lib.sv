//base sequence
class ahb_base_seq extends uvm_sequence#(ahb_tx);
	`uvm_object_utils(ahb_base_seq)
	function new(string name="");
		super.new(name);
	endfunction

	task pre_body();
		if (starting_phase != null) begin
			starting_phase.raise_objection(this);
		end
	endtask
	task post_body();
		if (starting_phase != null) begin
			starting_phase.drop_objection(this);
		end
	endtask
endclass

//functional sequence
class ahb_10_tx_seq extends ahb_base_seq;
	`uvm_object_utils(ahb_10_tx_seq)
	function new(string name="");
		super.new(name);
	endfunction

	task body();
		repeat(10) `uvm_do(req)
	endtask
endclass
