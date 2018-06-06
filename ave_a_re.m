function dy = ave_a_re( t,y )
%AVE_A_RE 此处显示有关此函数的摘要
%   此处显示详细说明
    global data;
    A = data(1);
    B = data(2);
    a = data(3);
    b = data(4);
    
    W12=[a/2,b/2;b/2,a/2];
    dy = W12*y;

end

