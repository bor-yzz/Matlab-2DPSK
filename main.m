%%---------------------------Example-------------------------------------%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %  LabName:             DPSK调制解调实验
% %  Task:                1.生成长度为256的随机bit数据,载波频率614400，进行
% %                         DBPSK调制，加入信噪比为10dB的噪声并使用相干解调法
% %                         解调
% %                       2.统计误码数,绘制调制解调过程的波形，将基带信号和已调
% %                         信号分别输出到示波器
% %  Programming tips:   1.数据源：随机生成256位bit数据
% %                      2.调制:
% %                        2.1差分编码
% %                           将数据源过采样后数据按照编码规则进行差分编码，第
% %                           一位参考相位为0，将绝对码转换成相对码
% %                        2.2载波调制：
% %                           将差分编码后数据过采样后乘以载波
% %                      3.加噪：已调信号加入噪声得到加噪声后信号
% %                      4.解调：
% %                        4.1带通滤波：滤除除已调信号外的噪声信号
% %                        4.2相乘器：乘以相干载波
% %                        4.3低通滤波：取出低频分量，得到解调信号
% %                        4.4抽样判决：将低通滤波后的值与0比较，大于则判为1，
% %                            否则判为0
% %                        4.5差分译码：进行差分编码逆变换，将相对码转换成绝对码
% %                      5.统计误码数：数据源与抽样判决后数据异或，累加得到误码
% %                        数
% %                      6.输出波形
% %                        绘制出DBPSK调制解调过程波形图
% %                        示波器CH1通道输出基带信号波形
% %                        示波器CH2通道输出已调信号波形
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %  History
% %    1. Date:           2018-06-06
% %       Author:         tony.liu
% %       Version:        1.1 
% %       Modification:   初稿
% %    2. Date:           2020-09-02
% %       Author:         DIAN
% %       Version:        1.2 
% %       Modification:   课后习题
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %  Parameter List: 
% %     Output Parameter
% %          m	          数据源
% %          m_x          码变换后信号
% %          y	          载波
% %          dpsk	      已调信号
% %          dpsk_bp      带通滤波后信号
% %          dpsk_sin     乘相干载波后信号
% %          dpsk_sin_lp  低通滤波后信号
% %          choupan      抽样判决后信号
% %          demod_dpsk   解调信号
% %      Input Parameter
% %          Rb           码元速率
% %          sample_num   一个码元采样点数
% %          len          数据源长度
% %          N            采样点数
% %          fs           采样率
% %          Fc	          载波频率
% %          snr          信噪比
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
clf
fs=30720000;% 采样率,硬件系统基准采样率30.72 MHz，fs可配30.72MHz, 3.72Mhz，307.2KHz , 30.72KHz，或其它(要求fs需被30720000整除).fs最大可配30.72MHz,fs最小可配30000Hz
runType=0;%运行方式，0表示仿真，1表示软硬结合

Rb=307200;          %码元速率,需为fs整除
sample_num=fs/Rb;   %一个码元采样点数
len=64;            %数据源长度
N=len*sample_num ;   %采样点数=sample_num*len
dt=1/fs;
t=0:dt:(N-1)*dt;
Fc=Rb*2;         %载波频率，单位Hz,载波频率配置需为Rb的整数倍,并且Fc小于fs/2
snr=1000;
Tb=1/Rb;%码元长度
%% 1.数据源

dataBit=randi([0,1],1,len);

%% 2.调制
[m,m_x,y,dpsk] = DPSK_Modulation( dataBit,Fc,sample_num,t );

%% 3.加噪
dpsk=awgn(dpsk,snr);

%% 4.解调
[dpsk_bp ,dpsk_sin,dpsk_sin_lp,choupan,demod_dpsk,demod_bit] = DPSK_Demodulation( dpsk,Fc,y,sample_num,Rb,fs);

%% 5.统计误码率

sum(xor(dataBit,demod_bit))

%% 6.输出波形
% 软件仿真波形图
figure(1)
subplot(411);
plot(t,m);axis([0 2.2*10^-4 -0.1 1.1]);
xlabel('时间(s)');ylabel('幅值(v)');
title('数据源:m')
subplot(412);
plot(t,m_x);axis([0 2.2*10^-4 -1.1 1.1]);
xlabel('时间(s)');ylabel('幅值(v)');
title('码变换后信号:m-x')
subplot(413);
plot(t,dpsk);axis([0 2.2*10^-4 -5 5]);
xlabel('时间(s)');ylabel('幅值(v)');
title('已调信号:dpsk')
subplot(414);
plot(t,dpsk_bp);axis([0 2.2*10^-4 -2 2]);
xlabel('时间(s)');ylabel('幅值(v)');
title('带通滤波后信号:dpsk-bp')

figure(2)
subplot(411);
plot(t,dpsk_sin);axis([0 2.2*10^-4 -2 2]);
xlabel('时间(s)');ylabel('幅值(v)');
title('乘相干载波后信号:dpsk-sin')
subplot(412);
plot(t,dpsk_sin_lp);axis([0 2.2*10^-4 -2 2]);
xlabel('时间(s)');ylabel('幅值(v)');
title('低通滤波后信号:dpsk-sin-lp')
subplot(413);
plot(t,choupan);axis([0 2.2*10^-4 -0.1 1.1]);
xlabel('时间(s)');ylabel('幅值(v)');
title('抽样判决后信号:choupan')
subplot(414);
plot(t,demod_dpsk);axis([0 2.2*10^-4 -0.1 1.1]);
xlabel('时间(s)');ylabel('幅值(v)');
title('解调信号:demod-dpsk')

% 软件仿真波形图 眼图
figure(3)
Eye_num=2;Samp_rate=fs/Fc;
subplot(421);
for k=10:floor(length(m)/Samp_rate)-10
    s1=m(k*Samp_rate+1:(k+Eye_num)*Samp_rate);
    plot(s1);axis([-10 110 -0.5 1.5]);
    hold on;
end
ylabel('幅值(v)');title('数据源:m 眼图')
subplot(422);
for k=10:floor(length(m_x)/Samp_rate)-10
    s2=m_x(k*Samp_rate+1:(k+Eye_num)*Samp_rate);
    plot(s2);axis([-10 110 -1.5 1.5]);
    hold on;
end
ylabel('幅值(v)');title('码变换后信号:m-x 眼图')
subplot(423);
for k=10:floor(length(dpsk)/Samp_rate)-10
    s3=dpsk(k*Samp_rate+1:(k+Eye_num)*Samp_rate);
    plot(s3);axis([-10 110 -5 5]);
    hold on;
end
ylabel('幅值(v)');title('已调信号:dpsk 眼图')
subplot(424);
for k=10:floor(length(dpsk_bp)/Samp_rate)-10
    s4=dpsk_bp(k*Samp_rate+1:(k+Eye_num)*Samp_rate);
    plot(s4);axis([-10 110 -2 2]);
    hold on;
end
ylabel('幅值(v)');title('带通滤波后信号:dpsk-bp 眼图')

subplot(425);
for k=10:floor(length(dpsk_sin)/Samp_rate)-10
    s5=dpsk_sin(k*Samp_rate+1:(k+Eye_num)*Samp_rate);
    plot(s5);axis([-10 110 -2 2]);
    hold on;
end
ylabel('幅值(v)');title('乘相干载波后信号:dpsk-sin 眼图')
subplot(426);
for k=10:floor(length(dpsk_sin_lp)/Samp_rate)-10
    s6=dpsk_sin_lp(k*Samp_rate+1:(k+Eye_num)*Samp_rate);
    plot(s6);axis([-10 110 -1.5 1.5]);
    hold on;
end
ylabel('幅值(v)');title('低通滤波后信号:dpsk-sin-lp 眼图')
subplot(427);
for k=10:floor(length(choupan)/Samp_rate)-10
    s7=choupan(k*Samp_rate+1:(k+Eye_num)*Samp_rate);
    plot(s7);axis([-10 110 -0.5 1.5]);
    hold on;
end
ylabel('幅值(v)');title('抽样判决后信号:choupan 眼图')
subplot(428);
for k=10:floor(length(demod_dpsk)/Samp_rate)-10
    s8=demod_dpsk(k*Samp_rate+1:(k+Eye_num)*Samp_rate);
    plot(s8);axis([-10 110 -0.5 1.5]);
    hold on;
end
ylabel('幅值(v)');title('解调信号:demod-dpsk 眼图')
