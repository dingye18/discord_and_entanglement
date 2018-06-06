function [Discord,Entanglement,ClassicalCorre] = solver( T1,T2 )
%SOLVER 此处显示有关此函数的摘要
%   此处显示详细说明
    
T = 100;

config(T1,T2);

deltaT = 0.01;

alpha1 = 1+4i;
alpha2 = 1+2i;

a1_init = alpha1;
a2_init = alpha2;
a1dag_init = alpha1.';
a2dag_init = alpha2.';
a1_a1dag_init = alpha1*conj(alpha1)+1;
a2_a2dag_init = alpha2*conj(alpha2)+1;
a1dag_a1_init = alpha1*conj(alpha1);
a2dag_a2_init = alpha2*conj(alpha2);
a1_a2dag_init = alpha1*conj(alpha2);
a2_a1dag_init = alpha2*conj(alpha1);
a1_a2_init = alpha1*alpha2;
a1_a1_init = alpha1*alpha1;
a2_a2_init = alpha2*alpha2;
a1dag_a2dag_init = conj(alpha1)*conj(alpha2);


[T_ave_aadag_re,Y_ave_aadag_re] = ode45('ave_aadig_re',[0:deltaT:T],[real(a1_a1dag_init),real(a1_a2dag_init),real(a2_a1dag_init),real(a2_a2dag_init)]);
[T_ave_aadag_img,Y_ave_aadag_img] = ode45('ave_aadig_img',[0:deltaT:T],[imag(a1_a1dag_init),imag(a1_a2dag_init),imag(a2_a1dag_init),imag(a2_a2dag_init)]);
[T_ave_aa_re,Y_ave_aa_re] = ode45('ave_aa_re',[0:deltaT:T],[real(a1_a1_init),real(a2_a2_init),real(a1_a2_init)]);
[T_ave_aa_img,Y_ave_aa_img] = ode45('ave_aa_img',[0:deltaT:T],[imag(a1_a1_init),imag(a2_a2_init),imag(a1_a2_init)]);
[T_ave_a_re,Y_ave_a_re] = ode45('ave_a_re',[0:deltaT:T],[real(a1_init),real(a2_init)]);
[T_ave_a_img,Y_ave_a_img] = ode45('ave_a_img',[0:deltaT:T],[imag(a1_init),imag(a2_init)]);


tmp_a = Y_ave_a_re+Y_ave_a_img*1i;
tmp_aa = Y_ave_aa_re+Y_ave_aa_img*1i;
tmp_aadag = Y_ave_aadag_re+Y_ave_aadag_img*1i;

a1 = tmp_a(:,1);
a2 = tmp_a(:,2);

a1_dag = conj(a1);
a2_dag = conj(a2);

a1a1 = tmp_aa(:,1);
a2a2 = tmp_aa(:,2);
a1a2 = tmp_aa(:,3);

a1_a1dag = tmp_aadag(:,1);
a1_a2dag = tmp_aadag(:,2);
a2_a1dag = tmp_aadag(:,3);
a2_a2dag = tmp_aadag(:,4);

a1dag_a1dag = conj(a1a1);
a1dag_a2 = a2_a1dag;
a1dag_a2dag = conj(a1a2);
a1dag_a1 = a1_a1dag-1;

a2a1 = a1a2;
a2dag_a1 = a1_a2dag;
a2dag_a1dag = a1dag_a2dag;
a2dag_a2 = a2_a2dag - 1;
a2dag_a2dag = conj(a2a2);


save data a1 a2 a1a1 a1a2 a2a2 


L = length(a1);


sigma = zeros(4,4,L);
sigma(1,1,:) = (a1a1 + a1_a1dag + a1dag_a1 + a1dag_a1dag - a1.^2 - 2*a1.*a1_dag - a1_dag.^2);
sigma(1,2,:) = (a1a1 - a1dag_a1dag - a1.^2 + a1_dag.^2)/(1i);
sigma(1,3,:) = (a1a2 + a1_a2dag + a1dag_a2 + a1dag_a2dag - a1.*a2 - a1.*a2_dag - a1_dag.*a2 - a1_dag.*a2_dag);
sigma(1,4,:) = (a1a2 - a1_a2dag + a1dag_a2 - a1dag_a2dag - a1.*a2 + a1.*a2_dag - a1_dag.*a2 + a1_dag.*a2_dag)/(1i);
sigma(2,2,:) = (a1.*a1 - 2*a1.*a1_dag + a1_dag.*a1_dag - a1a1 + a1_a1dag + a1dag_a1 - a1dag_a1dag);
sigma(2,3,:) = (a1a2 + a1_a2dag - a1dag_a2 - a1dag_a2dag - a1.*a2 - a1.*a2_dag + a1_dag.*a2 + a1_dag.*a2_dag)/(1i);
sigma(2,4,:) = (a1.*a2 - a1.*a2_dag - a1_dag.*a2 + a1_dag.*a2_dag - a1a2 + a1_a2dag + a1dag_a2 - a1dag_a2dag);
sigma(3,3,:) = (a2a2 + a2_a2dag + a2dag_a2 + a2dag_a2dag - a2.^2 - 2*a2.*a2_dag - a2_dag.^2);
sigma(3,4,:) = (a2a2 - a2dag_a2dag - a2.^2 + a2_dag.^2)/(1i);
sigma(4,4,:) = (a2.*a2 - 2*a2.*a2_dag + a2_dag.*a2_dag - a2a2 + a2_a2dag + a2dag_a2 - a2dag_a2dag);

sigma(2,1,:) = sigma(1,2,:);
sigma(3,1,:) = sigma(1,3,:);
sigma(4,1,:) = sigma(1,4,:);
sigma(3,2,:) = sigma(2,3,:);
sigma(4,2,:) = sigma(2,4,:);
sigma(4,3,:) = sigma(3,4,:);

save sigma sigma

%%sigma = sigma./2;
%%sigma = sigma*2;

alpha = [sigma(1,1,:),sigma(1,2,:);sigma(2,1,:),sigma(2,2,:)];
beta = [sigma(3,3,:),sigma(3,4,:);sigma(4,3,:),sigma(4,4,:)];
gamma = [sigma(1,3,:),sigma(1,4,:);sigma(2,3,:),sigma(2,4,:)];
gammaTrans = [sigma(3,1,:),sigma(3,2,:);sigma(4,1,:),sigma(4,2,:)];


 alpha(:,:,200:202)
 beta(:,:,200:202)
 gamma(:,:,200:202)
 sigma(:,:,1:1000)

A = [];
B = [];
C = [];
D = [];
Emin = [];
miu_negative = [];
miu_positive = [];
Discord = [];
Entanglement = [];
ClassicalCorre = [];

test1 = [];
test2 = [];

for i = 1:1:L
    A(i) = det(alpha(:,:,i));
    B(i) = det(beta(:,:,i));
    C(i) = det(gamma(:,:,i));
    D(i) = det(sigma(:,:,i));
    
    DELTA_SIGMA = A(i)+B(i)-2*C(i);
    
    DELTA_SIGMA_eigenvalues = A(i)+B(i)+2*C(i);
    
    miu_negative_eigenvalues = sqrt((DELTA_SIGMA_eigenvalues-sqrt(DELTA_SIGMA_eigenvalues^2-4*D(i)))/2);
    miu_positive_eigenvalues = sqrt((DELTA_SIGMA_eigenvalues+sqrt(DELTA_SIGMA_eigenvalues^2-4*D(i)))/2);
    
%     test1(i) = miu_negative_eigenvalues;
%     test2(i) = miu_positive_eigenvalues;
    
    miu_negative(i) = sqrt((DELTA_SIGMA-sqrt(DELTA_SIGMA^2-4*D(i)))/2);
    
    %%miu_positive(i) = sqrt((DELTA_SIGMA+sqrt(DELTA_SIGMA^2-4*D(i)))/2);
    
    Entanglement(i) = max(0,-log(real(miu_negative(i))));
    
    if((D(i)-A(i)*B(i))^2<=(1+B(i))*C(i)^2*(A(i)+D(i)))
        if(-1+B(i)==0)
            Emin(i)=1;
        else
            Emin(i) = (2*C(i)^2+(-1+B(i))*(-A(i)+D(i))+2*abs(C(i))*sqrt(C(i)^2+(-1+B(i))*(-A(i)+D(i))))/((-1+B(i))^2);
        end
        
    else
        Emin(i) = (A(i)*B(i)-C(i)^2+D(i)-sqrt(C(i)^4+(-A(i)*B(i)+D(i))^2-2*C(i)^2*(A(i)*B(i)+D(i))))/(2*B(i));   
    end
    
    Discord(i) = f(sqrt(B(i))) - f(miu_negative_eigenvalues) - f(miu_positive_eigenvalues) + f(sqrt(Emin(i)));
    ClassicalCorre(i) = f(sqrt(B(i)))-f(sqrt(Emin(i)));
end

save miu_negative miu_negative
%%plot(1:10,sigma(3,3,1:10))

%%plot(1:L,Emin)

end

