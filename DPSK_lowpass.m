function [ x_lowpass ] =DPSK_lowpass( x,fs,Rb )
    ws=2*Rb;                    %ͨ����ֹƵ��
    ws1=4*Rb;                  %�����ʼƵ��
    wt=2*pi*ws/fs;                  %���������ͨ����ֹ��Ƶ��
    wz=2*pi*ws1/fs;                 %�������ʼƵ��
    wc=(wt+wz)/2;                   %��һ������˲�����ֹƵ��
    N=ceil(6.6*pi/(wz-wt));         %t=(n-1)/2;
    b=fir1(N-1,wc/pi,hanning(N));   %�˲���ʱ����,�˲�ϵ��   
 

    b_l2 = fix(length(b)/2);
    len= length(x);
    x_lowpass1 = conv(x,b);
    x_lowpass(1:len) = x_lowpass1(b_l2 : b_l2 + len -1);


end

