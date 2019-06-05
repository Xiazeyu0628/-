% clc;
% clear;
% close all;
function [FG,result]=Aga(option,data)
%% 开始计算
creat_x=option.creat_x;
Fitness=option.aimFcn;
by=option.by;
%NP=NP*2;
%% 遗传算法求解
%% 初始种群生成
X = [data.x];%100*37的矩阵，存放着100组解
fX = [data.fit];%100*1的矩阵，存放着100组解的剩下的面积，这里当作适应度来使用
%% 建立本地种群，实现简单的协同进化
Xp = X;
fXp = fX;
maxgen = option.genMax;%100的最大迭代次数
NP = option.popSize;%100—该种群的数
p1 = option.p1;% 0.8交叉概率 GA 
p2 = option.p2;% 0.1
p3 = option.p3;% 0.1灾变概率 GA 
CityNum = option.max_num;%37
%% 进化开始
for gen = 1 : maxgen
    gen
    %% 交叉
    fmax = max(fX); %最大的剩余面积
    fmin = min(fX);  %最小的剩余面积
    if fmax == fmin
        grade = 0.5 * ones(1,NP);  %1*100的grade矩阵
    else
        p0 = p1 * (1-0.1*gen/maxgen);%交叉概率自适应
        grade = p0 * (fX-fmin)/(fmax-fmin)+0.01;        %极差标准化，使Fx线性映射入0-1的区间内
    end
    %
    jishu1=1;%计数
    jishu2=1;
    position = zeros(NP*2,1);   %200*1的0矩阵
    
    while jishu1 <= NP*2  %计数器1<200
        if grade(jishu2)>=rand%随机生成0-1之间的数  
            position(jishu1)=jishu2;   
            jishu1=jishu1+1;
        end
        jishu2=jishu2+1;
        if jishu2>NP %计数器2>100
            jishu2=1;
            
        end
    end
    Xnew = X;%100*37
    for i = 1 : NP
        temp = randi(CityNum);   %1-37之间的随机数
        Xnew(i,:) = [   X(position(i),1:temp)   ,  X(position(i+NP),temp+1:end)  ]; %随机选择X(rand1)号的1—temp基因，与X(rand2)号的temp—end基因
        %temp_x{i}=correct_x(temp_x{i},option,data);
    end
    %% 变异
    for i=1:ceil(NP*p2*(1+gen/maxgen))%100*0.1*(1+gen/100)  每次变异的基因的个数
        rm = randi(NP);
        Xnew(rm,:)=by(Xnew(rm,:),option,data);
    end
    %% 灾变
    for i=1:ceil(NP * p3)
        rc = randi(NP);
        Xnew(rc,:)=creat_x(option,data);
    end
    %% 重新计算适应度
    fXnew = zeros(NP,1);%100*1的矩阵
    for i = 1 : NP
        fXnew(i) = Fitness(Xnew(i,:),option,data);
    end
    X = [Xp;Xnew];%200*37的矩阵
    fX = [fXp;fXnew];%200*1的剩余面积矩阵
    [~,Idx] = sort(fX);%~代表忽略输出参数，sort代表对FX的各列进行升序，这里取得最小的列的值
    fX = fX(Idx,:);
    X = X(Idx,:);
    
    Xp = X(1:NP,:); %取1-100行，所有列
    fXp = fX(1:NP);
    FM(gen,:) = mean(fXp);
    FG(gen,:) = fXp(1);
    gbest = Xp(1,:);
    fgbest = fXp(1);
end

%%
if option.show_pc
    %% 适应度曲线
    figure
    plot(FG(:,1),'LineWidth',2);
    hold on;
    plot(FM(:,1),'LineWidth',2);
    title('总目标函数适应度曲线');
    legend('最佳适应度','平均适应度');
    xlabel('迭代代数');
    ylabel('适应度值');
end
% %%
result.best_x=gbest;
result.best_fit=fgbest;
% [result.best_fit,result.detail]=aimFcn(result.best_x,option,data);

