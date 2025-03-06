/*
CHASE AUGUST LOTITO

ECE428 LAB 1

PASSCODE FSM MODULE

DESCRIPTION:
This module is a finite state machine which detects
a secret code of (Top Left Left Right). If the passcode is 
correct, the 7-SEG Display reads 9, if incorrect E. This
includes  a master reset.
*/

module passcode_fsm (
    input       clk_i,
    input       rst_i,
    
    // button event i/o
    input       top_event_i,
    input       right_event_i,
    input       left_event_i,
    input       down_event_i,
  
    // TLLR passcode detected
    output      passcode_detected_o,
    output      passcode_failed_o,

    // 7-Segment Display Outputs
    output reg [6:0] SSG_D
);

    // PARAMETERS:
    parameter INITIAL_STATE = 4'b0000;
    //   success states
    parameter STATE_1 = 4'b0001;
    parameter STATE_2 = 4'b0010;
    parameter STATE_3 = 4'b0011;
    parameter STATE_4 = 4'b0100;
    //   fail states
    parameter FAIL_1 = 4'b1001;
    parameter FAIL_2 = 4'b1010;
    parameter FAIL_3 = 4'b1011;
    parameter FAIL_4 = 4'b1100;
    //   error state
    parameter ERROR_STATE = 4'b1111;

    // FSM state registers
    reg [3:0] current_state;
    reg [3:0] next_state; 

    // 7-Seg Display
    //reg [6:0] SSG_D;

    // button event occurred (any were pressed)
    wire button_event = top_event_i | right_event_i | left_event_i | down_event_i;


    // initialize FSM (NOT NEEDED FOR SYNTHESIS AND IMPLEMENTATION)
    initial begin
        current_state = INITIAL_STATE;
    end


    // SEQUENTIAL FSM LOGIC
    always @(posedge clk_i) begin
        if (rst_i)
            current_state <= INITIAL_STATE;
        else current_state <= next_state; 
    end

    // NEXT STATE FSM LOGIC
    always @(*) begin
        case (current_state)
            INITIAL_STATE:  if (top_event_i) next_state <= STATE_1;
                            else if (!top_event_i && button_event) next_state <= FAIL_1;
                            else next_state <= INITIAL_STATE;
            
            STATE_1:        if (left_event_i) next_state <= STATE_2;
                            else if (!left_event_i && button_event) next_state <= FAIL_2;
                            else next_state <= STATE_1;
            
            STATE_2:        if (left_event_i) next_state <= STATE_3;
                            else if (!left_event_i && button_event) next_state <= FAIL_3;
                            else next_state <= STATE_2;
            
            STATE_3:        if (right_event_i) next_state <= STATE_4;
                            else if (!right_event_i && button_event) next_state <= FAIL_4;
                            else next_state <= STATE_3;
                            
            STATE_4:        if (rst_i) next_state <= INITIAL_STATE;
                            else next_state <= STATE_4;

            FAIL_1:         if (button_event) next_state <= FAIL_2;
            
            FAIL_2:         if (button_event) next_state <= FAIL_3;
            
            FAIL_3:         if (button_event) next_state <= FAIL_4;
            
            FAIL_4:         if (rst_i) next_state <= INITIAL_STATE;
                            else next_state <= FAIL_4;
            
            default: next_state <= ERROR_STATE; 
        endcase
    end

    // 7 SEG DISPLAY OUTPUT LOGIC
    always @(*) begin
        case (current_state)
            STATE_4: SSG_D = 7'b001_0000;   // Display '9' for CORRECT
            FAIL_4: SSG_D = 7'b000_0110;    // Display 'E' for ERROR 
            default: SSG_D = 7'b100_0000;   // Display '0' for RESET
        endcase
    end

    // OUTPUT COMBINATIONAL LOGIC    
    assign passcode_detected_o = (current_state == STATE_4) ? 1 : 0;
    assign passcode_failed_o = (current_state == FAIL_4) ? 1 : 0;
endmodule