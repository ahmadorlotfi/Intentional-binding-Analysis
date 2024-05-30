% calculating intentional-binding

close all
thershold_60=30;
convert_fact=2560/60;

add='';
names=dir(add);

% per subject 
for i=3:length(names)
    
    % Load data sheet 1 (base-line condition)
    [S1]=importfile([add names(i).name],'Condition 1');
    ind=isnan(S1.R_actual);
    S1(ind,:)=[];
    S1.perceived_time=double(string(S1.perceive_type));
    S1.perceive_type=S1.AS_played;
    S1.AS_played=[];
    
    % Load data sheet 3 (operant condition)
    [S3]=importfile([add names(i).name],'Condition 3');
    ind=isnan(S3.R_actual);
    S3(ind,:)=[];
    
    % Calculation Action binding when we have neutral efffect
    ind= strcmp(S1.perceive_type,'ACTION') & S1.perceived_time ~= -1 & S1.NS_clock_actual ~= -1 ;
    diff_ac=S1.A_clock_actual(ind,1)-S1.perceived_time(ind,1);
    diff_ac(abs(diff_ac)>thershold_60)=60-abs(diff_ac(abs(diff_ac)>thershold_60));
    mean_base_act(i-2)=mean(diff_ac);
    
    ind= strcmp(S3.perceive_type,'ACTION') & S3.perceived_time ~= -1 & S3.NS_clock_actual ~= -1 ;
    diff_ac=S3.A_clock_actual(ind,1)-S3.perceived_time(ind,1);
    diff_ac(abs(diff_ac)>thershold_60)=60-abs(diff_ac(abs(diff_ac)>thershold_60));
    mean_cond_act(i-2)=mean(diff_ac);
    
    % calculation effect binding
    ind= strcmp(S1.perceive_type,'STIMULUS') & S1.perceived_time ~= -1  ;
    diff_ac=S1.NS_clock_actual(ind,1)-S1.perceived_time(ind,1);
    diff_ac(abs(diff_ac)>thershold_60)=60-abs(diff_ac(abs(diff_ac)>thershold_60));
    mean_base_eff(i-2)=mean(diff_ac);
    
    ind= strcmp(S3.perceive_type,'STIMULUS') & S3.perceived_time ~= -1 ;
    diff_ac=S3.NS_clock_actual(ind,1)-S3.perceived_time(ind,1);
    diff_ac(abs(diff_ac)>thershold_60)=60-abs(diff_ac(abs(diff_ac)>thershold_60));
    mean_cond_eff(i-2)=mean(diff_ac);


end

% calculating intentianal binding 
mean_cond_int=(-(mean_cond_eff)+ mean_cond_act)*convert_fact;
mean_base_int=(-(mean_base_eff)+ mean_base_act)*convert_fact;


% conditional 

figure
hold on
bar(1,mean(mean_cond_int))
errorbar(1,mean(mean_cond_int),std(mean_cond_int)/sqrt(length(mean_cond_int)))
bar(2,mean(mean_base_int))
errorbar(2,mean(mean_base_int),std(mean_base_int)/sqrt(length(mean_base_int)))
set(gca,'Xtick',[1,2],'Xticklabel',{'Conditional','Baseline'})
set(gca,'Xtick',[1,2],'Xticklabel',{'???????','?? ????'},'tickdir','out')
title('????? ???????')
ylabel('???? (ms)')
set(gcf, 'Units', 'cent', 'Position', [0, 0, 6, 6])

%bassline
[~,p_base]=ttest2(zeros(1,length(mean_base_int)),mean_base_int);

% condition 
[~,p_cond]=ttest2(mean_cond_int,zeros(1,length(mean_cond_int)));


% baseline and condition
% [t,p_base_cond]=ttest2(mean_cond,mean_base)
[t,p]=ranksum(mean_base_int,mean_cond_int);


