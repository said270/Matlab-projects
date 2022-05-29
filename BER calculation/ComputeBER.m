function BER = ComputeBER(bit_seq,rec_bit_seq)
% Inputs:
%   bit_seq:     The input bit sequence
%   rec_bit_seq: The output bit sequence
% Outputs:
%   BER:         Computed BER
% This function takes the input and output bit sequences and computes the
% BER
%%% WRITE YOUR CODE HERE
n=0;
for i=1:length(bit_seq)
    if (xor(bit_seq(i),rec_bit_seq(i))==1)
        n=n+1;
    end
    
end
BER=(n/length(bit_seq));
%%%
