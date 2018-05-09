class ahb_err_tx extends ahb_tx;
	rand bit [3:0] error_id;
	`uvm_object_utils_begin(ahb_err_tx)  //regsiterating ahb_tx to the factory
		`uvm_field_int(error_id, UVM_PRINT|UVM_NOPACK)
	`uvm_object_utils_end

	function new(string name="");
		super.new(name);
	endfunction
endclass
