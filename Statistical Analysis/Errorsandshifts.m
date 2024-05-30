%% calculating errors and shifts
% errors are the difference between actual time of the occurance on an
% event (cue/action/tone) and perceived time of that event
% shifts are the difference between errors in base-line and operant
% conditions

close all
thershold_60=30;

add='C:\Users\a\Desktop\Ahmad\Data\';
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
end

%calculating errors
% base-line conditions
% cue
% all
ind= strcmp(S1.perceive_type,'CUE') & S1.perceived_time ~= -1;
error_cue_baseline_all = S1.perceived_time(ind,1) - S1.C_clock_actual(ind,1);
mean_error_cue_baseline_all = mean(error_cue_baseline_all);
error_cue_baseline_sd_all = std (error_cue_baseline_all);

% without neutral tone
ind= strcmp(S1.perceive_type,'CUE') & S1.perceived_time ~= -1 & S1.NS_clock_actual == -1;
error_cue_baseline_notone = S1.perceived_time(ind,1) - S1.C_clock_actual(ind,1);
mean_error_cue_baseline_notone = mean(error_cue_baseline_notone);
error_cue_baseline_sd_notone = std (error_cue_baseline_notone);

% with neutral tone
ind= strcmp(S1.perceive_type,'CUE') & S1.perceived_time ~= -1 & S1.NS_clock_actual ~= -1;
error_cue_baseline_tone = S1.perceived_time(ind,1) - S1.C_clock_actual(ind,1);
mean_error_cue_baseline_tone = mean(error_cue_baseline_tone);
error_cue_baseline_sd_tone = std (error_cue_baseline_tone);

% action
%all
ind= strcmp(S1.perceive_type,'ACTION') & S1.perceived_time ~= -1;
error_action_baseline_all = S1.perceived_time(ind,1) - S1.A_clock_actual(ind,1);
mean_error_action_baseline_all = mean(error_action_baseline_all);
error_action_baseline_sd_all = std (error_action_baseline_all);

% without neutral tone
ind= strcmp(S1.perceive_type,'ACTION') & S1.perceived_time ~= -1 & S1.NS_clock_actual == -1;
error_action_baseline_notone = S1.perceived_time(ind,1) - S1.C_clock_actual(ind,1);
mean_error_action_baseline_notone = mean(error_action_baseline_notone);
error_action_baseline_sd_notone = std (error_action_baseline_notone);

% with neutral tone
ind= strcmp(S1.perceive_type,'ACTION') & S1.perceived_time ~= -1 & S1.NS_clock_actual ~= -1;
error_action_baseline_tone = S1.perceived_time(ind,1) - S1.C_clock_actual(ind,1);
mean_error_action_baseline_tone = mean(error_action_baseline_tone);
error_action_baseline_sd_tone = std (error_action_baseline_tone);



% tone
ind= strcmp(S1.perceive_type,'STIMULUS') & S1.perceived_time ~= -1;
error_tone_baseline = S1.perceived_time(ind,1) - S1.NS_clock_actual(ind,1);
mean_error_tone_baseline = mean(error_tone_baseline);
error_tone_baseline_sd = std (error_tone_baseline);

% operant conditions
% cue
% all
ind= strcmp(S3.perceive_type,'CUE') & S3.perceived_time ~= -1;
error_cue_operant_all = S3.perceived_time(ind,1) - S3.C_clock_actual(ind,1);
mean_error_cue_operant_all = mean(error_cue_operant_all);
error_cue_operant_sd_all = std (error_cue_operant_all);

% without neutral tone
ind= strcmp(S3.perceive_type,'CUE') & S3.perceived_time ~= -1 & S3.NS_clock_actual == -1;
error_cue_operant_notone = S3.perceived_time(ind,1) - S3.C_clock_actual(ind,1);
mean_error_cue_operant_notone = mean(error_cue_operant_notone);
error_cue_operant_sd_notone = std (error_cue_operant_notone);

% with neutral tone
ind= strcmp(S3.perceive_type,'CUE') & S3.perceived_time ~= -1 & S3.NS_clock_actual ~= -1;
error_cue_operant_tone = S3.perceived_time(ind,1) - S3.C_clock_actual(ind,1);
mean_error_cue_operant_tone = mean(error_cue_operant_tone);
error_cue_operant_sd_tone = std (error_cue_operant_tone);

% action
% all
ind= strcmp(S3.perceive_type,'ACTION') & S3.perceived_time ~= -1;
error_action_operant = S3.perceived_time(ind,1) - S3.A_clock_actual(ind,1);
mean_error_action_operant = mean(error_action_operant);
error_action_operant_sd = std (error_action_operant);

% without neutral tone
ind= strcmp(S1.perceive_type,'ACTION') & S3.perceived_time ~= -1 & S3.NS_clock_actual == -1;
error_action_operant_notone = S3.perceived_time(ind,1) - S3.C_clock_actual(ind,1);
mean_error_action_operant_notone = mean(error_action_operant_notone);
error_action_operant_sd_notone = std (error_action_operant_notone);

% with neutral tone
ind= strcmp(S3.perceive_type,'ACTION') & S3.perceived_time ~= -1 & S3.NS_clock_actual ~= -1;
error_action_operant_tone = S3.perceived_time(ind,1) - S3.C_clock_actual(ind,1);
mean_error_action_operant_tone = mean(error_action_operant_tone);
error_action_operant_sd_tone = std (error_action_operant_tone);

% tone
ind= strcmp(S3.perceive_type,'STIMULUS') & S3.perceived_time ~= -1;
error_tone_operant = S3.perceived_time(ind,1) - S3.NS_clock_actual(ind,1);
mean_error_tone_operant = mean(error_tone_operant);
error_tone_operant_sd = std (error_tone_operant);

% calculating shifts
% cue
%all
cue_shift_all = error_cue_operant_all - error_cue_baseline_all;
cue_sd_change_all = error_cue_operant_sd_all - error_cue_baseline_sd_all;

% without neutral tone
cue_shift_notone = error_cue_operant_notone - error_cue_baseline_notone;
cue_sd_change_notone = error_cue_operant_sd_notone - error_cue_baseline_sd_notone;

% with neutral tone
cue_shift_tone = error_cue_operant_tone - error_cue_baseline_tone;
cue_sd_change_tone = error_cue_operant_sd_tone - error_cue_baseline_sd_tone;

% action
% all
action_shift_all = error_action_operant_all - error_action_baseline_all;
action_sd_change_all = error_action_operant_sd_all - error_action_baseline_sd_all;

% without neutral tone
action_shift_notone = error_action_operant_notone - error_action_baseline_notone;
action_sd_change_notone = error_action_operant_sd_notone - error_action_baseline_sd_notone;

% with neutral tone
action_shift_tone = error_action_operant_tone - error_action_baseline_tone;
action_sd_change_tone = error_action_operant_sd_tone - error_action_baseline_sd_tone;

% tone
tone_shift_all = error_tone_operant - error_tone_baseline;
tone_sd_change_all = error_tone_operant_sd - error_tone_baseline_sd;
