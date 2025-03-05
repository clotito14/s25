/*
CHASE AUGUST LOTITO

ECE428 LAB 1

BUTTON EVENT FSM MODULE

DESCRIPTION:
This finite state machine recognizes a button press event,
which is used to capture the rising edge of a button press.
*/

module button_event_fsm (
    input       clk_i,
    input       rst_i,
    
    // button i/o
    input       button_i,
    output      button_o
);

    // Parameters
    parameter INIT = 2'b00;
    parameter WAIT = 2'b01;
    parameter EVENT = 2'b11;


    // Wires and Registers
    reg [1:0] current_state;      // Current State register
    reg [1:0] next_state;      // Next State register
    

    // Initalize module
    initial begin
        current_state = INIT;
        
    end


    // FSM SEQUENTIAL Logic
    always @(posedge clk_i) begin
        if (rst_i) current_state <= INIT;
        else current_state <= next_state;
    end

    // NEXT STATE logic
    always @(*) begin
        case (current_state)
            INIT:  if (~button_i) next_state <= WAIT;
                   else next_state <= INIT;
           
            WAIT:  if (button_i) next_state <= EVENT;
                   else next_state <= WAIT;
            
            EVENT: next_state <= INIT;
            
            default: next_state <= INIT;
        endcase
    end

    // COMBINATIONAL Logic
    // If current state is on the button event state, then output HIGH.
    assign button_o = (current_state == EVENT) ? 1'b1 : 1'b0;

endmodule