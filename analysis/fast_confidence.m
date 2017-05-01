%% fast confidence plots

Faces = individual_analysis(1,0,0);
Disks = individual_analysis(0,1,0);

saveplace = '../figures/Manuscript_figure_2/confidence_subjects/';

CST_col = [5 113 176]./255;
PST_col = [146 197 222]./255;
TAt_col = [202 0 32]./255;
TAa_col = [244 165 130]./255;

coord = [1100 100 1200 400];

%% ANALYSIS OF DIFFERENCE

% Faces
SCs = (mean(mean(abs(Faces.confidence.SC))));
SPs = (mean(mean(abs(Faces.confidence.SP))));
SCs = SCs(:); SPs = SPs(:);
STs = mean([SCs SPs],2);

DCs = (mean(mean(abs(Faces.confidence.DC))));
DPs = (mean(mean(abs(Faces.confidence.DP))));
DCs = DCs(:); DPs = DPs(:);
DTs = mean([DCs DPs],2);

fconfid_diff = STs - DTs;

% Disks
SCs = (mean(mean(abs(Disks.confidence.SC))));
SPs = (mean(mean(abs(Disks.confidence.SP))));
SCs = SCs(:); SPs = SPs(:);
STs = mean([SCs SPs],2);

DCs = (mean(mean(abs(Disks.confidence.DC))));
DPs = (mean(mean(abs(Disks.confidence.DP))));
DCs = DCs(:); DPs = DPs(:);
DTs = mean([DCs DPs],2);

dconfid_diff = STs - DTs;

plot_diff = [fconfid_diff dconfid_diff];

% Make gaussian
% a = -2; b = 2;
% x = a + (b-a) * rand(1, 50000);
% m_face = mean(plot_diff(:,1));
% s_face = std(plot_diff(:,1)); 
% 
% m_disk = mean(plot_diff(:,2));
% s_disk = std(plot_diff(:,2)); 
% 
% f_face = gauss_distribution(x,m_face,s_face);
% f_disk = gauss_distribution(x,m_disk,s_disk);

a = -2; b = 2;
x = a + (b-a) * rand(1, 50000);
m_all = mean(plot_diff(:));
s_all = std(plot_diff(:)); 

f_all = gauss_distribution(x,m_all,s_all);

% Plot 'em

figure

set(gcf,'Position',coord)

line([0 0],[0 10],'LineStyle','-','Color','k','LineWidth',1);
hold on
hist(plot_diff,30)

line([mean(plot_diff(:,1)) mean(plot_diff(:,1))],[0 10],'LineStyle','-','Color','b','LineWidth',2);
line([mean(plot_diff(:,2)) mean(plot_diff(:,2))],[0 10],'LineStyle','-','Color','r','LineWidth',2);

line([mean(plot_diff(:)) mean(plot_diff(:))],[0 10],'LineStyle','-','Color','g','LineWidth',2);

% line([mean(plot_diff(:,1))+2*std(plot_diff(:,1)) mean(plot_diff(:,1))+2*std(plot_diff(:,1))]...
%     ,[0 15],'LineStyle',':','Color','b','LineWidth',1);
% line([mean(plot_diff(:,2))+2*std(plot_diff(:,2)) mean(plot_diff(:,2))+2*std(plot_diff(:,2))]...
%     ,[0 15],'LineStyle',':','Color','r','LineWidth',1);
% 
% line([mean(plot_diff(:,1))-2*std(plot_diff(:,1)) mean(plot_diff(:,1))-2*std(plot_diff(:,1))]...
%     ,[0 15],'LineStyle',':','Color','b','LineWidth',1);
% line([mean(plot_diff(:,2))-2*std(plot_diff(:,2)) mean(plot_diff(:,2))-2*std(plot_diff(:,2))]...
%     ,[0 15],'LineStyle',':','Color','r','LineWidth',1);

line([mean(plot_diff(:))+3*std(plot_diff(:)) mean(plot_diff(:))+3*std(plot_diff(:))]...
    ,[0 15],'LineStyle',':','Color','k','LineWidth',2);
line([mean(plot_diff(:))-3*std(plot_diff(:)) mean(plot_diff(:))-3*std(plot_diff(:))]...
    ,[0 15],'LineStyle',':','Color','k','LineWidth',2);

% plot(x,f_face,'b.','MarkerSize',5)
% plot(x,f_disk,'r.','MarkerSize',5)

plot(x,f_all,'g.','MarkerSize',5)

h = findobj(gca,'Type','patch');

set(h,'LineStyle','none')

legend(h,{'Disks' 'Gender'},'FontSize',20)
legend('boxoff')

xlim([-.2 2])
ylim([0 5.5])
set(gca,'TickDir','out','FontSize',16)
xlabel('mean(ST)-mean(DT)','FontSize',20)
ylabel('Frequency','FontSize',20)

box off

title('Difference mean(Confidence)','FontSize',24)

original_dir = pwd;
cd(saveplace)
naming = 'confidence_comparison_means';

saveas(gcf,naming,'png')
print(naming,'-depsc');

cd(original_dir)

%% ANALYSIS DIFFERENCE VARIANCE
% Faces
SCs = (std(std(abs(Faces.confidence.SC))));
SPs = (std(std(abs(Faces.confidence.SP))));
SCs = SCs(:); SPs = SPs(:);
STs = std([SCs SPs],0,2);

DCs = (std(std(abs(Faces.confidence.DC))));
DPs = (std(std(abs(Faces.confidence.DP))));
DCs = DCs(:); DPs = DPs(:);
DTs = std([DCs DPs],0,2);

fconfid_diff = STs - DTs;

% Disks
SCs = (std(std(abs(Disks.confidence.SC))));
SPs = (std(std(abs(Disks.confidence.SP))));
SCs = SCs(:); SPs = SPs(:);
STs = std([SCs SPs],0,2);

DCs = (std(std(abs(Disks.confidence.DC))));
DPs = (std(std(abs(Disks.confidence.DP))));
DCs = DCs(:); DPs = DPs(:);
DTs = std([DCs DPs],0,2);

dconfid_diff = STs - DTs;

plot_diff = [fconfid_diff dconfid_diff];

% Make gaussian
a = -.15; b = .15;

x = a + (b-a) * rand(1, 50000);
m_face = mean(plot_diff(:,1));
s_face = std(plot_diff(:,1)); 

% m_disk = mean(plot_diff(:,2));
% s_disk = std(plot_diff(:,2)); 
% 
% f_face = gauss_distribution(x,m_face,s_face);
% f_disk = gauss_distribution(x,m_disk,s_disk);

m_all = mean(plot_diff(:));
s_all = std(plot_diff(:));

f_all = gauss_distribution(x,m_all,s_all);

% Plot 'em

figure

set(gcf,'Position',coord)

line([0 0],[0 15],'LineStyle','-','Color','k','LineWidth',1);
hold on
hist(plot_diff,20)

line([mean(plot_diff(:,1)) mean(plot_diff(:,1))],[0 15],'LineStyle','-','Color','b','LineWidth',1);
line([mean(plot_diff(:,2)) mean(plot_diff(:,2))],[0 15],'LineStyle','-','Color','r','LineWidth',1);

% line([mean(plot_diff(:,1))+2*std(plot_diff(:,1)) mean(plot_diff(:,1))+2*std(plot_diff(:,1))]...
%     ,[0 15],'LineStyle',':','Color','b','LineWidth',1);
% line([mean(plot_diff(:,2))+2*std(plot_diff(:,2)) mean(plot_diff(:,2))+2*std(plot_diff(:,2))]...
%     ,[0 15],'LineStyle',':','Color','r','LineWidth',1);
% 
% line([mean(plot_diff(:,1))-2*std(plot_diff(:,1)) mean(plot_diff(:,1))-2*std(plot_diff(:,1))]...
%     ,[0 15],'LineStyle',':','Color','b','LineWidth',1);
% line([mean(plot_diff(:,2))-2*std(plot_diff(:,2)) mean(plot_diff(:,2))-2*std(plot_diff(:,2))]...
%     ,[0 15],'LineStyle',':','Color','r','LineWidth',1);

line([mean(plot_diff(:))+3*std(plot_diff(:)) mean(plot_diff(:))+3*std(plot_diff(:))]...
    ,[0 15],'LineStyle',':','Color','k','LineWidth',2);
line([mean(plot_diff(:))-3*std(plot_diff(:)) mean(plot_diff(:))-3*std(plot_diff(:))]...
    ,[0 15],'LineStyle',':','Color','k','LineWidth',2);

% plot(x,f_face,'b.','MarkerSize',5)
% plot(x,f_disk,'r.','MarkerSize',5)

plot(x,f_all,'g.','MarkerSize',5)

h = findobj(gca,'Type','patch');

set(h,'LineStyle','none')

legend(h,{'Disks' 'Gender'},'FontSize',20)
legend('boxoff')

ylim([0 12])
xlim([-.08 .11])
% set(gca,'YTick',0:1:4)
set(gca,'TickDir','out','FontSize',16)
xlabel('std(ST)-std(DT)','FontSize',20)
ylabel('Frequency','FontSize',20)

box off

title('Difference std(Confidence)','FontSize',24)

original_dir = pwd;
cd(saveplace)
naming = 'confidence_comparison_stds';

saveas(gcf,naming,'png')
print(naming,'-depsc');

cd(original_dir)

%% PER SUBJECT/EXPERIMENT CONFIDENCE PLOTS
% Faces

SCf_confid_block = zeros(8,8);
SPf_confid_block = zeros(8,8);
DCf_confid_block = zeros(8,8);
DPf_confid_block = zeros(8,8);

SCd_confid_block = zeros(8,8);
SPd_confid_block = zeros(8,8);
DCd_confid_block = zeros(8,8);
DPd_confid_block = zeros(8,8);
PDCd_confid_block = zeros(8,8);
PDPd_confid_block = zeros(8,8);

for sub = 1:8
    for block = 1:8
        SCf_confid_block(sub,block) = mean(abs(Faces.confidence.SC(:,block,sub)));
        SPf_confid_block(sub,block) = mean(abs(Faces.confidence.SP(:,block,sub)));
        DCf_confid_block(sub,block) = mean(abs(Faces.confidence.DC(:,block,sub)));
        DPf_confid_block(sub,block) = mean(abs(Faces.confidence.DP(:,block,sub)));
        
        SCd_confid_block(sub,block) = mean(abs(Disks.confidence.SC(:,block,sub)));
        SPd_confid_block(sub,block) = mean(abs(Disks.confidence.SP(:,block,sub)));
        DCd_confid_block(sub,block) = mean(abs(Disks.confidence.DC(:,block,sub)));
        DPd_confid_block(sub,block) = mean(abs(Disks.confidence.DP(:,block,sub)));
        PDCd_confid_block(sub,block) = mean(abs(Disks.confidence.PDC(:,block,sub)));
        PDPd_confid_block(sub,block) = mean(abs(Disks.confidence.PDP(:,block,sub)));
    end
end

% Compute means

yf = [mean(SCf_confid_block,2) mean(SPf_confid_block,2) mean(DCf_confid_block,2) mean(DPf_confid_block,2)];
sf = [std(SCf_confid_block,0,2) std(SPf_confid_block,0,2) std(DCf_confid_block,0,2) std(DPf_confid_block,0,2)]./sqrt(8);

yd = [mean(SCd_confid_block,2) mean(SPd_confid_block,2) mean(DCd_confid_block,2) mean(DPd_confid_block,2)...
    mean(PDCd_confid_block,2) mean(PDPd_confid_block,2)];
sd = [std(SCd_confid_block,0,2) std(SPd_confid_block,0,2) std(DCd_confid_block,0,2) std(DPd_confid_block,0,2)...
    std(PDCd_confid_block,0,2) std(PDPd_confid_block,0,2)]./sqrt(8);

%% GENDER PLOT

figure

set(gcf,'Position',coord)

[h,errh] = barwitherr(sf,yf);
set(errh,'LineWidth',2)
set(h,'LineStyle','none','BarWidth',1)

set(h(1),'FaceColor',CST_col)
set(h(2),'FaceColor',PST_col)
set(h(3),'FaceColor',TAa_col./1.7)
set(h(4),'FaceColor',TAa_col./1.1)

legend(h,{'SC' 'SP' 'DC' 'DP'},'FontSize',20)
legend('boxoff')

ylim([0.75 4.25])
set(gca,'YTick',0:1:4)
set(gca,'TickDir','out','FontSize',16)
xlabel('Subject','FontSize',20)
ylabel('Confidence','FontSize',20)

box off

title('Confidence Summary: Gender','FontSize',24)

original_dir = pwd;
cd(saveplace)
naming = 'gender_confidence_comparison';

saveas(gcf,naming,'png')
print(naming,'-depsc');

cd(original_dir)

%% DISK PLOT

figure

set(gcf,'Position',coord)

[h,errh] = barwitherr(sd,yd);
set(errh,'LineWidth',2)
set(h,'LineStyle','none','BarWidth',1)

set(h(1),'FaceColor',CST_col)
set(h(2),'FaceColor',PST_col)
set(h(3),'FaceColor',TAa_col./1.7)
set(h(4),'FaceColor',TAa_col./1.1)
set(h(5),'FaceColor',CST_col+TAt_col-.3)
set(h(6),'FaceColor',CST_col+TAt_col)

legend(h,{'SC' 'SP' 'DC' 'DP' 'PDC' 'PDP'},'FontSize',20)
legend('boxoff')

ylim([0.75 4.25])
set(gca,'YTick',0:1:4)
set(gca,'TickDir','out','FontSize',16)
xlabel('Subject','FontSize',20)
ylabel('Confidence','FontSize',20)

box off

title('Confidence Summary: Disks','FontSize',24)

original_dir = pwd;
cd(saveplace)
naming = 'disk_confidence_comparison';

saveas(gcf,naming,'png')
print(naming,'-depsc');

cd(original_dir)

%% PER SUBJECT/TASK CONFIDENCE SUMMARY PLOTS

SCf_confid_block = zeros(8,8);
SPf_confid_block = zeros(8,8);
DCf_confid_block = zeros(8,8);
DPf_confid_block = zeros(8,8);

SCd_confid_block = zeros(8,8);
SPd_confid_block = zeros(8,8);
DCd_confid_block = zeros(8,8);
DPd_confid_block = zeros(8,8);
PDCd_confid_block = zeros(8,8);
PDPd_confid_block = zeros(8,8);

for sub = 1:8
    for block = 1:8
        SCf_confid_block(sub,block) = mean(abs(Faces.confidence.SC(:,block,sub)));
        SPf_confid_block(sub,block) = mean(abs(Faces.confidence.SP(:,block,sub)));
        DCf_confid_block(sub,block) = mean(abs(Faces.confidence.DC(:,block,sub)));
        DPf_confid_block(sub,block) = mean(abs(Faces.confidence.DP(:,block,sub)));
        
        SCd_confid_block(sub,block) = mean(abs(Disks.confidence.SC(:,block,sub)));
        SPd_confid_block(sub,block) = mean(abs(Disks.confidence.SP(:,block,sub)));
        DCd_confid_block(sub,block) = mean(abs(Disks.confidence.DC(:,block,sub)));
        DPd_confid_block(sub,block) = mean(abs(Disks.confidence.DP(:,block,sub)));
        PDCd_confid_block(sub,block) = mean(abs(Disks.confidence.PDC(:,block,sub)));
        PDPd_confid_block(sub,block) = mean(abs(Disks.confidence.PDP(:,block,sub)));
    end
end

% Compute means

yf = [mean(SCf_confid_block,2) mean(SPf_confid_block,2) mean(DCf_confid_block,2) mean(DPf_confid_block,2)];
yf = [mean(yf(:,1:2),2) mean(yf(:,3:4),2)];

sf = [std(SCf_confid_block,0,2) std(SPf_confid_block,0,2) std(DCf_confid_block,0,2) std(DPf_confid_block,0,2)]./sqrt(8);
sf = [mean(sf(:,1:2),2) mean(sf(:,3:4),2)];

yd = [mean(SCd_confid_block,2) mean(SPd_confid_block,2) mean(DCd_confid_block,2) mean(DPd_confid_block,2)...
    mean(PDCd_confid_block,2) mean(PDPd_confid_block,2)];
yd = [mean(yd(:,1:2),2) mean(yd(:,3:4),2) mean(yd(:,5:6),2)];

sd = [std(SCd_confid_block,0,2) std(SPd_confid_block,0,2) std(DCd_confid_block,0,2) std(DPd_confid_block,0,2)...
    std(PDCd_confid_block,0,2) std(PDPd_confid_block,0,2)]./sqrt(8);
sd = [mean(sd(:,1:2),2) mean(sd(:,3:4),2) mean(sd(:,5:6),2)];

%% GENDER PLOT

figure

set(gcf,'Position',coord)

[h,errh] = barwitherr(sf,yf);
set(errh,'LineWidth',2)
set(h,'LineStyle','none','BarWidth',1)

set(h(1),'FaceColor',mean([CST_col ; PST_col]))
set(h(2),'FaceColor',mean([TAa_col./1.7 ; TAa_col./1.1]))

legend(h,{'ST' 'DT'},'FontSize',20)
legend('boxoff')

ylim([0.75 4.25])
set(gca,'YTick',0:1:4)
set(gca,'TickDir','out','FontSize',16)
xlabel('Subject','FontSize',20)
ylabel('Confidence','FontSize',20)

box off

title('Confidence Summary Task: Gender','FontSize',24)

original_dir = pwd;
cd(saveplace)
naming = 'gender_confidence_comparison_task';

saveas(gcf,naming,'png')
print(naming,'-depsc');

cd(original_dir)

%% DISK PLOT

figure

set(gcf,'Position',coord)

[h,errh] = barwitherr(sd,yd);
set(errh,'LineWidth',2)
set(h,'LineStyle','none','BarWidth',1)

set(h(1),'FaceColor',mean([CST_col ; PST_col]))
set(h(2),'FaceColor',mean([TAa_col./1.7 ; TAa_col./1.1]))
set(h(3),'FaceColor',mean([CST_col+TAt_col-.3 ; CST_col+TAt_col]))

legend(h,{'ST' 'DT' 'PDT'},'FontSize',20)
legend('boxoff')

ylim([0.75 4.25])
set(gca,'YTick',0:1:4)
set(gca,'TickDir','out','FontSize',16)
xlabel('Subject','FontSize',20)
ylabel('Confidence','FontSize',20)

box off

title('Confidence Summary Task: Disks','FontSize',24)

original_dir = pwd;
cd(saveplace)
naming = 'disk_confidence_comparison_task';

saveas(gcf,naming,'png')
print(naming,'-depsc');

cd(original_dir)


%% PER SUBJECT/EXPERIMENT CONFIDENCE PLOTS
% STANDARD DEVIATIONS

SCf_confid_block = zeros(8,8);
SPf_confid_block = zeros(8,8);
DCf_confid_block = zeros(8,8);
DPf_confid_block = zeros(8,8);

SCd_confid_block = zeros(8,8);
SPd_confid_block = zeros(8,8);
DCd_confid_block = zeros(8,8);
DPd_confid_block = zeros(8,8);
PDCd_confid_block = zeros(8,8);
PDPd_confid_block = zeros(8,8);

for sub = 1:8
    for block = 1:8
        SCf_confid_block(sub,block) = std(abs(Faces.confidence.SC(:,block,sub)));
        SPf_confid_block(sub,block) = std(abs(Faces.confidence.SP(:,block,sub)));
        DCf_confid_block(sub,block) = std(abs(Faces.confidence.DC(:,block,sub)));
        DPf_confid_block(sub,block) = std(abs(Faces.confidence.DP(:,block,sub)));
        
        SCd_confid_block(sub,block) = std(abs(Disks.confidence.SC(:,block,sub)));
        SPd_confid_block(sub,block) = std(abs(Disks.confidence.SP(:,block,sub)));
        DCd_confid_block(sub,block) = std(abs(Disks.confidence.DC(:,block,sub)));
        DPd_confid_block(sub,block) = std(abs(Disks.confidence.DP(:,block,sub)));
        PDCd_confid_block(sub,block) = std(abs(Disks.confidence.PDC(:,block,sub)));
        PDPd_confid_block(sub,block) = std(abs(Disks.confidence.PDP(:,block,sub)));
    end
end

% Compute means

yf = [mean(SCf_confid_block,2) mean(SPf_confid_block,2) mean(DCf_confid_block,2) mean(DPf_confid_block,2)];
sf = [std(SCf_confid_block,0,2) std(SPf_confid_block,0,2) std(DCf_confid_block,0,2) std(DPf_confid_block,0,2)]./sqrt(8);

yd = [mean(SCd_confid_block,2) mean(SPd_confid_block,2) mean(DCd_confid_block,2) mean(DPd_confid_block,2)...
    mean(PDCd_confid_block,2) mean(PDPd_confid_block,2)];
sd = [std(SCd_confid_block,0,2) std(SPd_confid_block,0,2) std(DCd_confid_block,0,2) std(DPd_confid_block,0,2)...
    std(PDCd_confid_block,0,2) std(PDPd_confid_block,0,2)]./sqrt(8);

%% GENDER PLOT

figure

set(gcf,'Position',coord)

[h,errh] = barwitherr(sf,yf);
set(errh,'LineWidth',2)
set(h,'LineStyle','none','BarWidth',1)

set(h(1),'FaceColor',CST_col)
set(h(2),'FaceColor',PST_col)
set(h(3),'FaceColor',TAa_col./1.7)
set(h(4),'FaceColor',TAa_col./1.1)

legend(h,{'SC' 'SP' 'DC' 'DP'},'FontSize',20)
legend('boxoff')

set(gca,'TickDir','out','FontSize',16)
xlabel('Subject','FontSize',20)
ylabel('std(abs(Confidence))','FontSize',20)

box off

title('Confidence Deviation: Gender','FontSize',24)

original_dir = pwd;
cd(saveplace)
naming = 'gender_confidence_std';

saveas(gcf,naming,'png')
print(naming,'-depsc');

cd(original_dir)

%% DISK PLOT

figure

set(gcf,'Position',coord)

[h,errh] = barwitherr(sd,yd);
set(errh,'LineWidth',2)
set(h,'LineStyle','none','BarWidth',1)

set(h(1),'FaceColor',CST_col)
set(h(2),'FaceColor',PST_col)
set(h(3),'FaceColor',TAa_col./1.7)
set(h(4),'FaceColor',TAa_col./1.1)
set(h(5),'FaceColor',CST_col+TAt_col-.3)
set(h(6),'FaceColor',CST_col+TAt_col)

legend(h,{'SC' 'SP' 'DC' 'DP' 'PDC' 'PDP'},'FontSize',20)
legend('boxoff')

set(gca,'TickDir','out','FontSize',16)
xlabel('Subject','FontSize',20)
ylabel('std(abs(Confidence))','FontSize',20)

box off

title('Confidence Deviation: Disks','FontSize',24)

original_dir = pwd;
cd(saveplace)
naming = 'disk_confidence_std';

saveas(gcf,naming,'png')
print(naming,'-depsc');

cd(original_dir)

%% PER SUBJECT/TASK CONFIDENCE PLOTS
% STANDARD DEVIATIONS

SCf_confid_block = zeros(8,8);
SPf_confid_block = zeros(8,8);
DCf_confid_block = zeros(8,8);
DPf_confid_block = zeros(8,8);

SCd_confid_block = zeros(8,8);
SPd_confid_block = zeros(8,8);
DCd_confid_block = zeros(8,8);
DPd_confid_block = zeros(8,8);
PDCd_confid_block = zeros(8,8);
PDPd_confid_block = zeros(8,8);

for sub = 1:8
    for block = 1:8
        SCf_confid_block(sub,block) = std(abs(Faces.confidence.SC(:,block,sub)));
        SPf_confid_block(sub,block) = std(abs(Faces.confidence.SP(:,block,sub)));
        DCf_confid_block(sub,block) = std(abs(Faces.confidence.DC(:,block,sub)));
        DPf_confid_block(sub,block) = std(abs(Faces.confidence.DP(:,block,sub)));
        
        SCd_confid_block(sub,block) = std(abs(Disks.confidence.SC(:,block,sub)));
        SPd_confid_block(sub,block) = std(abs(Disks.confidence.SP(:,block,sub)));
        DCd_confid_block(sub,block) = std(abs(Disks.confidence.DC(:,block,sub)));
        DPd_confid_block(sub,block) = std(abs(Disks.confidence.DP(:,block,sub)));
        PDCd_confid_block(sub,block) = std(abs(Disks.confidence.PDC(:,block,sub)));
        PDPd_confid_block(sub,block) = std(abs(Disks.confidence.PDP(:,block,sub)));
    end
end

% Compute means

yf = [mean(SCf_confid_block,2) mean(SPf_confid_block,2) mean(DCf_confid_block,2) mean(DPf_confid_block,2)];
yf = [mean(yf(:,1:2),2) mean(yf(:,3:4),2)];

sf = [std(SCf_confid_block,0,2) std(SPf_confid_block,0,2) std(DCf_confid_block,0,2) std(DPf_confid_block,0,2)]./sqrt(8);
sf = [mean(sf(:,1:2),2) mean(sf(:,3:4),2)];

yd = [mean(SCd_confid_block,2) mean(SPd_confid_block,2) mean(DCd_confid_block,2) mean(DPd_confid_block,2)...
    mean(PDCd_confid_block,2) mean(PDPd_confid_block,2)];
yd = [mean(yd(:,1:2),2) mean(yd(:,3:4),2) mean(yd(:,5:6),2)];

sd = [std(SCd_confid_block,0,2) std(SPd_confid_block,0,2) std(DCd_confid_block,0,2) std(DPd_confid_block,0,2)...
    std(PDCd_confid_block,0,2) std(PDPd_confid_block,0,2)]./sqrt(8);
sd = [mean(sd(:,1:2),2) mean(sd(:,3:4),2) mean(sd(:,5:6),2)];

%% GENDER PLOT

figure

set(gcf,'Position',coord)

[h,errh] = barwitherr(sf,yf);
set(errh,'LineWidth',2)
set(h,'LineStyle','none','BarWidth',1)

set(h(1),'FaceColor',mean([CST_col;PST_col]))

set(h(2),'FaceColor',mean([TAa_col./1.7;TAa_col./1.1]))


legend(h,{'ST' 'DT'},'FontSize',20)
legend('boxoff')

set(gca,'TickDir','out','FontSize',16)
xlabel('Subject','FontSize',20)
ylabel('std(abs(Confidence))','FontSize',20)

box off

title('Confidence Deviation by Task: Gender','FontSize',24)

original_dir = pwd;
cd(saveplace)
naming = 'gender_confidence_task';

saveas(gcf,naming,'png')
print(naming,'-depsc');

cd(original_dir)

%% DISK PLOT

figure

set(gcf,'Position',coord)

[h,errh] = barwitherr(sd,yd);
set(errh,'LineWidth',2)
set(h,'LineStyle','none','BarWidth',1)

set(h(1),'FaceColor',mean([CST_col ; PST_col]))
set(h(2),'FaceColor',mean([TAa_col./1.7 ; TAa_col./1.1]))
set(h(3),'FaceColor',mean([CST_col+TAt_col-.3 ; CST_col+TAt_col]))


legend(h,{'ST' 'DT' 'PDT'},'FontSize',20)
legend('boxoff')

set(gca,'TickDir','out','FontSize',16)
xlabel('Subject','FontSize',20)
ylabel('std(abs(Confidence))','FontSize',20)

box off

title('Confidence Deviation by Task: Disks','FontSize',24)

original_dir = pwd;
cd(saveplace)
naming = 'disk_confidence_task';

saveas(gcf,naming,'png')
print(naming,'-depsc');

cd(original_dir)