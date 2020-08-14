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


module rsa_dec(input clk, input[31:0] cipher, input btn1, input btn2, output[31:0] msg);
    wire[18:0] p,q;
    reg[31:0] phi_n, d;
    reg[31:0] msgDecryptR, n;
    reg[18:0] pR, qR;    
    integer state, res,quotient, e, d_old, d_new, r_old, r_new, tempX, tempY, tempR, tempA, tempB, tempC;    
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
            phi_n = (pR-1)*(qR-1);



            d_old = 0;
            d_new = 1;
            r_old = phi_n;
            r_new = e;
            state = 1;
        end

        
        if (state == 1)
        begin        
            if (r_new == 0)
            begin               
                if (d_old < 0) begin
                    d_old = d_old + phi_n;
                end
                d = d_old;
                tempA = cipher;
                tempB = d;
                res = 1;
                tempC = 1;
                state = 2;
            end
           
            else begin
                quotient = r_old/r_new;
      
                tempX = d_old - d_new * quotient;
                tempR = r_old - r_new * quotient;
                d_old = d_new;
                r_old = r_new;
                d_new = tempX;
                r_new = tempR;
            end                     
        end 



        
        if (state == 2)
        begin
            if (tempB == 0)
            begin
                msgDecryptR = res;
                state = 0;
            end
            
            else
            begin
                if (tempB & 1) begin
                    tempC = (res* tempA) % n;
                end  
                else begin
                    tempC = res;
                end
                res = tempC;
                tempC = (tempA * tempA) % n;
                tempA = tempC;
                tempB = tempB >> 1;            
            end
        end


           
    end
    
    prime_gen pgen(clk, btn1R, 1'b0, p);
    prime_gen qgen(clk, btn2R, 1'b1, q);
    
    assign msg = msgDecryptR;
endmodule
