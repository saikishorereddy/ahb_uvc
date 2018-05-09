//test liubrary : base test & functional tests
//base test : comon things for every test
	//env
	//printer
class ahb_base_test extends uvm_test;
	ahb_env env;
	uvm_table_printer printer;   //policy
	`uvm_component_utils(ahb_base_test)
	function new(string name="", uvm_component parent=null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		uvm_component t_comp;
		`uvm_info("ahb_test", "build_phase", UVM_LOW)
		//env = ahb_env::type_id::create("env", this);
		t_comp = factory.create_component_by_type(ahb_env::get_type(), "", "env", this);
		$cast(env, t_comp);
		printer = new();
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		//this.pritner, this(pritner)
		`uvm_info("AHB", $psprintf("TB structure is %s", this.sprint(printer)), UVM_NONE)   //macro associated with uvm_report_object class
		//$display("a=%d", a);
		factory.print();
	endfunction

	//by default every phase empty is present
	function void connect_phase(uvm_phase phase);
		//`uvm_error("TEST", "dummy error")
		`uvm_warning("TEST", "dummy error")
	endfunction

	task run_phase(uvm_phase phase);
		`uvm_warning("TEST", "dummy warning")
	endtask

	//no need to code run_phase
endclass

class ahb_10_tx_test extends ahb_base_test;
	`uvm_component_utils(ahb_10_tx_test)
	function new(string name="", uvm_component parent=null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		ahb_10_tx_seq tx_seq;
		tx_seq = ahb_10_tx_seq::type_id::create("tx_seq");
		phase.raise_objection(this);
		tx_seq.start(env.agent.sqr);
		phase.drop_objection(this);
	endtask
endclass

class ahb_10_err_tx_test extends ahb_base_test;
	`uvm_component_utils(ahb_10_err_tx_test)
	function new(string name="", uvm_component parent=null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		//factory.set_type_override_by_name("ahb_tx", "ahb_err_tx");
		factory.set_type_override_by_type(ahb_tx::get_type(), ahb_err_tx::get_type());
	endfunction

	task run_phase(uvm_phase phase);
		uvm_object t_obj;
		ahb_10_tx_seq tx_seq;
		//tx_seq = ahb_10_tx_seq::type_id::create("tx_seq");
		t_obj = factory.create_object_by_type(ahb_10_tx_seq::get_type(), "", "tx_seq");
		$cast(tx_seq, t_obj);
		phase.raise_objection(this);
		tx_seq.start(env.agent.sqr);
		phase.drop_objection(this);
	endtask
endclass
