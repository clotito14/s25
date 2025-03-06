/*
CHASE AUGUST LOTITO

ECE428 LAB 1

TIMEOUT COUNTER MODULE

DESCRIPTION:
This module, when enabled by a button event, will
count for 10 seconds (10ns period -> 1_000_000_000 cycles), then
send the a timeout output signal.
*/

module timeout_counter (
    input       clk_i,
    input       rst_i,

    // enable
    input       enable_i,

    // timeout output
    output      timeout_o
);

    // Parameters
    parameter MAX_CYCLE = 1_000_000_000;

    // State parameters
    parameter INITIAL = 1'b0;
    parameter TIMING = 1'b1;

    // Registers
    reg [8:0] current_cycle;
    reg current_state;
    reg next_state;

    // Initalize subsystem
    initial begin
        current_cycle = 0;
        current_state <= INITIAL;
    end

    // Sequential logic
    always @(posedge clk_i) begin
        if (rst_i) begin
            current_cycle <= 0;
        end else if (current_state == TIMING) begin
            current_cycle = current_cycle + 1;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            INITIAL: if (enable_i) next_state <= TIMING;
                      else next_state <= INITIAL;
            
            TIMING: if (rst_i) next_state <= INITIAL;
                    else next_state <= TIMING;

            default: next_state <= INITIAL;
        endcase
    end
    
    assign timeout_o = (current_cycle == MAX_CYCLE) ? 1 : 0;

endmodule