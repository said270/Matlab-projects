function rec_bit_seq = DecodeBitsFromSamples(rec_sample_seq,case_type,fs)
%
% Inputs:
%   rec_sample_seq: The input sample sequence to the channel
%   case_type:      The sampling frequency used to generate the sample sequence
%   fs:             The bit flipping probability
% Outputs:
%   rec_sample_seq: The sequence of sample sequence after passing through the channel
%
% This function takes the sample sequence after passing through the
% channel, and decodes from it the sequence of bits based on the considered
% case and the sampling frequence

if (nargin <= 2)
    fs = 1;
end

switch case_type
    
    case 'part_1'
        %%% WRITE YOUR CODE FOR PART 1 HERE
        
        % for part 1 we will only study the impact of the channel so the
        %recicer can be considered = channel output 
        rec_bit_seq=rec_sample_seq;
        
        %%%

        
    case 'part_2'
        %%% WRITE YOUR CODE FOR PART 2 HERE
        
        % we will be using a nested for loop in order to compare the nearby
        % elements decided by fs 
        c=0;
        d=0;
        e=0;
        f=0;
        for a=1:fs:length(rec_sample_seq)
            f=f+1;
            for b=0:1:fs-1
                c=a+b;
                if(rec_sample_seq(c)==0)
                    d=d+1;
                else
                    e=e+1;
                end
                if(d>e)
                    rec_bit_seq(f)=0;
                else
                    rec_bit_seq(f)=1;
                end
            end
            d=0;
            e=0;
        end
                
        %%%
    case 'part_3'
        %%% WRITE YOUR CODE FOR PART 3 HERE
        c=0;
        d=0;
        f=0;
        for a=1:fs:length(rec_sample_seq)
            f=f+1;       
                
                if(rec_sample_seq(a)==0)
                    d=0;
                else
                    d=1;
                end
                if(d==0)
                    rec_bit_seq(f)=0;
                else
                    rec_bit_seq(f)=1;
                
                end
           
        end
                
        %%%

      case 'part_4'
      %%% WRITE YOUR CODE FOR PART 2 HERE
        
        % we will be using a nested for loop in order to compare the nearby
        % elements decided by fs 
        c=0;
        d=0;
        e=0;
        f=0;
        a=1;
        b=0;
        for a=1:fs:length(rec_sample_seq)
            f=f+1;
            for b=0:1:fs-1
                c=a+b;
                if(rec_sample_seq(c)==0)
                    d=d+1;
                else
                    e=e+1;
                end
                if(d>e)
                    rec_bit_seq(f)=0;
                else
                    rec_bit_seq(f)=1;
                end
            end
            d=0;
            e=0;
        end
        
end
               
    
    