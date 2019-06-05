% clc;
% clear;
% close all;
function [FG,result]=Aga(option,data)
%% ��ʼ����
creat_x=option.creat_x;
Fitness=option.aimFcn;
by=option.by;
%NP=NP*2;
%% �Ŵ��㷨���
%% ��ʼ��Ⱥ����
X = [data.x];%100*37�ľ��󣬴����100���
fX = [data.fit];%100*1�ľ��󣬴����100����ʣ�µ���������ﵱ����Ӧ����ʹ��
%% ����������Ⱥ��ʵ�ּ򵥵�Эͬ����
Xp = X;
fXp = fX;
maxgen = option.genMax;%100������������
NP = option.popSize;%100������Ⱥ����
p1 = option.p1;% 0.8������� GA 
p2 = option.p2;% 0.1
p3 = option.p3;% 0.1�ֱ���� GA 
CityNum = option.max_num;%37
%% ������ʼ
for gen = 1 : maxgen
    gen
    %% ����
    fmax = max(fX); %����ʣ�����
    fmin = min(fX);  %��С��ʣ�����
    if fmax == fmin
        grade = 0.5 * ones(1,NP);  %1*100��grade����
    else
        p0 = p1 * (1-0.1*gen/maxgen);%�����������Ӧ
        grade = p0 * (fX-fmin)/(fmax-fmin)+0.01;        %�����׼����ʹFx����ӳ����0-1��������
    end
    %
    jishu1=1;%����
    jishu2=1;
    position = zeros(NP*2,1);   %200*1��0����
    
    while jishu1 <= NP*2  %������1<200
        if grade(jishu2)>=rand%�������0-1֮�����  
            position(jishu1)=jishu2;   
            jishu1=jishu1+1;
        end
        jishu2=jishu2+1;
        if jishu2>NP %������2>100
            jishu2=1;
            
        end
    end
    Xnew = X;%100*37
    for i = 1 : NP
        temp = randi(CityNum);   %1-37֮��������
        Xnew(i,:) = [   X(position(i),1:temp)   ,  X(position(i+NP),temp+1:end)  ]; %���ѡ��X(rand1)�ŵ�1��temp������X(rand2)�ŵ�temp��end����
        %temp_x{i}=correct_x(temp_x{i},option,data);
    end
    %% ����
    for i=1:ceil(NP*p2*(1+gen/maxgen))%100*0.1*(1+gen/100)  ÿ�α���Ļ���ĸ���
        rm = randi(NP);
        Xnew(rm,:)=by(Xnew(rm,:),option,data);
    end
    %% �ֱ�
    for i=1:ceil(NP * p3)
        rc = randi(NP);
        Xnew(rc,:)=creat_x(option,data);
    end
    %% ���¼�����Ӧ��
    fXnew = zeros(NP,1);%100*1�ľ���
    for i = 1 : NP
        fXnew(i) = Fitness(Xnew(i,:),option,data);
    end
    X = [Xp;Xnew];%200*37�ľ���
    fX = [fXp;fXnew];%200*1��ʣ���������
    [~,Idx] = sort(fX);%~����������������sort�����FX�ĸ��н�����������ȡ����С���е�ֵ
    fX = fX(Idx,:);
    X = X(Idx,:);
    
    Xp = X(1:NP,:); %ȡ1-100�У�������
    fXp = fX(1:NP);
    FM(gen,:) = mean(fXp);
    FG(gen,:) = fXp(1);
    gbest = Xp(1,:);
    fgbest = fXp(1);
end

%%
if option.show_pc
    %% ��Ӧ������
    figure
    plot(FG(:,1),'LineWidth',2);
    hold on;
    plot(FM(:,1),'LineWidth',2);
    title('��Ŀ�꺯����Ӧ������');
    legend('�����Ӧ��','ƽ����Ӧ��');
    xlabel('��������');
    ylabel('��Ӧ��ֵ');
end
% %%
result.best_x=gbest;
result.best_fit=fgbest;
% [result.best_fit,result.detail]=aimFcn(result.best_x,option,data);

