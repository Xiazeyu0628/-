function drawP(x,option,data,string)
A=zeros(option.W,option.L);
W = option.W;
L = option.L;
Lm = option.arriage_L;     %车厢
Wm = option.arriage_W;
Box = data.ammoBox1_Size;%Box=[9,7;8,6;7;9;6;8]
BoxNum =size(Box,1);
unit =option.unit;
smallbox = data.ammoBox1_Size*option.unit;
jishu=1;
k=1;
according=[];
color = rand(size(Box,1),3);
figure
hold on;
axis equal

while k < length(x)
    xk = x(k);
    k = k + 1;
    flag = 0;
    % 为减小运算时间，特此处理
    B = 1 - A;   % 空白区域为1，已装箱区域为0
    sb = sum(B); % 每一列的空白宽度
       ir = find( (sb - Box(xk,1))>=0,1);  %至少有一列我能放下吧
    if ~isempty(ir) 
%遍历所有位置点，找能放下这个形状的位置
        for i = 1: W - Box(xk,1) +1 %box=[9,7;8,6;7;9;6;8]
          u = length( find(  A(i,:) ==0) );% 至少有一行我能放下吧
            if u >= Box(xk,2)%如果这个空白长度大于放置的这种箱子的长或者宽（第一维度）
                for j = 1: L- Box(xk,2)+1
                    position = find(A(i:i+Box(xk,1),j:j+Box(xk,2))>0, 1);
                    if isempty(position)
                        flag=1;
                        according=[according,xk];
                        rectangle('Position',([i-1,j-1,Box(xk,1),Box(xk,2)])*unit,'FaceColor',color(xk,:));
                    text(((i+Box(xk,1)/2)-1)*unit,((j+Box(xk,2)/2)-1)*unit,num2str(xk));%
                    drawnow%反复执行plot
                        A(i:i+Box(xk,1)-1,j:j+Box(xk,2)-1) = A(i:i+Box(xk,1)-1,j:j+Box(xk,2)-1)+1;
                        break;
                    end
                end
            end
            if flag==1
                break;
            end
        end
   end
end
% Fx = W * L -sum(sum(A));
Area = 0;
for i = 1:length(according)
    Area = Area + smallbox(according(i),1) * smallbox(according(i),2);
end
Fx = Wm*Lm - Area;
title([string,',剩余面积：',num2str(Fx)])
[0,W-1,0,L-1]*unit % W=31，L=59
axis([0,W-1,0,L-1]*unit)
box on
