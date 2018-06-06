function dy = ave_a_img(t,y)
%ave_a_img <a*row>
%   
    global data;
    A = data(1);
    B = data(2);
    a = data(3);
    b = data(4);
    

    W11=[-A,-B;-B,-A];
    dy = W11*y;
    
end

