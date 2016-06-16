clc
clear all
close all
format short
Real = [4	2	3	3	2	4	2	1	3	3	9	2	6
    4	2	3	3	2	4	2	1	3	3	8	2	6
    4	2	3	3	2	4	2	1	3	3	7	2	6
    4	2	3	3	2	4	2	1	3	3	8	2	2
    4	2	3	3	2	4	2	1	3	3	8	2	6
    4	2	3	3	2	4	2	1	3	3	8	2	5
    4	2	3	3	2	4	1	1	3	3	7	1	6
    4	2	3	3	2	4	2	1	3	4	6	2	6
    4	2	3	3	2	4	2	1	3	3	8	2	6
    4	2	3	3	2	4	2	1	3	3	8	2	5];
BI =   [4	3	3	3	2	3	2	1	3	3	9	2	6
    4	2	3	3	2	4	2	1	3	4	8	2	6
    4	1	2	2	2	4	2	1	3	3	5	2	5
    4	3	3	3	2	4	3	2	3	3	7	2	3
    4	2	3	2	2	4	2	1	3	3	7	2	6
    4	2	3	3	3	4	2	1	2	3	8	2	5
    4	2	3	3	2	4	1	2	2	3	7	2	6
    4	2	2	3	2	4	2	1	3	3	6	2	6
    4	2	3	3	2	4	2	1	2	3	8	2	6
    4	2	3	3	2	5	2	1	3	3	8	2	5];
BW =   [4	2	3	3	2	3	2	1	3	3	9	2	6
    4	2	3	3	2	4	2	1	3	3	8	2	6
    4	1	3	2	2	4	2	1	2	3	7	2	6
    4	2	3	3	2	4	3	2	3	3	7	2	3
    4	2	3	3	2	4	2	1	2	3	8	2	6
    4	2	3	3	2	4	2	1	3	3	8	2	5
    4	2	3	4	2	4	1	1	3	3	6	2	6
    4	2	3	3	2	4	2	1	3	4	6	2	6
    4	2	3	3	2	4	2	1	3	3	8	2	6
    4	2	3	3	2	4	2	1	3	3	8	2	5];

for i = 1:8
    TestW = (BW(Real==i)==i)';
    TestI = (BI(Real==i)==i)';
    Acc0(i,:) = length(TestI);
    AccW(i,:) = sum(TestW);
    AccI(i,:) = sum(TestI);
end
Acc = [AccI AccW Acc0];
Matches = [prod(size(Real)) sum(sum(Real == BI)) sum(sum(Real == BI))+sum(sum(Real == BI-1))+sum(sum(Real == BI+1));
    prod(size(Real)) sum(sum(Real == BW)) sum(sum(Real == BW))+sum(sum(Real == BW-1))+sum(sum(Real == BW+1))]
% Accuracy = Matches(:,2:end)./(0.01*Matches(1,1))
% bar([AccI AccW-AccI Acc0-AccW],'stacked');
% title('Matchings of predicted copy number with the real copy number')
% legend('IM','WIM', 'Real cases')
% xlabel('real copy number'); ylabel('matched cases');
% Genes = ['424';'580';'802';'1644';'2059';'2165';'2461';'2687';'3007';'3690';'4052';'4156';'2163b'];
% set(gca,'XTickLabel',Genes)
% figure(1)
% hold on
% bar(Acc0,'y')
% bar(AccW,'r')
% bar(AccI,'b')
% hold off
bar(Acc)
title('Matching predicted copy number with the real copy number')
legend('IM','WIM', 'Real cases')
xlabel('real copy number'); ylabel('matched cases');