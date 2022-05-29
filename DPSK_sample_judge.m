function [ y ] =DPSK_sample_judge( x,delta_T )

length_ori=length(x)/delta_T;
for i=1:length_ori
    if x((i-1)*delta_T+delta_T/2)>0%中点值与阈值比较
        y(i)=1;
    else y(i)=0;
    end
end
end

