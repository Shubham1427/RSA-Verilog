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


module rsa_fpga_enc(input clk, input[15:0] msg, input btn1, input btn2, output[15:0] cipher);
    wire[18:0] p,q;
    reg[15:0] cipherR;
    reg[18:0] pR, qR;    
    integer state, res, e, tempD, tempA, tempB, tempC, n, phi_n, d;    
    reg btn1R, btn2R;   
       
    initial begin
        e =  103;
        cipherR = 0;
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
            phi_n = (pR-1)*(qR-1);
            tempA = msg;
            tempB = e;
            res = 1;
            state = 1;
        end
        
        else if (state == 1)
        begin        
            if (tempB == 0)
            begin
                cipherR = res;       
                state = 0;
            end
            
            else
            begin
                if (tempB & 1) begin
                    tempC = res * tempA;
                end  
                else
                    tempC = res;
                state = 2;            
            end
        end
        
        else if (state == 2)
        begin
            if (tempC >= n)
                tempC = tempC - n;
            else
            begin
                res = tempC;
                tempC = tempA * tempA;
                state = 3;
            end
        end
        
        else if (state == 3) begin
            if (tempC >= n)
                tempC = tempC - n;
            else begin
                tempA = tempC;
                tempB = tempB >> 1;
                state = 1;
            end
        end            
    end
    
//    prime_gen pgen(clk, btn1R, 1'b0, p);
//    prime_gen qgen(clk, btn2R, 1'b1, q);
    
    assign cipher = cipherR;
endmodule
