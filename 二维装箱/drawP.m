function drawP(x,option,data,string)
A=zeros(option.W,option.L);
W = option.W;
L = option.L;
Lm = option.arriage_L;     %����
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
    % Ϊ��С����ʱ�䣬�ش˴���
    B = 1 - A;   % �հ�����Ϊ1����װ������Ϊ0
    sb = sum(B); % ÿһ�еĿհ׿��
       ir = find( (sb - Box(xk,1))>=0,1);  %������һ�����ܷ��°�
    if ~isempty(ir) 
%��������λ�õ㣬���ܷ��������״��λ��
        for i = 1: W - Box(xk,1) +1 %box=[9,7;8,6;7;9;6;8]
          u = length( find(  A(i,:) ==0) );% ������һ�����ܷ��°�
            if u >= Box(xk,2)%�������հ׳��ȴ��ڷ��õ��������ӵĳ����߿���һά�ȣ�
                for j = 1: L- Box(xk,2)+1
                    position = find(A(i:i+Box(xk,1),j:j+Box(xk,2))>0, 1);
                    if isempty(position)
                        flag=1;
                        according=[according,xk];
                        rectangle('Position',([i-1,j-1,Box(xk,1),Box(xk,2)])*unit,'FaceColor',color(xk,:));
                    text(((i+Box(xk,1)/2)-1)*unit,((j+Box(xk,2)/2)-1)*unit,num2str(xk));%
                    drawnow%����ִ��plot
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
title([string,',ʣ�������',num2str(Fx)])
[0,W-1,0,L-1]*unit % W=31��L=59
axis([0,W-1,0,L-1]*unit)
box on
