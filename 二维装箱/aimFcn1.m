function Fx=aimFcn1(x,option,data)
A=zeros(option.W,option.L);   %W=31 L=59 31*59��0����
W = option.W;
L = option.L;
Lm = option.arriage_L;     %���� 5.8
Wm = option.arriage_W;  %3.0
box = data.ammoBox1_Size; 
smallbox = data.ammoBox1_Size*option.unit;
k=1;

according=[];

while k < length(x)  %k<37
    xk = x(k);  %�Ե�K��ֵ����
    k = k + 1; 
    flag = 0;
    B = 1 - A;   % B����հ�����Ϊ1����װ������Ϊ0 ����BΪ��������հ������ģ��
    sb = sum(B); % ������ÿһ�еĿհ׿�� ��sum(B)������B�����ÿһ�е�ֵ���   
     ir = find( (sb - box(xk,1))>=0,1);  %������һ�����ܷ��°�
     if ~isempty(ir) 
%��������λ�õ㣬���ܷ��������״��λ��
        for i = 1: W - box(xk,1)+1  %box=[9,7;8,6;7;9;6;8]
          u = length( find(  A(i,:) ==0) );% ������һ�����ܷ��°�
            if u >= box(xk,2)%�������հ׳��ȴ��ڷ��õ��������ӵĳ����߿���һά�ȣ�  
                for j = 1:L- box(xk,2)+1
                    position = find( A(i:i+box(xk,1),j:j+box(xk,2))>0, 1 );%�������״��Χ�ڲ�����Ϊ1��ֵ��AΪ1����ռ������
                    if isempty(position) 
                        flag=1;
                        according=[according,xk];
                        A(i:i+box(xk,1)-1,j:j+box(xk,2)-1) = A(i:i+box(xk,1)-1,j:j+box(xk,2)-1)+1;  %A�������Ƭ����(��������)��0���1
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
for i = 1:length(according)%�ҷ��µĸ���
    Area = Area + smallbox(according(i),1) * smallbox(according(i),2);
end
Fx = Wm*Lm - Area; %���ص���ʣ�����