%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FileName      : DPSK_change_code.m
%  Description   : DPSK���ͱ任
%  Function List :
%                   [ x ] =DPSK_change_code( a,length_ori )
%  Parameter List:       
%	Output Parameter
%       x	        �����
%	Input Parameter
%       a	        ��Դ����
%       length_ori	��Դ����
%  History
%    1. Date        : 2015-12-14
%       Author      : Damon.Yuan
%       Version     : 0.1 
%       Modification: ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ x ] =DPSK_change_code( a,length_ori )

%��任��������������룩   b(n)=a(n)���b(n-1)
b=zeros(1,length_ori+1); %����룬��һλ�ǲο���Ԫ����Ϊ��0��

for i=1:length_ori
    b(i+1)=xor(b(i),a(i));
end

c=zeros(1,length_ori);
c(1:length_ori)=b(2:length_ori+1); %cΪaת���õ��������

%ӳ��(��0ӳ���-1),�ز�����ʱ���൱�ڶԡ�0�������롮1���෴��λ���ز����е��ƣ��ﵽ��������λ���Ƶ�Ŀ��
x(c==1)=1;
x(c==0)=-1;

end

