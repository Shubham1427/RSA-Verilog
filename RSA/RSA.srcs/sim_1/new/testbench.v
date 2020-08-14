`timescale 1ns / 1ps

module testbench();

    reg [31:0] A,C,C1,C2;
    wire[31:0] B,P1; 
    reg clk,btn1,btn2;
    integer input1,ascii_output,ascii_input,cipher_text,plain_text,output1;
    
rsa_enc rsa_enc_module(clk,C,btn1,btn2,B);
rsa_dec rsa_dec_module(clk,C1,btn1,btn2,P1);
initial begin
    clk = 1;
    btn1 = 1;
    btn2 = 0;
    #1;
    btn1 = 0;
    btn2 = 0;
    C=0;
    input1=$fopen("C:/Users/Shubham/RSA/RSA.srcs/sim_1/new/input.txt","r");   
    ascii_output=$fopen("C:\\Users\\Shubham\\RSA\\RSA.srcs\\sim_1\\new\\ascii_output.txt","w");
    if(input1==0)
    $display("Not found");
    else begin
        while (! $feof(input1)) begin 
            A=$fgetc(input1); 
            if(A!=-1)
            $fdisplay(ascii_output,"%d",A); 
            #10;
        end 
        $fclose(input1);
        $fclose(ascii_output);
        
        ascii_input=$fopen("C:\\Users\\Shubham\\RSA\\RSA.srcs\\sim_1\\new\\ascii_output.txt","r");
        cipher_text=$fopen("C:\\Users\\Shubham\\RSA\\RSA.srcs\\sim_1\\new\\cipher_text.txt","w");
        while(!$feof(ascii_input)) begin
            if(!$feof(ascii_input)) begin
            $fscanf(ascii_input,"%d",C);
            #50;
            $fdisplay(cipher_text,"%d",B);
            #10;
            end
        end
        $fclose(ascii_input);
        $fclose(cipher_text);
        cipher_text=$fopen("C:\\Users\\Shubham\\RSA\\RSA.srcs\\sim_1\\new\\cipher_text.txt","r");
        plain_text=$fopen("C:\\Users\\Shubham\\RSA\\RSA.srcs\\sim_1\\new\\plain_text.txt","w");
        while(!$feof(cipher_text)) begin
            $fscanf(cipher_text,"%d",C1);
            if(!$feof(cipher_text)) begin
            #50;
            $fdisplay(plain_text,"%d",P1);
            #10;
            end
        end
        $fclose(cipher_text);
        $fclose(plain_text);
        plain_text=$fopen("C:\\Users\\Shubham\\RSA\\RSA.srcs\\sim_1\\new\\plain_text.txt","r");
        output1=$fopen("C:\\Users\\Shubham\\RSA\\RSA.srcs\\sim_1\\new\\output.txt","w");
        while (! $feof(plain_text)) begin 
            $fscanf(plain_text,"%d",C2);
            if(!$feof(plain_text))
            $fwrite(output1,"%c",C2);
            #10;
        end 
        $fclose(plain_text);
        $fclose(output1);
    end    
end
   always #0.5 clk = ~clk;
//   always begin
//        #500000 btn1 = ~btn1;
//        #1 btn1 = ~btn1;
//    end
//    always begin
//        #50000 btn2 = ~btn2;
//        #1 btn2 = ~btn2;
//     end

endmodule