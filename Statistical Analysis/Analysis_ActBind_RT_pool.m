% pool analysis

close all
clear all
thershold_60=30;

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
    ind= strcmp(S1.perceive_type,'ACTION') & S1.perceived_time ~= -1 ;
    l=0;
    for j=1:length(ind)
        if ind(j)==1
            ind(j)=0;
            l=l+1;
        end
        if l==5
            break
        end
    end
    diff_ac=S1.A_clock_actual(ind,1)-S1.perceived_time(ind,1);
    diff_ac(abs( diff_ac)>thershold_60)=60-abs( diff_ac(abs( diff_ac)>thershold_60));
    diff_ac_base(:,i-2)= diff_ac;
    RT_base(:,i-2)=S1.TW_A_interval(ind,1);
    diff_ac_base_rt(i-2)=mean(diff_ac_base(RT_base(:,i-2)<1000,i-2));
    num_bas(i-2)=sum(RT_base(:,i-2)<1000);
    
    ind= strcmp(S3.perceive_type,'ACTION') & S3.perceived_time ~= -1 ;
    diff_ac=S3.A_clock_actual(ind,1)-S3.perceived_time(ind,1);
    diff_ac(abs( diff_ac)>thershold_60)=60-abs( diff_ac(abs( diff_ac)>thershold_60));
    diff_ac_cond(:,i-2)=diff_ac;
    RT_cond(:,i-2)=S3.TW_A_interval(ind,1);
    diff_ac_cond_rt(i-2)=mean(diff_ac_cond(RT_cond(:,i-2)<1000,i-2));
    num_cond(i-2)=sum(RT_base(:,i-2)>1000);
    
end


m_base=mean(diff_ac_base_rt);
m_cond=mean(diff_ac_cond_rt);

dif=diff_ac_base_rt-diff_ac_cond_rt;
RT=mean(RT_base);

[r,p]=corr(RT',dif')
%     figure
%     plot(mean((diff_ac_base-diff_ac_cond),2))
[p,t]=ranksum(diff_ac_cond_rt,diff_ac_base_rt)
% xlabel('trial number')
% ylabel('time (s)')
% title('Action binding trend')

% [p,t]=ranksum([mean(diff_ac_cond)],[mean(diff_ac_base)])