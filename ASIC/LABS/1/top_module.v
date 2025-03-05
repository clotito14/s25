/*
CHASE AUGUST LOTITO

ECE428 LAB 1

TOP MODULE

DESCRIPTION:
The FSM is a hierarchical design, so here we are combining
the button event module with the passcode detector module.
*/

module top_module (
    input       clk,
    input       reset,

    // button inputs
    input       top_button,
    input       right_button,
    input       left_button,
    input       down_button,
    
    output wire [6:0] SSG_D
);
    
    wire passcode_detected;
    wire passcode_failed;
        
    // Instantiate the button event FSMs
    button_event_fsm right_button_fsm (
        .clk_i(clk),
        .rst_i(reset),
        .button_i(right_button),
        .button_o(right_event)
    );

    button_event_fsm top_button_fsm (
        .clk_i(clk),
        .rst_i(reset),
        .button_i(top_button),
        .button_o(top_event)
    );

    button_event_fsm left_button_fsm (
        .clk_i(clk),
        .rst_i(reset),
        .button_i(left_button),
        .button_o(left_event)
    );

    button_event_fsm down_button_fsm (
        .clk_i(clk),
        .rst_i(reset),
        .button_i(down_button),
        .button_o(down_event)
    );

   passcode_fsm code_fsm (
        .clk_i(clk),
        .rst_i(reset),
        .top_event_i(top_event),
        .right_event_i(right_event),
        .left_event_i(left_event),
        .down_event_i(down_event),
        .passcode_detected_o(passcode_detected),
        .passcode_failed_o(passcode_failed),
        .SSG_D(SSG_D)
   ); 

endmodule