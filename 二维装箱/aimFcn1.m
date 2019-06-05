function Fx=aimFcn1(x,option,data)
A=zeros(option.W,option.L);   %W=31 L=59 31*59的0矩阵
W = option.W;
L = option.L;
Lm = option.arriage_L;     %车厢 5.8
Wm = option.arriage_W;  %3.0
box = data.ammoBox1_Size; 
smallbox = data.ammoBox1_Size*option.unit;
k=1;

according=[];

while k < length(x)  %k<37
    xk = x(k);  %对第K个值操作
    k = k + 1; 
    flag = 0;
    B = 1 - A;   % B矩阵空白区域为1，已装箱区域为0 ——B为整个车厢空白区域的模型
    sb = sum(B); % 车厢内每一列的空白宽度 —sum(B)函数，B矩阵的每一列的值相加   
     ir = find( (sb - box(xk,1))>=0,1);  %至少有一列我能放下吧
     if ~isempty(ir) 
%遍历所有位置点，找能放下这个形状的位置
        for i = 1: W - box(xk,1)+1  %box=[9,7;8,6;7;9;6;8]
          u = length( find(  A(i,:) ==0) );% 至少有一行我能放下吧
            if u >= box(xk,2)%如果这个空白长度大于放置的这种箱子的长或者宽（第一维度）  
                for j = 1:L- box(xk,2)+1
                    position = find( A(i:i+box(xk,1),j:j+box(xk,2))>0, 1 );%在这个形状范围内不能有为1的值（A为1代表被占用区域）
                    if isempty(position) 
                        flag=1;
                        according=[according,xk];
                        A(i:i+box(xk,1)-1,j:j+box(xk,2)-1) = A(i:i+box(xk,1)-1,j:j+box(xk,2)-1)+1;  %A矩阵的这片区域(不包含边)由0变成1
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
for i = 1:length(according)%我放下的个数
    Area = Area + smallbox(according(i),1) * smallbox(according(i),2);
end
Fx = Wm*Lm - Area; %返回的是剩余面积