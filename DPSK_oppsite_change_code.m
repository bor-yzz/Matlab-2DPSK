%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FileName      : DPSK_oppsite_change_code.m
%  Description   : DPSK������任�������������
%  Function List :
%                   [ demodulate_dpsk ] =DPSK_oppsite_change_code( choupan,length_ori )
%  Parameter List:       
%	Output Parameter
%       demodulate_dpsk	   dpsk�������
%	Input Parameter
%       sample_judge  �����о����
%       length_ori    ��Դ����
%  History
%    1. Date        : 2015-12-14
%       Author      : Damon.Yuan
%       Version     : 0.1 
%       Modification: ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ demodulate_dpsk ] =DPSK_oppsite_change_code( sample_judge,length_ori )

demodulate_dpsk=zeros(1,length_ori);
demodulate_dpsk(1)=xor(sample_judge(1),0);  %�趨�ĵ�һλ�����Ϊ��0��
for i=2:length_ori
    %%
    %To do
    %���������sample_judge (�����о��������)
    %���������demodulate_dpsk (dpsk�������)
    %���������������
    demodulate_dpsk(i)=xor(sample_judge(i),sample_judge(i-1));
    %End to do
end


end

