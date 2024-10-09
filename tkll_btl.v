`timescale 1s / 1ms
//change mode "night" or "train"
module mode(clk_05hz,clk_2hz,sw0, sw1, outyl1, outyl2, train1, train2);
    input clk_05hz,clk_2hz,sw0, sw1;
    output reg outyl1, outyl2, train1, train2;
    
    always @ (clk_05hz,clk_2hz,sw0,sw1) begin
        if (sw0 == 1) begin
            if (sw1 == 1) begin
                outyl1 <= clk_05hz;
                outyl2 <= clk_05hz;
                train1 <= clk_2hz;
                train2 <= ~clk_2hz;
            end
            else begin
                outyl1 <= clk_05hz;
                outyl2 <= clk_05hz;
                train1 <= 1'b0;
                train2 <= 1'b0;
            end
        end
        else begin
            if (sw1 == 1) begin
                outyl1 <= 1'b0;
                outyl2 <= 1'b0;
                train1 <= clk_2hz;
                train2 <= ~clk_2hz;
            end
            else begin
                outyl1 <= 1'b0;
                outyl2 <= 1'b0;
                train1 <= 1'b0;
                train2 <= 1'b0;
            end
        end
    end
endmodule    
//counter for traffic light 1 and traffic light 2
module count_time1(clk_1hz,G1,Y1,sw0,set,rst,seg,run);
input clk_1hz,sw0,set,rst,run;
input [7:0] G1,Y1;
output [7:0] seg;
reg [7:0] pre_count=8'd7,count=8'd7;

assign seg[7:0] =        count == 8'd100 ? 8'b1010_1010 :
                         count == 8'd88 ?  9'b1000_1000 :
                         count == 8'd30 ?  8'b0011_0000 :
                         count == 8'd29 ?  8'b0010_1001 :
                         count == 8'd28 ?  8'b0010_1000 :
                         count == 8'd27 ?  8'b0010_0111 :
                         count == 8'd26 ?  8'b0010_0110 :
                         count == 8'd25 ?  8'b0010_0101 :
                         count == 8'd24 ?  8'b0010_0100 :
                         count == 8'd23 ?  8'b0010_0011 :
                         count == 8'd22 ?   8'b0010_0010 :
                         count == 8'd21 ?   8'b0010_0001 :
                         count == 8'd20 ?  8'b0010_0000 :
                         count == 8'd19 ?  8'b0001_1001 :
                         count == 8'd18 ?  8'b0001_1000 :
                         count == 8'd17 ?  8'b0001_0111 :
                         count == 8'd16 ?  8'b0001_0110 :
                         count == 8'd15 ?  8'b0001_0101 :
                         count == 8'd14 ?  8'b0001_0100 :
                         count == 8'd13 ?  8'b0001_0011 :
                         count == 8'd12 ?  8'b0001_0010 :
                         count == 8'd11 ? 8'b0001_0001 :
                         count == 8'd10 ? 8'b0001_0000 :
                         count == 8'd9 ?  8'b0000_1001 :
                         count == 8'd8 ?  8'b0000_1000 :
                         count == 8'd7 ?  8'b0000_0111 :
                         count == 8'd6 ?  8'b0000_0110 :
                         count == 8'd5 ?  8'b0000_0101 :
                         count == 8'd4 ?  8'b0000_0100 :
                         count == 8'd3 ?  8'b0000_0011 :
                         count == 8'd2 ?  8'b0000_0010 :
                                         8'b0000_0001 ;


    always @(posedge clk_1hz) begin
    if(rst) begin
    pre_count<= 8'd7;
    count<= 8'd88;
    end
    else if(run) begin
    pre_count<= G1;
    count<=8'd88;
    end
    else if (sw0) begin
    pre_count <= G1;
      count <= 8'd100;
    end
    else if (set) begin
    pre_count <= G1;
      count <= G1;
    end
    else if (count > 1) begin
      if(count==8'd100|| count==8'd88) count<=G1;
      else
      count <= count - 1;
    end
    else begin
        case (pre_count)
        G1+Y1: begin
        count <= G1;
        pre_count<=G1;end
        G1: begin
        count <= Y1;
        pre_count <=Y1;end
        Y1: begin
        count <= G1+Y1;
        pre_count <=G1+Y1;
        end
        default:begin
        pre_count<= G1;
        count<= G1+1;
        end
      endcase
end
end
endmodule
module count_time2(clk_1hz,G1,Y1,sw0,set,rst,seg,run);
input clk_1hz,sw0,set,rst,run;
input [7:0] G1,Y1;
output [7:0] seg;
reg [7:0] pre_count=8'd10,count=8'd10;

assign seg[7:0] =        count == 8'd100 ? 8'b1010_1010 :
                         count == 8'd88 ?  9'b1000_1000 :
                         count == 8'd30 ?  8'b0011_0000 :
                         count == 8'd29 ?  8'b0010_1001 :
                         count == 8'd28 ?  8'b0010_1000 :
                         count == 8'd27 ?  8'b0010_0111 :
                         count == 8'd26 ?  8'b0010_0110 :
                         count == 8'd25 ?  8'b0010_0101 :
                         count == 8'd24 ?  8'b0010_0100 :
                         count == 8'd23 ?  8'b0010_0011 :
                         count == 8'd22 ?   8'b0010_0010 :
                         count == 8'd21 ?   8'b0010_0001 :
                         count == 8'd20 ?  8'b0010_0000 :
                         count == 8'd19 ?  8'b0001_1001 :
                         count == 8'd18 ?  8'b0001_1000 :
                         count == 8'd17 ?  8'b0001_0111 :
                         count == 8'd16 ?  8'b0001_0110 :
                         count == 8'd15 ?  8'b0001_0101 :
                         count == 8'd14 ?  8'b0001_0100 :
                         count == 8'd13 ?  8'b0001_0011 :
                         count == 8'd12 ?  8'b0001_0010 :
                         count == 8'd11 ? 8'b0001_0001 :
                         count == 8'd10 ? 8'b0001_0000 :
                         count == 8'd9 ?  8'b0000_1001 :
                         count == 8'd8 ?  8'b0000_1000 :
                         count == 8'd7 ?  8'b0000_0111 :
                         count == 8'd6 ?  8'b0000_0110 :
                         count == 8'd5 ?  8'b0000_0101 :
                         count == 8'd4 ?  8'b0000_0100 :
                         count == 8'd3 ?  8'b0000_0011 :
                         count == 8'd2 ?  8'b0000_0010 :
                                         8'b0000_0001 ;

  always @(posedge clk_1hz) begin
    if(rst) begin
    pre_count <= 8'd10;
        count <= 8'd88;
        end
    else if(run) begin
        pre_count <= G1+Y1;
        count <= 8'd88;
    end
    else if (sw0) begin
    pre_count <= G1+Y1;
      count <= 8'd100;
    end
    else if(set) begin
    pre_count <= G1+Y1;
    count <= G1+Y1;
    end
    else if (count > 1) begin
    if(count==8'd100|| count==8'd88) count=G1+Y1;
    
    else
      count <= count - 1;
    end
    else begin
        case (pre_count)
        G1+Y1: begin
        count <= G1;
        pre_count<=G1;end
        G1: begin
        count <= Y1;
        pre_count <=Y1;end
        Y1: begin
        count <= G1+Y1;
        pre_count <=G1+Y1;
        end
        default:begin
        pre_count<= G1+Y1;
        count<= G1+Y1+1;
        end
      endcase
    end
  end
  endmodule
//Finate State Machine
module FSM(traffic1,traffic2,clk_1hz,rst,set,run,sw0,G1,Y1);
input clk_1hz,set,sw0,rst,run;
input [7:0] G1,Y1;
output reg [2:0] traffic1,traffic2;
reg [2:0] state=3'd0, next_state=3'd0;
reg [7:0] counter=8'd1;
  parameter 
        RED		= 3'b001,
        YELLOW	= 3'b101,
        GREEN	= 3'b100;
    //
    parameter		//	highway		railway
        S0 = 3'd0,	//	GREEN		RED
        S1 = 3'd1,	//	YELLOW		RED
        S2 = 3'd2,	//	RED			GREEN
        S3 = 3'd3,	//	RED			YELLOW
        OFF =3'd4;
       
    //
  
    //
   always @(state) begin
        case (state)
            S0: begin
                    traffic1 = GREEN;
                    traffic2 = RED;
                end
            S1: begin
                    traffic1 = YELLOW;
                    traffic2 = RED;
                end
            S2: begin
                    traffic1 = RED;
                    traffic2 = GREEN;
                end
            S3: begin
                    traffic1 = RED;
                    traffic2 = YELLOW;
                end
            OFF:begin
                    traffic1 = 3'b000;
                    traffic2 = 3'b000;
 
                end
            default: begin 
                    traffic1 = 3'b000;
                    traffic2 = 3'b000;
                    end
        endcase
    end
    //
     //
    
    always @(posedge clk_1hz) begin
          if(rst) begin
                state<=OFF;
                counter<=8'd2;
                  end
          else if(run) begin
                state<=OFF;
                  end
          else if(set) begin
                state<=OFF;
                  end
          else if(sw0) begin
                state<=OFF;
                end
          else begin
                state <= next_state;
                end
           
            
    case (state)
        S0:if (counter < G1) begin
                    counter <= counter + 8'd1;
                end else begin
                    next_state <= S1;
                    counter <= 8'd1;
                    end
                
             
        S1:if (counter < Y1) begin
                    counter <= counter + 8'd1;
                end else begin
                    next_state <= S2;
                    counter <= 8'd1;
                end
               
        S2:   if (counter < G1) begin
                    counter <= counter + 8'd1;
                end else begin
                    next_state <= S3;
                    counter <= 8'd1;
                end
               
               
        S3:  if (counter < Y1) begin
                    counter <= counter + 8'd1;
                end else begin
                    next_state <= S0;
                    counter <= 8'd1;
            
                end
        OFF: begin
                    next_state<=S0;
                    counter<=8'd2;
                    end
       
    endcase
end
endmodule
//clk divide from 125MHz to 1 Hz
module clk_divider_1hz(
   input clock_in,
output reg clock_out);
reg[27:0] counter=28'd0;
parameter DIVISOR = 28'd125000000;

always @(posedge clock_in)
begin
 counter <= counter + 28'd1;
 if(counter>=(DIVISOR-1))
  counter <= 28'd0;
 clock_out <= (counter<DIVISOR/2)?1'b1:1'b0;
end
endmodule
//clk divide from 125MHz to 0,5 Hz
module clk_divider_05hz(
     input clock_in,
output reg clock_out);
reg[27:0] counter=28'd0;
parameter DIVISOR = 28'd250000000;

always @(posedge clock_in)
begin
 counter <= counter + 28'd1;
 if(counter>=(DIVISOR-1))
  counter <= 28'd0;
 clock_out <= (counter<DIVISOR/2)?1'b1:1'b0;
end
endmodule
//clk divide from 125MHz to 2 Hz
module clk_divider_2hz(
     input clock_in,
output reg clock_out);
reg[27:0] counter=28'd0;
parameter DIVISOR = 28'd62500000;
always @(posedge clock_in)
begin
 counter <= counter + 28'd1;
 if(counter>=(DIVISOR-1))
  counter <= 28'd0;
 clock_out <= (counter<DIVISOR/2)?1'b1:1'b0;
end
endmodule  

module main_proj ( 
//declare I/O for module main_proj//
input clk,sw0,sw1,bgreen1,bgreen2,byellow1,byellow2,set,rst,run,
output [7:0] seg1,
output [7:0] seg2,
output [2:0] traffic1,traffic2,
output outyl1,outyl2,
output train1,train2);
wire clk_1hz,clk_2hz,clk_05hz;
reg [7:0] Y_to_R_delay=8'd3;
reg [7:0] G_to_Y_delay=8'd7;
//
//////////////////////////////////////////////////*****////////////////////////////////////////
//PROGRAM:
//clock
    clk_divider_05hz divider05(clk,clk_05hz);
    clk_divider_1hz divider1(clk,clk_1hz);
    clk_divider_2hz divider2(clk,clk_2hz);
//
//mode::counter
    count_time1 c2(.clk_1hz(clk_1hz),.G1(G_to_Y_delay),.Y1(Y_to_R_delay),.sw0(sw0),.set(set),.seg(seg1),.rst(rst),.run(run));
    count_time2 c1(.clk_1hz(clk_1hz),.G1(G_to_Y_delay),.Y1(Y_to_R_delay),.sw0(sw0),.set(set),.seg(seg2),.rst(rst),.run(run));
//
//mode::mode"night"||mode"train"
    mode m1(.clk_2hz(clk_2hz),.clk_05hz(clk_05hz),.sw0(sw0), .sw1(sw1), .outyl1(outyl1), .outyl2(outyl2), .train1(train1), .train2(train2));
//
//machine::fsm
    FSM f1(.traffic1(traffic1),.traffic2(traffic2),.clk_1hz(clk_1hz),.rst(rst),.run(run),.set(set),.sw0(sw0),.G1(G_to_Y_delay),.Y1(Y_to_R_delay));
//
//setting::increase/decrease time of lights
    always @(posedge clk_1hz)
    begin
    if(rst) begin 
    Y_to_R_delay<=8'd3;
    G_to_Y_delay<=8'd7;
    end
    else if(set) begin
    if(byellow1) Y_to_R_delay<=Y_to_R_delay+8'd1;
    else if(byellow2) Y_to_R_delay<=Y_to_R_delay-8'd1;
    else if(bgreen1) G_to_Y_delay<=G_to_Y_delay+8'd1;
    else if(bgreen2) G_to_Y_delay<=G_to_Y_delay-8'd1;
    end
    end
//
endmodule
