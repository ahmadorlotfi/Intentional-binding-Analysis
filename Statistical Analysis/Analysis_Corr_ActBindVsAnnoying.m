% calculating the correlation of action-binding in participants and their
% perceived rating of the annoting stimulus

close all
% clear all
thershold_60=30;
convert_fact=2560/60;
add='';

names=dir(add);
% per subject 
Ann=[];
for i=3:length(names)
    
        % Load data sheet 0
    [S0]=importfile([add names(i).name],'info');
    Ann=[Ann S0.R_actual(2)];
    
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
    ind= strcmp(S1.perceive_type,'ACTION') & S1.perceived_time ~= -1  ;
    diff_ac=S1.A_clock_actual(ind,1)-S1.perceived_time(ind,1);
    diff_ac(abs(diff_ac)>thershold_60)=60-abs(diff_ac(abs(diff_ac)>thershold_60));
    mean_base(i-2)=mean(diff_ac)*convert_fact;
    

    
    ind= strcmp(S3.perceive_type,'ACTION') & S3.perceived_time ~= -1 ;
    diff_ac=S3.A_clock_actual(ind,1)-S3.perceived_time(ind,1);
    diff_ac(abs(diff_ac)>thershold_60)=60-abs(diff_ac(abs(diff_ac)>thershold_60));
    mean_cond(i-2)=mean(diff_ac)*convert_fact;

end

% out_layer_fact_l=mean(mean_base)-2*std(mean_base);
% out_layer_fact_h=mean(mean_base)+2*std(mean_base);
% 
% ind=mean_base>out_layer_fact_l & mean_base<out_layer_fact_h
% 
% out_layer_fact_l=mean(mean_cond)-2*std(mean_cond);
% out_layer_fact_h=mean(mean_cond)+2*std(mean_cond);
% 
% ind=mean_cond>out_layer_fact_l & mean_cond<out_layer_fact_h

ind=~isnan(Ann);
histogram(Ann(ind))
title('???? ????? ????? ???? ??????')
ylabel('????? ?????')
xlabel('????? ??????????')
mean(Ann(ind))
std(Ann(ind))
% conditional 

Ann_norm=Ann(ind)/max(Ann(ind))
cond_norm=(mean_cond(ind)-mean_base(ind))/max(mean_cond(ind)-mean_base(ind))
[p,cor]=corr(Ann_norm',cond_norm')


plot(Ann_norm',cond_norm','*')
ylabel('????? ???')
xlabel('???? ??????')
title('???????')
set(gcf, 'Units', 'cent', 'Position', [0, 0, 6, 6])
