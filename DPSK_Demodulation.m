%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FileName      : DPSK_Demodulation.m
%  Description   : DPSK解调
%  Function List :
%                   [dpsk_bp,dpsk_sin,dpsk_sin_lp,choupan,demodulate_dpsk] = DPSK_Demodulation( dpsk,y,length_ori,f1)
%  Parameter List:       
%	Output Parameter
%       demodulate_dpsk  dpsk解调信号
%	Input Parameter
%       dpsk	    dpsk已调信号
%       y	        载波
%       f1	        载波频率
%       length_ori  信源数据的长度
%  History
%    1. Date        : 2015-12-14
%       Author      : Damon.Yuan
%       Version     : 0.1 
%       Modification: 初稿
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [dpsk_bp ,dpsk_sin,dpsk_sin_lp,choupan,demod_dpsk,demod_bit] = DPSK_Demodulation( dpsk,Fc,y,sample_num,Rb,fs)

len=length(dpsk)/sample_num;%码元长度

%% 带通滤波
dpsk_bp=DPSK_cheby_filter(dpsk,Fc,fs,Rb);		%带通滤波

%% 相乘器
dpsk_sin=dpsk_bp.*y;                            %乘法器（乘以相干载波）

%% 低通滤波
dpsk_sin_lp=DPSK_lowpass( dpsk_sin,fs,Rb );	%低通滤波

%% 抽样判决
choupan1=DPSK_sample_judge( dpsk_sin_lp,sample_num );	%抽样判决

for i=1:len%样点序号
     choupan((i-1)*sample_num+1 : i*sample_num)=choupan1(i);  %将码元序列转化成波形
end

%% 差分译码
demod_bit=DPSK_oppsite_change_code( choupan1,len ); %码反变换

for i=1:len
     demod_dpsk((i-1)*sample_num+1 : i*sample_num)=demod_bit(i);  %将码元序列转化成波形
end

end

