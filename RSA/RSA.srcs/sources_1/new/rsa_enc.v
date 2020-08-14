`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2019 01:05:11
// Design Name: 
// Module Name: rsa
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module rsa_enc(input clk, input[31:0] msg, input btn1, input btn2, output[31:0] cipher);
    wire[18:0] p,q;
    reg[31:0] cipherR, n;
    reg[18:0] pR, qR;    
    integer state, res, e, tempA, tempB, tempC;    
    reg btn1R, btn2R;   
       
    initial begin
        e =  103;
        state = 0;
    end   
        
    always @(posedge clk)
    begin
        if (state == 0) begin
            btn1R = btn1;
            btn2R = btn2;
            pR = 101;
            qR = 109;
            n = pR * qR;
            tempA = msg;
            tempB = e;
            res = 1;
            tempC = 1;
            state = 1;
        end
        
        if (state == 1)
        begin        
            if (tempB == 0)
            begin
                cipherR = res;
                state = 0;
            end
            
            else
            begin
                if (tempB & 1) begin
                    tempC = (res * tempA) % n;
                end  
                else
                    tempC = res;
                res = tempC;
                tempC = (tempA * tempA) % n;
                tempA = tempC;
                tempB = tempB >> 1;          
            end
        end      
    end
    
    prime_gen pgen(clk, btn1R, 1'b0, p);
    prime_gen qgen(clk, btn2R, 1'b1, q);
    
    assign cipher = cipherR;
endmodule
