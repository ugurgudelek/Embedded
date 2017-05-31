////////////////////////////////////////////////////////
//
//  Name: led_blink_top.value
//  Author : Tamer Gudu
//  Date   : 25.04.17
//
////////////////////////////////////////////////////////

module kitt_blink_top (
input        clk,
input        reset,
output[7:0]       led_out);


wire	[11:0]	address;
wire	[17:0]	instruction;
wire			bram_enable;
wire	[7:0]	port_id;
wire	[7:0]	out_port;
wire	[7:0]   in_port;
wire			write_strobe;
wire			k_write_strobe;
wire			read_strobe;
wire            interrupt;            //See note above
wire			interrupt_ack;
wire			kcpsm6_sleep;         //See note above
wire			kcpsm6_reset;         //See note above
reg[7:0]             led_out_i;
wire            rdl;


  kcpsm6 #(
	.interrupt_vector	(12'h3FF),
	.scratch_pad_memory_size(64),
	.hwbuild		(8'h00))
  processor (
	.address 		(address),
	.instruction 	(instruction),
	.bram_enable 	(bram_enable),
	.port_id 		(port_id),
	.write_strobe 	(write_strobe),
	.k_write_strobe (k_write_strobe),
	.out_port 		(out_port),
	.read_strobe 	(read_strobe),
	.in_port 		(in_port),
	.interrupt 		(interrupt),
	.interrupt_ack 	(interrupt_ack),
	.reset 		    (kcpsm6_reset),
	.sleep		    (kcpsm6_sleep),
	.clk 			(clk)); 

 kitt_blink #(
	.C_FAMILY		   ("7S"),   	//Family 'S6' or 'V6'
	.C_RAM_SIZE_KWORDS	(1),  	//Program size '1', '2' or '4'
	.C_JTAG_LOADER_ENABLE	(0))  	//Include JTAG Loader when set to '1' 
  program_rom (    				//Name to match your PSM file
 	.rdl 			(rdl),
	.enable 		(bram_enable),
	.address 		(address),
	.instruction 	(instruction),
	.clk 			(clk));

  assign kcpsm6_sleep = 1'b0;
  assign interrupt = 1'b0;
  assign kcpsm6_reset = reset;
  assign led_out = led_out_i;
  assign in_port = 8'b0;
  

  always @ (posedge clk)
  begin

      // 'write_strobe' is used to qualify all writes to general output ports.
      if (write_strobe == 1'b1) begin

        // Write to output_port_w at port address 01 hex
        if (port_id == 8'b0) begin
          led_out_i <= out_port;
        end
		
      end

  end
endmodule
