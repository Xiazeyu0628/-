function x=bianyi_1(x,option,data)
    temp=randi(option.max_num);
     x(temp)=ceil(rand*data.num_type);%���0-1֮�����������xӦ���Ǹ�����
end