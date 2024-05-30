close all

% per subject 

ind= S1.perceive_type=='ACTION' & S1.perceived_time ~= -1;
diff_ac=S1.A_clock_actual(ind,1)-S1.perceived_time(ind,1);
thershold_60=30;
diff_ac_1=diff_ac;
diff_ac_1(abs(diff_ac)>30)=60-abs(diff_ac(abs(diff_ac)>30));

figure
x=histogram(diff_ac);
title('Basline before correction')
figure
histogram(diff_ac_1,'BinEdges',x.BinEdges);
title('Basline after correction')


baseline=diff_ac_1;


% conditional 
ind= S3.perceive_type=='ACTION' & S3.perceived_time ~= -1;
diff_ac=S3.A_clock_actual(ind,1)-S3.perceived_time(ind,1);
thershold_60=30;
diff_ac_1=diff_ac;
diff_ac_1(abs(diff_ac)>30)=60-abs(diff_ac(abs(diff_ac)>30));

figure
x=histogram(diff_ac);
title('Conditional before correction')

figure
histogram(diff_ac_1,'BinEdges',x.BinEdges);
title('Conditional after correction')

conditional=diff_ac_1;

figure
hold on
bar(1,mean(conditional))
errorbar(1,mean(conditional),std(conditional)/sqrt(length(conditional)))
bar(2,mean(baseline))
errorbar(2,mean(baseline),std(baseline)/sqrt(length(baseline)))
set(gca,'Xtick',[1,2],'Xticklabel',{'Conditional','Baseline'})


[t,p]=ttest2(conditional,baseline)
% [t,p]=ttest2(repmat(conditional,[40,1]),repmat(baseline,[40,1]))

