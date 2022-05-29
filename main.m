%%---------------------------Example-------------------------------------%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %  LabName:             DPSK���ƽ��ʵ��
% %  Task:                1.���ɳ���Ϊ256�����bit����,�ز�Ƶ��614400������
% %                         DBPSK���ƣ����������Ϊ10dB��������ʹ����ɽ����
% %                         ���
% %                       2.ͳ��������,���Ƶ��ƽ�����̵Ĳ��Σ��������źź��ѵ�
% %                         �źŷֱ������ʾ����
% %  Programming tips:   1.����Դ���������256λbit����
% %                      2.����:
% %                        2.1��ֱ���
% %                           ������Դ�����������ݰ��ձ��������в�ֱ��룬��
% %                           һλ�ο���λΪ0����������ת���������
% %                        2.2�ز����ƣ�
% %                           ����ֱ�������ݹ�����������ز�
% %                      3.���룺�ѵ��źż��������õ����������ź�
% %                      4.�����
% %                        4.1��ͨ�˲����˳����ѵ��ź���������ź�
% %                        4.2���������������ز�
% %                        4.3��ͨ�˲���ȡ����Ƶ�������õ�����ź�
% %                        4.4�����о�������ͨ�˲����ֵ��0�Ƚϣ���������Ϊ1��
% %                            ������Ϊ0
% %                        4.5������룺���в�ֱ�����任���������ת���ɾ�����
% %                      5.ͳ��������������Դ������о�����������ۼӵõ�����
% %                        ��
% %                      6.�������
% %                        ���Ƴ�DBPSK���ƽ�����̲���ͼ
% %                        ʾ����CH1ͨ����������źŲ���
% %                        ʾ����CH2ͨ������ѵ��źŲ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %  History
% %    1. Date:           2018-06-06
% %       Author:         tony.liu
% %       Version:        1.1 
% %       Modification:   ����
% %    2. Date:           2020-09-02
% %       Author:         DIAN
% %       Version:        1.2 
% %       Modification:   �κ�ϰ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %  Parameter List: 
% %     Output Parameter
% %          m	          ����Դ
% %          m_x          ��任���ź�
% %          y	          �ز�
% %          dpsk	      �ѵ��ź�
% %          dpsk_bp      ��ͨ�˲����ź�
% %          dpsk_sin     ������ز����ź�
% %          dpsk_sin_lp  ��ͨ�˲����ź�
% %          choupan      �����о����ź�
% %          demod_dpsk   ����ź�
% %      Input Parameter
% %          Rb           ��Ԫ����
% %          sample_num   һ����Ԫ��������
% %          len          ����Դ����
% %          N            ��������
% %          fs           ������
% %          Fc	          �ز�Ƶ��
% %          snr          �����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
clf
fs=30720000;% ������,Ӳ��ϵͳ��׼������30.72 MHz��fs����30.72MHz, 3.72Mhz��307.2KHz , 30.72KHz��������(Ҫ��fs�豻30720000����).fs������30.72MHz,fs��С����30000Hz
runType=0;%���з�ʽ��0��ʾ���棬1��ʾ��Ӳ���

Rb=307200;          %��Ԫ����,��Ϊfs����
sample_num=fs/Rb;   %һ����Ԫ��������
len=64;            %����Դ����
N=len*sample_num ;   %��������=sample_num*len
dt=1/fs;
t=0:dt:(N-1)*dt;
Fc=Rb*2;         %�ز�Ƶ�ʣ���λHz,�ز�Ƶ��������ΪRb��������,����FcС��fs/2
snr=1000;
Tb=1/Rb;%��Ԫ����
%% 1.����Դ

dataBit=randi([0,1],1,len);

%% 2.����
[m,m_x,y,dpsk] = DPSK_Modulation( dataBit,Fc,sample_num,t );

%% 3.����
dpsk=awgn(dpsk,snr);

%% 4.���
[dpsk_bp ,dpsk_sin,dpsk_sin_lp,choupan,demod_dpsk,demod_bit] = DPSK_Demodulation( dpsk,Fc,y,sample_num,Rb,fs);

%% 5.ͳ��������

sum(xor(dataBit,demod_bit))

%% 6.�������
% ������沨��ͼ
figure(1)
subplot(411);
plot(t,m);axis([0 2.2*10^-4 -0.1 1.1]);
xlabel('ʱ��(s)');ylabel('��ֵ(v)');
title('����Դ:m')
subplot(412);
plot(t,m_x);axis([0 2.2*10^-4 -1.1 1.1]);
xlabel('ʱ��(s)');ylabel('��ֵ(v)');
title('��任���ź�:m-x')
subplot(413);
plot(t,dpsk);axis([0 2.2*10^-4 -5 5]);
xlabel('ʱ��(s)');ylabel('��ֵ(v)');
title('�ѵ��ź�:dpsk')
subplot(414);
plot(t,dpsk_bp);axis([0 2.2*10^-4 -2 2]);
xlabel('ʱ��(s)');ylabel('��ֵ(v)');
title('��ͨ�˲����ź�:dpsk-bp')

figure(2)
subplot(411);
plot(t,dpsk_sin);axis([0 2.2*10^-4 -2 2]);
xlabel('ʱ��(s)');ylabel('��ֵ(v)');
title('������ز����ź�:dpsk-sin')
subplot(412);
plot(t,dpsk_sin_lp);axis([0 2.2*10^-4 -2 2]);
xlabel('ʱ��(s)');ylabel('��ֵ(v)');
title('��ͨ�˲����ź�:dpsk-sin-lp')
subplot(413);
plot(t,choupan);axis([0 2.2*10^-4 -0.1 1.1]);
xlabel('ʱ��(s)');ylabel('��ֵ(v)');
title('�����о����ź�:choupan')
subplot(414);
plot(t,demod_dpsk);axis([0 2.2*10^-4 -0.1 1.1]);
xlabel('ʱ��(s)');ylabel('��ֵ(v)');
title('����ź�:demod-dpsk')

% ������沨��ͼ ��ͼ
figure(3)
Eye_num=2;Samp_rate=fs/Fc;
subplot(421);
for k=10:floor(length(m)/Samp_rate)-10
    s1=m(k*Samp_rate+1:(k+Eye_num)*Samp_rate);
    plot(s1);axis([-10 110 -0.5 1.5]);
    hold on;
end
ylabel('��ֵ(v)');title('����Դ:m ��ͼ')
subplot(422);
for k=10:floor(length(m_x)/Samp_rate)-10
    s2=m_x(k*Samp_rate+1:(k+Eye_num)*Samp_rate);
    plot(s2);axis([-10 110 -1.5 1.5]);
    hold on;
end
ylabel('��ֵ(v)');title('��任���ź�:m-x ��ͼ')
subplot(423);
for k=10:floor(length(dpsk)/Samp_rate)-10
    s3=dpsk(k*Samp_rate+1:(k+Eye_num)*Samp_rate);
    plot(s3);axis([-10 110 -5 5]);
    hold on;
end
ylabel('��ֵ(v)');title('�ѵ��ź�:dpsk ��ͼ')
subplot(424);
for k=10:floor(length(dpsk_bp)/Samp_rate)-10
    s4=dpsk_bp(k*Samp_rate+1:(k+Eye_num)*Samp_rate);
    plot(s4);axis([-10 110 -2 2]);
    hold on;
end
ylabel('��ֵ(v)');title('��ͨ�˲����ź�:dpsk-bp ��ͼ')

subplot(425);
for k=10:floor(length(dpsk_sin)/Samp_rate)-10
    s5=dpsk_sin(k*Samp_rate+1:(k+Eye_num)*Samp_rate);
    plot(s5);axis([-10 110 -2 2]);
    hold on;
end
ylabel('��ֵ(v)');title('������ز����ź�:dpsk-sin ��ͼ')
subplot(426);
for k=10:floor(length(dpsk_sin_lp)/Samp_rate)-10
    s6=dpsk_sin_lp(k*Samp_rate+1:(k+Eye_num)*Samp_rate);
    plot(s6);axis([-10 110 -1.5 1.5]);
    hold on;
end
ylabel('��ֵ(v)');title('��ͨ�˲����ź�:dpsk-sin-lp ��ͼ')
subplot(427);
for k=10:floor(length(choupan)/Samp_rate)-10
    s7=choupan(k*Samp_rate+1:(k+Eye_num)*Samp_rate);
    plot(s7);axis([-10 110 -0.5 1.5]);
    hold on;
end
ylabel('��ֵ(v)');title('�����о����ź�:choupan ��ͼ')
subplot(428);
for k=10:floor(length(demod_dpsk)/Samp_rate)-10
    s8=demod_dpsk(k*Samp_rate+1:(k+Eye_num)*Samp_rate);
    plot(s8);axis([-10 110 -0.5 1.5]);
    hold on;
end
ylabel('��ֵ(v)');title('����ź�:demod-dpsk ��ͼ')



%ʾ����ʵ�Ⲩ��ͼ
% ����DA��������������ʾ������
if  runType==1
    CH1_data=m;%ʾ����CH1ͨ���������
    CH2_data=dpsk;%ʾ����CH2ͨ���������
    divFreq=floor(30720000/fs-1);%��Ƶֵ,999��Ƶϵͳ������Ϊ30720Hz,  99��Ƶϵͳ������Ϊ307200Hz, 9��Ƶϵͳ������Ϊ 3072000Hz,  0��Ƶϵͳ������30720000Hz
    dataNum=N;
    isGain=1;%���濪�أ�0��ʾ����ֵ�Ŵ�1��ʾ��ֵ�Ŵ�
    DA_OUT(CH1_data,CH2_data,divFreq,dataNum,isGain);%���ô˺���֮ǰ��ȷ��XSRP����������������
end





%%---------------------------Example End---------------------------------%%



%%---------------------------Student Program1-----------------------------%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %  LabName:           DPSK���ƽ��ʵ��
% %  Task:              1.���ɳ���Ϊ10����Դbit[1,0,0,1,1,0,0,1,1,0]���ز�Ƶ
% %                      ��1228800������DBPSK���ƣ����������Ϊ10dB��������ʹ
% %                       ����ɽ�������
% %                     2.ͳ��������,���Ƶ��ƽ�����̵Ĳ���ͼ���������źź��ѵ�
% %                         �źŷֱ������ʾ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%---------------------------Student Program1 End-------------------------%%



%%---------------------------Student Program2-----------------------------%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %  LabName:           DPSK���ƽ��ʵ��
% %  Task:              1.���ɳ���Ϊ10����Դbit[1,0,0,1,1,0,0,1,1,0]���ز�Ƶ
% %                      ��1228800������DPSK���ƣ����������Ϊ10dB��������ʹ��
% %                      �����ɽ�������
% %                     2.ͳ��������,���Ƶ��ƽ�����̵Ĳ��Σ��������źź��ѵ�
% %                         �źŷֱ������ʾ����
% %  Programming tips:  1.�����
% %                       1.1��ͨ�˲����˳����ѵ��ź���������ź�
% %                       1.2�ӳ٣�����ͨ�˲������ź�����ӳ� TB
% %                          �ӳٺ��źŵ�һ��TB�ڵ�ֵ��0���棬ȥ����ͨ�˲���
% %                          �ź����һ��TB�ڵ�ֵ
% %                       1.3���������ͨ�˲������ź����ӳٺ��ź����
% %                       1.4��ͨ�˲���ȡ����Ƶ�������õ�����ź�
% %                       1.5�����о�������ͨ�˲����ֵ��0�Ƚϣ�С������Ϊ1��
% %                           ������Ϊ0������ȡ��������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%---------------------------Student Program2 End-------------------------%%
