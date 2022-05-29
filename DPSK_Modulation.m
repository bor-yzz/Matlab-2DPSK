%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FileName      : DPSK_Modulation.m
%  Description   : DPSK调制程序
%  Function List :
%                   [m,m_x,y,dpsk] = DPSK_Modulation( dataBit,Fc,sample_num,t )
%  Parameter List:       
%	Output Parameter
%       DPSK	    DPSK已调信号
%	Input Parameter
%       dataBit	        信源数据
%       Fc	        载波频率
%       sample_num      码元宽度
%       t      时间向量
%  History
%    1. Date        : 2018-06-06
%       Author      : tony.liu
%       Version     : 1.1 
%       Modification: 初稿
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [m,m_x,y,dpsk] = DPSK_Modulation( dataBit,Fc,sample_num,t )

len=length(dataBit);      %码元序列长度

for i=1:len
     m((i-1)*sample_num+1 : i*sample_num)=dataBit(i);  %将码元序列转化成波形
end
      
%% 2.1差分编码
x=DPSK_change_code( dataBit,len );%码变换（绝对码变成相对码）


for i=1:len
     m_x((i-1)*sample_num+1 : i*sample_num)=x(i);  %将码元序列转化成波形
end

%% 2.2载波调制
y=cos(2*pi*Fc*t);    	%载波信号
dpsk=m_x.*y;            %载波调制


end

