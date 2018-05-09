class ahb_mon extends uvm_monitor;
	virtual ahb_intf vif;
	ahb_tx tx;
	uvm_analysis_port#(ahb_tx) ap_port;
	`uvm_component_utils(ahb_mon)
	function new(string name="", uvm_component parent=null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		`uvm_info("ahb_mon", "build_phase", UVM_LOW)
		if (!uvm_config_db#(virtual ahb_intf)::get(this, "", "vif", vif)) begin
			`uvm_error("CONFIG_DB", "AHB Intf not added to config database")
		end
		ap_port = new("ap_port", this);
	endfunction

	task run_phase(uvm_phase phase);
	forever begin
		@(posedge vif.hclk);
		tx = ahb_tx::type_id::create("tx");
		//tx.addr = vif.addr;
		ap_port.write(tx);
	end
	endtask
endclass


