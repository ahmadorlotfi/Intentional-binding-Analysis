% pool analysis

close all
clear all
thershold_60=30;
convert_fact=2560/60;

add='C:\New folder\Document\Master of Science\Thesis\Text\Ahmad\Data\'
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
    ind= strcmp(S1.perceive_type,'CUE') & S1.perceived_time ~= -1  ;
    diff_ac=S1.C_clock_actual(ind,1)-S1.perceived_time(ind,1);
    diff_ac(abs(diff_ac)>thershold_60)=60-abs(diff_ac(abs(diff_ac)>thershold_60));
    mean_base_cue(i-2)=mean(diff_ac);
    
   
    ind= strcmp(S3.perceive_type,'CUE') & S3.perceived_time ~= -1 ;
    diff_ac=S3.C_clock_actual(ind,1)-S3.perceived_time(ind,1);
    diff_ac(abs(diff_ac)>thershold_60)=60-abs(diff_ac(abs(diff_ac)>thershold_60));
    mean_cond_cue(i-2)=mean(diff_ac);
    
    
        % Calculation Action contidion difference time
    ind= strcmp(S1.perceive_type,'ACTION') & S1.perceived_time ~= -1  ;
    diff_ac=S1.A_clock_actual(ind,1)-S1.perceived_time(ind,1);
    diff_ac(abs(diff_ac)>thershold_60)=60-abs(diff_ac(abs(diff_ac)>thershold_60));
    mean_base_act(i-2)=mean(diff_ac);
    
    ind= strcmp(S3.perceive_type,'ACTION') & S3.perceived_time ~= -1 ;
    diff_ac=S3.A_clock_actual(ind,1)-S3.perceived_time(ind,1);
    diff_ac(abs(diff_ac)>thershold_60)=60-abs(diff_ac(abs(diff_ac)>thershold_60));
    mean_cond_act(i-2)=mean(diff_ac);

end

mean_cue_act_cond=((mean_cond_act)-(mean_cond_cue))*convert_fact;
mean_cue_act_base=((mean_base_act)-(mean_base_cue))*convert_fact;


% conditional 

figure
hold on
bar(1,mean(mean_cue_act_cond))
errorbar(1,mean(mean_cue_act_cond),std(mean_cue_act_cond)/sqrt(length(mean_cue_act_cond)))
bar(2,mean(mean_cue_act_base))
errorbar(2,mean(mean_cue_act_base),std(mean_cue_act_base)/sqrt(length(mean_cue_act_base)))
set(gca,'Xtick',[1,2],'Xticklabel',{'Conditional','Baseline'})
set(gca,'Xtick',[1,2],'Xticklabel',{'???????','?? ????'},'tickdir','out')
title('????? ?????-???')
ylabel('???? (ms)')
set(gcf, 'Units', 'cent', 'Position', [0, 0, 6, 6])

%bassline
[~,p_base]=ttest2(zeros(1,length(mean_cue_act_base)),mean_cue_act_base)

% condition 
[~,p_cond]=ttest2(mean_cue_act_cond,zeros(1,length(mean_cue_act_cond)))


% baseline and condition
% [t,p_base_cond]=ttest2(mean_cue_act_cond,mean_cue_act_base)
[t,p_base_cond]=ranksum(mean_cue_act_cond,mean_cue_act_base)

