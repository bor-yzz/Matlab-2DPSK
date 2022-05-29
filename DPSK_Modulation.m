%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FileName      : DPSK_Modulation.m
%  Description   : DPSK���Ƴ���
%  Function List :
%                   [m,m_x,y,dpsk] = DPSK_Modulation( dataBit,Fc,sample_num,t )
%  Parameter List:       
%	Output Parameter
%       DPSK	    DPSK�ѵ��ź�
%	Input Parameter
%       dataBit	        ��Դ����
%       Fc	        �ز�Ƶ��
%       sample_num      ��Ԫ���
%       t      ʱ������
%  History
%    1. Date        : 2018-06-06
%       Author      : tony.liu
%       Version     : 1.1 
%       Modification: ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [m,m_x,y,dpsk] = DPSK_Modulation( dataBit,Fc,sample_num,t )

len=length(dataBit);      %��Ԫ���г���

for i=1:len
     m((i-1)*sample_num+1 : i*sample_num)=dataBit(i);  %����Ԫ����ת���ɲ���
end
      
%% 2.1��ֱ���
x=DPSK_change_code( dataBit,len );%��任��������������룩


for i=1:len
     m_x((i-1)*sample_num+1 : i*sample_num)=x(i);  %����Ԫ����ת���ɲ���
end

%% 2.2�ز�����
y=cos(2*pi*Fc*t);    	%�ز��ź�
dpsk=m_x.*y;            %�ز�����


end

