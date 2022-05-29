%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FileName      : DPSK_Demodulation.m
%  Description   : DPSK���
%  Function List :
%                   [dpsk_bp,dpsk_sin,dpsk_sin_lp,choupan,demodulate_dpsk] = DPSK_Demodulation( dpsk,y,length_ori,f1)
%  Parameter List:       
%	Output Parameter
%       demodulate_dpsk  dpsk����ź�
%	Input Parameter
%       dpsk	    dpsk�ѵ��ź�
%       y	        �ز�
%       f1	        �ز�Ƶ��
%       length_ori  ��Դ���ݵĳ���
%  History
%    1. Date        : 2015-12-14
%       Author      : Damon.Yuan
%       Version     : 0.1 
%       Modification: ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [dpsk_bp ,dpsk_sin,dpsk_sin_lp,choupan,demod_dpsk,demod_bit] = DPSK_Demodulation( dpsk,Fc,y,sample_num,Rb,fs)

len=length(dpsk)/sample_num;%��Ԫ����

%% ��ͨ�˲�
dpsk_bp=DPSK_cheby_filter(dpsk,Fc,fs,Rb);		%��ͨ�˲�

%% �����
dpsk_sin=dpsk_bp.*y;                            %�˷�������������ز���

%% ��ͨ�˲�
dpsk_sin_lp=DPSK_lowpass( dpsk_sin,fs,Rb );	%��ͨ�˲�

%% �����о�
choupan1=DPSK_sample_judge( dpsk_sin_lp,sample_num );	%�����о�

for i=1:len%�������
     choupan((i-1)*sample_num+1 : i*sample_num)=choupan1(i);  %����Ԫ����ת���ɲ���
end

%% �������
demod_bit=DPSK_oppsite_change_code( choupan1,len ); %�뷴�任

for i=1:len
     demod_dpsk((i-1)*sample_num+1 : i*sample_num)=demod_bit(i);  %����Ԫ����ת���ɲ���
end

end

