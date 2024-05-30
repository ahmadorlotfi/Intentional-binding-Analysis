% pool analysis

close all
clear all
thershold_60=30;
convert_fact=2560/60;

add='C:\Users\Sajjad\Dropbox\Projects\On Going\Ahmad\Data\'
names=dir(add);
% per subject 

for i=3:length(names)
    
    % Load data sheet 1
    [S1]=importfile([add names(i).name],'Condition 1');
    ind=isnan(S1.R_actual);
    S1(ind,:)=[];
    S1.perceived_time=double(string(S1.perceive_type));
    S1.perceive_type=S1.AS_played;
    S1.AS_played=[];
    % Load data sheet 2
    [S3]=importfile([add names(i).name],'Condition 3');
    ind=isnan(S3.R_actual);
    S3(ind,:)=[];
    
    % Calculation Action contidion difference time
    ind= strcmp(S1.perceive_type,'ACTION') & S1.perceived_time ~= -1 & S1.NS_clock_actual ~= -1 ;
    diff_ac=S1.A_clock_actual(ind,1)-S1.perceived_time(ind,1);
    diff_ac(abs(diff_ac)>thershold_60)=60-abs(diff_ac(abs(diff_ac)>thershold_60));
    mean_base(i-2)=mean(diff_ac)*convert_fact;
    
    ind= strcmp(S3.perceive_type,'ACTION') & S3.perceived_time ~= -1 & S3.NS_clock_actual ~= -1 ;
    diff_ac=S3.A_clock_actual(ind,1)-S3.perceived_time(ind,1);
    diff_ac(abs(diff_ac)>thershold_60)=60-abs(diff_ac(abs(diff_ac)>thershold_60));
    mean_cond(i-2)=mean(diff_ac)*convert_fact;

end



% conditional 

figure
hold on
bar(1,mean(mean_cond))
errorbar(1,mean(mean_cond),std(mean_cond)/sqrt(length(mean_cond)))
bar(2,mean(mean_base))
errorbar(2,mean(mean_base),std(mean_base)/sqrt(length(mean_base)))
set(gca,'Xtick',[1,2],'Xticklabel',{'Conditional','Baseline'})
set(gca,'Xtick',[1,2],'Xticklabel',{'???????','?? ????'},'tickdir','out')
title('????? ??? - ????? ?? ?????')
ylabel('???? (ms)')
set(gcf, 'Units', 'cent', 'Position', [0, 0, 6, 6])

%bassline
[~,p_base]=ttest2(zeros(1,length(mean_base)),mean_base)

% condition 
[~,p_cond]=ttest2(mean_cond,zeros(1,length(mean_base)))


% baseline and condition
% [t,p_base_cond]=ttest2(mean_cond,mean_base)
[t,p]=ranksum(mean_cond,mean_base)

