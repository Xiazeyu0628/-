function x=creat_x_1(option,data)
    x=ceil(rand(1,option.max_num)*data.num_type);
    %X = rand(sz1,...,szN) �������������ɵ� sz1��...��szN ���飬���� sz1,...,szN ָʾÿ��ά�ȵĴ�С�����磺rand(3,4) ����һ�� 3��4 �ľ���
    %rand(1,option.max_num)=[ ]1��37��
    %1     1     4     1     4     3     4     1     2     1     4     1     4     4     4     1     2     2     4     2     4     1     2     1     1     4     3     3     1     4     3     2     3     2     1
end