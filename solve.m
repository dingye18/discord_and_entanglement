
T1 = 1;
%%T2 = T1:1:30;
T2 = 1;
Discord = [];
Entanglement = [];
ClassicalCorre = [];

for i =1:length(T2)
    [Discord(i,:),Entanglement(i,:),ClassicalCorre(i,:)] = solver(T1,T2(i));
end

%%plot((0.001:0.001:50.001),Emin(1,1:50001))

% for i = 1:50:100
%     plot((1:51),Emin(i,1:51))
%     hold on;  
% end

% for i = 1:1:10
%     plot(T2,Emin(:,i/0.1))
%     hold on;
% end
