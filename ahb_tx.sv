typedef enum {
	SINGLE,
	INCR,
	WRAP4,
	INCR4,
	WRAP8,
	INCR8,
	WRAP16,
	INCR16
} burst_type_t;

class ahb_tx extends uvm_sequence_item;
	string name;
	rand bit [31:0] addr;
	rand bit [31:0] dataQ[$];
	rand bit wr_rd;
	rand bit [3:0] burst_len;
	rand bit [3:0] prot;
	rand bit [2:0] burst_size;
	rand bit [1:0] resp;
	rand burst_type_t burst_type;
	rand bit [31:0] wrap_base_addr, wrap_upper_addr;

	`uvm_object_utils_begin(ahb_tx)  //regsiterating ahb_tx to the factory
		`uvm_field_string(name, UVM_ALL_ON|UVM_NOPACK)  //regsiterating addr to the factory
		`uvm_field_int(addr, UVM_ALL_ON|UVM_NOPACK)  //regsiterating addr to the factory
		`uvm_field_queue_int(dataQ, UVM_ALL_ON|UVM_NOPACK)
		`uvm_field_int(wr_rd, UVM_ALL_ON|UVM_NOPACK)
		`uvm_field_int(burst_len, UVM_PRINT|UVM_NOPACK)
		`uvm_field_int(burst_size, UVM_PRINT|UVM_NOPACK)
		`uvm_field_int(resp, UVM_PRINT|UVM_NOPACK)
		`uvm_field_int(prot, UVM_PRINT|UVM_NOPACK)
		`uvm_field_enum(burst_type_t, burst_type, UVM_PRINT|UVM_NOPACK)
	`uvm_object_utils_end

	function new(string name="");
		super.new(name);
	endfunction

	function void post_randomize();
		//16'h1004, Wrap4, Size=2 => 16'h1000
		wrap_base_addr = addr - (addr%(burst_len*(2**burst_size)));  //1000
		wrap_upper_addr = wrap_base_addr + (burst_len*(2**burst_size)) - 1;  //1000 + 16 - 1= 100F
		`uvm_info("AHB Tx", $psprintf("wrap_base_addr = %h, wrap_upper_addr = %h", wrap_base_addr, wrap_upper_addr), UVM_LOW)
	endfunction

	constraint len_c {
		dataQ.size() == burst_len;
	}

	//AHB only supports alinged transfers
	constraint addr_c {
		addr%(2**burst_size) == 0;
	}

	//AHB only support 8 burst types
	constraint addr_c1 {
		(burst_type == SINGLE) -> (burst_len == 1);
		(burst_type inside {WRAP4, INCR4}) -> (burst_len == 4);
		(burst_type inside {WRAP8, INCR8}) -> (burst_len == 8);
		(burst_type inside {WRAP16, INCR16}) -> (burst_len == 16);
	}
endclass


