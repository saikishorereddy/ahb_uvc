class ahb_agent extends uvm_agent;
	ahb_driver drv;
	ahb_sqr sqr;
	ahb_mon mon;
	ahb_cov cov;
	`uvm_component_utils(ahb_agent)
	function new(string name="", uvm_component parent=null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		`uvm_info("ahb_agent", "build_phase", UVM_LOW)
		drv = ahb_driver::type_id::create("drv", this);  //definition of ahb_driver from factory will be used
		//drv = new();  //definition of ahb_driver from ahb_driver.sv file will be sued
		sqr = ahb_sqr::type_id::create("sqr", this);  //definition of ahb_driver from factory will be used
		mon = ahb_mon::type_id::create("mon", this);  //definition of ahb_driver from factory will be used
		cov = ahb_cov::type_id::create("cov", this);  //definition of ahb_driver from factory will be used
	endfunction

	function void connect_phase(uvm_phase phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
		mon.ap_port.connect(cov.analysis_export);
	endfunction
endclass

