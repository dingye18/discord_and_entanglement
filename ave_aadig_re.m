function dy = ave_aadig_re(t,y)
%AVE_AADIG_RE 此处显示有关此函数的摘要
%   
    global data;
    A = data(1);
    B = data(2);
    a = data(3);
    b = data(4);
    k11 = data(5);
    k21 = data(6);
    k12 = data(7);
    k22 = data(8);
    
    
    W32=[a,b/2,b/2,0;b/2,a,0,b/2;b/2,0,a,b/2;0,b/2,b/2,a];
    b = [k11;k21;k12;k22];
    dy = W32*y+b;

end

