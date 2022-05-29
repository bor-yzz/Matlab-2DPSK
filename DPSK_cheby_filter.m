function [x_bp] =DPSK_cheby_filter(x,Fc,fs,Rb )


wsl=2*pi*(Fc-2*Rb)/fs;    %����Ͻ�ֹ��Ƶ��
wpl=2*pi*(Fc-1.8*Rb)/fs;  %ͨ���Ͻ�ֹ��Ƶ��
wph=2*pi*(Fc+1.8*Rb)/fs;  %ͨ�����½�ֹ��Ƶ��
wsh=2*pi*(Fc+2*Rb)/fs;    %����½�ֹ��Ƶ��

tr_width=min((wpl-wsl),(wsh-wph));  %���ɴ����
N=ceil(11*pi/tr_width);             %�˲������������ݲ���������������˲���������
n=2 ;
wl=(wsl+(wpl-wsl)/n)/pi ;  %  �������ͨ�˲���
wh=(wsh-(wsh-wph)/n)/pi ;  % �������ͨ�˲���

wc=[wl,wh];     %���������ͨ��ֹƵ��

b=fir1(N-1,wc,blackman(N));  %�����˲���ϵ��

b_l2 = fix(length(b)/2);
len= length(x);
x_bandpass1 = conv(x,b);%���
x_bp(1:len) = x_bandpass1(b_l2 : b_l2 + len -1);%ȥ���˲�����ʱ

end