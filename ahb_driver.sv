class ahb_driver extends uvm_driver#(ahb_tx);
	`uvm_component_utils(ahb_driver)
	function new(string name="", uvm_component parent=null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		`uvm_info("ahb_driver", "build_phase", UVM_LOW)
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
			req.print();
			seq_item_port.item_done();
		end
	endtask
endclass
