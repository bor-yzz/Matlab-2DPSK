%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FileName      : DPSK_oppsite_change_code.m
%  Description   : DPSK码型逆变换，相对码变绝对码
%  Function List :
%                   [ demodulate_dpsk ] =DPSK_oppsite_change_code( choupan,length_ori )
%  Parameter List:       
%	Output Parameter
%       demodulate_dpsk	   dpsk解调数据
%	Input Parameter
%       sample_judge  抽样判决输出
%       length_ori    信源长度
%  History
%    1. Date        : 2015-12-14
%       Author      : Damon.Yuan
%       Version     : 0.1 
%       Modification: 初稿
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ demodulate_dpsk ] =DPSK_oppsite_change_code( sample_judge,length_ori )

demodulate_dpsk=zeros(1,length_ori);
demodulate_dpsk(1)=xor(sample_judge(1),0);  %设定的第一位相对码为“0”
for i=2:length_ori
    %%
    %To do
    %输入参数：sample_judge (抽样判决后的数据)
    %输出参数：demodulate_dpsk (dpsk解调数据)
    %任务：相对码变绝对码
    demodulate_dpsk(i)=xor(sample_judge(i),sample_judge(i-1));
    %End to do
end


end

