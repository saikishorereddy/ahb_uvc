class ahb_env extends uvm_env;
	ahb_agent agent;
	`uvm_component_utils(ahb_env)
		//1. type_id : factory defintion of the component
		//2. get_type, get_type_name, get_object_type
		//get_type :: must be called on class name itself => ahb_driver::get_type
		//get_type_name and get_object_type :: must be called on objects ,  drv.get_object_type
	function new(string name="", uvm_component parent=null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		`uvm_info("ahb_env", "build_phase", UVM_LOW)
		agent = ahb_agent::type_id::create("agent", this);
			//full_name : "uvm_test_top.env.agent"
			//inst_name : "agent"
			//ahb_agent :: new -> uvm_compoennt::new
	endfunction
endclass
