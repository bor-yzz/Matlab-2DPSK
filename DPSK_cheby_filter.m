function [x_bp] =DPSK_cheby_filter(x,Fc,fs,Rb )


wsl=2*pi*(Fc-2*Rb)/fs;    %阻带上截止角频率
wpl=2*pi*(Fc-1.8*Rb)/fs;  %通带上截止角频率
wph=2*pi*(Fc+1.8*Rb)/fs;  %通带带下截止角频率
wsh=2*pi*(Fc+2*Rb)/fs;    %阻带下截止角频率

tr_width=min((wpl-wsl),(wsh-wph));  %过渡带宽度
N=ceil(11*pi/tr_width);             %滤波器阶数（根据布莱克曼窗计算的滤波器阶数）
n=2 ;
wl=(wsl+(wpl-wsl)/n)/pi ;  %  非理想带通滤波器
wh=(wsh-(wsh-wph)/n)/pi ;  % 非理想带通滤波器

wc=[wl,wh];     %设置理想带通截止频率

b=fir1(N-1,wc,blackman(N));  %设置滤波器系数

b_l2 = fix(length(b)/2);
len= length(x);
x_bandpass1 = conv(x,b);%卷积
x_bp(1:len) = x_bandpass1(b_l2 : b_l2 + len -1);%去除滤波器延时

end