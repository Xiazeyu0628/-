clc;
clear;
close all
tic %��¼ʱ��
%% �������
option.arriage_L=5.8;     %����
option.arriage_W=3.0;
option.arriage_H=0.95;
option.unit=0.1;  %��λ����
data.ammoBox1_Size=xlsread('ammoBox_Size.xlsx');
data.ammoBox1_Size=data.ammoBox1_Size(:,2:3); %����ʾ�����У�����֮���2:3��ʾ����2ȡ����3������Ϊ1
temp=data.ammoBox1_Size(:,1).*data.ammoBox1_Size(:,2);
option.max_num=ceil(option.arriage_W*option.arriage_L/min(temp));
%option.max_num=37   
data.ammoBox1_Size=[data.ammoBox1_Size;data.ammoBox1_Size(:,[2,1])];
%��ôX=[X; Y] ��ʾdata.ammoBox1_Size����ÿһ��data.ammoBox1_Size(:,[2,1])�Ľ������һ��ΪX=[Y1]�� �ڶ���ΪX=[Y1; Y2]������
%��ʹ��ȡ�����в��������ߴ�����Ҫ�ߵ�Ҳ����д������A([1,3,6], [4,3,1,5])��������ʽ
%��ǰ��data.ammoBox1_Size=[0.9,0.7;0.8,0.6;0.7;0.9;0.6;0.8]
data.num_type=length(data.ammoBox1_Size(:,1));
%��ôlength����data.ammoBox1_Size��һ�еĳ��ȣ�data.num_type=4
%%
option.W=ceil(option.arriage_W/option.unit)+1;   % option.W=31
option.L=ceil(option.arriage_L/option.unit)+1;  % option.L=59
data.ammoBox1_Size=ceil(data.ammoBox1_Size/option.unit);  %���յ�data.ammoBox1_Size=[9,7;8,6;7;9;6;8]
%%
%% �㷨����
option.peiod=100 ;  %Maximum Iterations ����������
option.genMax=option.peiod;
option.M=100;         %Population Size ��Ⱥ��
option.popSize=option.M;
option.show_t=1;    %�Ƿ���ʾ��������
option.show_pc=1;   %�Ƿ���ʾ��������ͼ
option.creat_x=@creat_x_1;  %����һ��1��37�еľ���X����X��ÿ��Ԫ�صĴ�С��1234 �ĸ������е�һ������һ��Ⱦɫ�壩
option.by=@bianyi_1;     %����һ��Ⱦɫ���ϵĲ��ֻ�����б��죩
option.p1=0.8;   %������� GA 
option.p2=0.1;   %������� GA
option.p3=0.1;   %�ֱ���� GA 
option.p=option.p3;
option.aimFcn=@aimFcn1;
%%
CityNum = option.max_num;% option.max_num=37
x=zeros(option.popSize,CityNum);%100*37�ľ���
fit=zeros(option.popSize,1);%100*1����Ӧ�Ⱦ���
for i=1:option.popSize
    x(i,:)=option.creat_x(option,data);
    fit(i)=option.aimFcn(x(i,:),option,data); % 100�����壨�⣩��ʣ�µ����
end
data.x=x;
data.fit=fit;
[accord_fit_min,result]=Aga(option,data);
%%
gbest = result.best_x
aimFcn1(gbest,option,data)
drawP(result.best_x,option,data,'���ŷ���')  %���ŷ���
%%
%drawP(x(1),option,data,'���з���')           %���з��� �����޸ķ������������֮��ͼ
%disp('ʣ�����')

toc