function  config(T1,T2)
%CONFIG 此处显示有关此函数的摘要
%   此处显示详细说明
    omega = 2.0;
    beta = 0.1;
    gamma1 = 1.0;
    gamma2 = 1.0;
    omega_plus = omega+beta;
    omega_reduce = omega-beta;
%     T1 = T1;
%     T2 = 700;
    n1_plus = 1/(exp(omega_plus/T1)-1);
    n1_reduce = 1/(exp(omega_reduce/T1)-1);
    n2_plus = 1/(exp(omega_plus/T2)-1);
    n2_reduce = 1/(exp(omega_reduce/T2)-1);
    
    A = omega;
    B = beta;
    a = -(gamma1+gamma2+gamma1+gamma2)/2;
    b = (gamma1+gamma2-gamma1-gamma2)/2;
    
    K11_E = (gamma1*(n1_plus+1)+gamma2*(n2_plus+1)+gamma1*(n1_reduce+1)+gamma2*(n2_reduce+1))/2;
    K22_E = K11_E;
    
    K12_E = (gamma1*(n1_plus+1)+gamma2*(n2_plus+1)-gamma1*(n1_reduce+1)-gamma2*(n2_reduce+1))/2;
    K21_E = K12_E;
    
    global data
    
    data = [A,B,a,b,K11_E,K21_E,K12_E,K22_E];

end

