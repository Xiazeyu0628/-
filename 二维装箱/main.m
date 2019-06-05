clc;
clear;
close all
tic %记录时间
%% 问题参数
option.arriage_L=5.8;     %车厢
option.arriage_W=3.0;
option.arriage_H=0.95;
option.unit=0.1;  %单位长度
data.ammoBox1_Size=xlsread('ammoBox_Size.xlsx');
data.ammoBox1_Size=data.ammoBox1_Size(:,2:3); %：表示所有行，逗号之后的2:3表示从列2取到列3，步长为1
temp=data.ammoBox1_Size(:,1).*data.ammoBox1_Size(:,2);
option.max_num=ceil(option.arriage_W*option.arriage_L/min(temp));
%option.max_num=37   
data.ammoBox1_Size=[data.ammoBox1_Size;data.ammoBox1_Size(:,[2,1])];
%那么X=[X; Y] 表示data.ammoBox1_Size储存每一次data.ammoBox1_Size(:,[2,1])的结果，第一次为X=[Y1]， 第二次为X=[Y1; Y2]。。。
%即使提取的行列不连续或者次序需要颠倒也可以写成诸如A([1,3,6], [4,3,1,5])这样的形式
%当前的data.ammoBox1_Size=[0.9,0.7;0.8,0.6;0.7;0.9;0.6;0.8]
data.num_type=length(data.ammoBox1_Size(:,1));
%那么length返回data.ammoBox1_Size第一列的长度，data.num_type=4
%%
option.W=ceil(option.arriage_W/option.unit)+1;   % option.W=31
option.L=ceil(option.arriage_L/option.unit)+1;  % option.L=59
data.ammoBox1_Size=ceil(data.ammoBox1_Size/option.unit);  %最终的data.ammoBox1_Size=[9,7;8,6;7;9;6;8]
%%
%% 算法参数
option.peiod=100 ;  %Maximum Iterations 最大迭代次数
option.genMax=option.peiod;
option.M=100;         %Population Size 种群数
option.popSize=option.M;
option.show_t=1;    %是否显示迭代次数
option.show_pc=1;   %是否显示迭代收敛图
option.creat_x=@creat_x_1;  %产生一个1行37列的矩阵X，且X内每个元素的大小是1234 四个整数中的一个（第一组染色体）
option.by=@bianyi_1;     %（第一组染色体上的部分基因进行变异）
option.p1=0.8;   %变异概率 GA 
option.p2=0.1;   %变异概率 GA
option.p3=0.1;   %灾变概率 GA 
option.p=option.p3;
option.aimFcn=@aimFcn1;
%%
CityNum = option.max_num;% option.max_num=37
x=zeros(option.popSize,CityNum);%100*37的矩阵
fit=zeros(option.popSize,1);%100*1的适应度矩阵
for i=1:option.popSize
    x(i,:)=option.creat_x(option,data);
    fit(i)=option.aimFcn(x(i,:),option,data); % 100个个体（解）的剩下的面积
end
data.x=x;
data.fit=fit;
[accord_fit_min,result]=Aga(option,data);
%%
gbest = result.best_x
aimFcn1(gbest,option,data)
drawP(result.best_x,option,data,'最优方案')  %最优方案
%%
%drawP(x(1),option,data,'可行方案')           %可行方案 自行修改放括号里的数，之后画图
%disp('剩余面积')

toc