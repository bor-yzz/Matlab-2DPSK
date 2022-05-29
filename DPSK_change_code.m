%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FileName      : DPSK_change_code.m
%  Description   : DPSK码型变换
%  Function List :
%                   [ x ] =DPSK_change_code( a,length_ori )
%  Parameter List:       
%	Output Parameter
%       x	        差分码
%	Input Parameter
%       a	        信源数据
%       length_ori	信源长度
%  History
%    1. Date        : 2015-12-14
%       Author      : Damon.Yuan
%       Version     : 0.1 
%       Modification: 初稿
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ x ] =DPSK_change_code( a,length_ori )

%码变换（绝对码变成相对码）   b(n)=a(n)异或b(n-1)
b=zeros(1,length_ori+1); %相对码，第一位是参考码元，设为“0”

for i=1:length_ori
    b(i+1)=xor(b(i),a(i));
end

c=zeros(1,length_ori);
c(1:length_ori)=b(2:length_ori+1); %c为a转化得到的相对码

%映射(将0映射成-1),载波调制时则相当于对‘0’用了与‘1’相反相位的载波进行调制，达到二进制相位调制的目的
x(c==1)=1;
x(c==0)=-1;

end

