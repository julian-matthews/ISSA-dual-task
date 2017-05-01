
%% ANALYSIS + GRAPH BUILD

Faces = individual_analysis(1,0,0);
Disks = individual_analysis(0,1,0);

saveplace = '../figures/Manuscript_figure_2/final/';

%% COLOURS FROM EXAMPLE FIGURE

CST_col = [5 113 176]./255;
PST_col = [146 197 222]./255;
TAt_col = [202 0 32]./255;
TAa_col = [244 165 130]./255;

%% FACE: OBJECTIVE PERFORMANCE
this_measure = Faces.ST_Central.Objective_Performance_MEAN;

CST_mean = mean(this_measure);
CST_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Faces.ST_Peripheral.Objective_Performance_MEAN;

PST_mean = mean(this_measure);
PST_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Faces.DT_Central.Objective_Performance_MEAN;

CDT_mean = mean(this_measure);
CDT_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Faces.DT_Peripheral.Objective_Performance_MEAN;

PDT_mean = mean(this_measure);
PDT_SEM = std(this_measure)/sqrt(length(this_measure));

% Trade off values

[~, DT_x, DT_y, ~] = ...
    trade_off(CST_mean,PST_mean,CDT_mean,PDT_mean);

[~, ST_x, ST_y, ~] = ...
    trade_off(CST_mean,PST_mean,CST_mean,PST_mean);

%% Plot em

figure;

set(gcf,'Position',[1100 100 800 800])

line([0 1],[.5 .5],'Color','k','LineStyle',':','Linewidth',1)
hold on
line([.5 .5],[0 1],'Color','k','LineStyle',':','Linewidth',1)

% TAtheory line rgb(202, 0, 32)
line([ST_x,CST_mean],[ST_y,PST_mean],'Color',TAt_col,'LineStyle','-','Linewidth',2)

% TAactual line rgb(244, 165, 130)
line([DT_x,CDT_mean],[DT_y,PDT_mean],'Color',TAa_col,'LineStyle','-','Linewidth',2)

% PST line rgb(146, 197, 222)
line([.5 CST_mean],[PST_mean PST_mean],'Color',PST_col,'LineStyle','-','Linewidth',2);

% CST line rgb(5, 113, 176)
line([CST_mean CST_mean],[.5 PST_mean],'Color',CST_col,'LineStyle','-','Linewidth',2);

% Connecting line
line([.5 CST_mean],[PST_mean .5],'Color','k','LineStyle','-','Linewidth',2);

% PST
h = errorbar(.5 , PST_mean,PST_SEM,'ko','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',PST_col);
removeErrorBarEnds(h,0);

% CST
h = herrorbar(CST_mean,.5, CST_SEM,'ko',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',CST_col);

% DT theory point
scatter(CST_mean,PST_mean,100,TAt_col,'filled');

% DT actual point w/ errorbars
h = errorbar(CDT_mean,PDT_mean,PDT_SEM,'ko','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAa_col);
removeErrorBarEnds(h,0);
h = herrorbar(CDT_mean,PDT_mean, CDT_SEM,'ko',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAa_col);

xlim([.47,.83])
ylim([.47,.83])
set(gca,'XTick',0:0.05:1,'YTick',0:0.05:1)
set(gca,'TickDir','out','PlotBoxAspectRatio',[1 1 1],'FontSize',16)

xlabel('Central Type I AUC','FontSize',20);
ylabel('Peripheral Type I AUC','FontSize',20);

box off

title('Objective Performance: Gender','FontSize',24)

% OffsetAxes

original_dir = pwd;
cd(saveplace)
naming = 'gender_performance';

saveas(gcf,naming,'fig')
print(naming,'-depsc');

cd(original_dir)

%% FACE: Metacognition
this_measure = Faces.ST_Central.Metacognition_MEAN;

CST_mean = mean(this_measure);
CST_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Faces.ST_Peripheral.Metacognition_MEAN;

PST_mean = mean(this_measure);
PST_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Faces.DT_Central.Metacognition_MEAN;

CDT_mean = mean(this_measure);
CDT_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Faces.DT_Peripheral.Metacognition_MEAN;

PDT_mean = mean(this_measure);
PDT_SEM = std(this_measure)/sqrt(length(this_measure));

% Trade off values

[~, DT_x, DT_y, ~] = ...
    trade_off(CST_mean,PST_mean,CDT_mean,PDT_mean);

[~, ST_x, ST_y, ~] = ...
    trade_off(CST_mean,PST_mean,CST_mean,PST_mean);

%% Plot em

figure;

set(gcf,'Position',[1100 100 800 800])

line([0 1],[.5 .5],'Color','k','LineStyle',':','Linewidth',1)
hold on
line([.5 .5],[0 1],'Color','k','LineStyle',':','Linewidth',1)

% TAtheory line rgb(202, 0, 32)
line([ST_x,CST_mean],[ST_y,PST_mean],'Color',TAt_col,'LineStyle','-','Linewidth',2)

% TAactual line rgb(244, 165, 130)
line([DT_x,CDT_mean],[DT_y,PDT_mean],'Color',TAa_col,'LineStyle','-','Linewidth',2)

% PST line rgb(146, 197, 222)
line([.5 CST_mean],[PST_mean PST_mean],'Color',PST_col,'LineStyle','-','Linewidth',2);

% CST line rgb(5, 113, 176)
line([CST_mean CST_mean],[.5 PST_mean],'Color',CST_col,'LineStyle','-','Linewidth',2);

% Connecting line
line([.5 CST_mean],[PST_mean .5],'Color','k','LineStyle','-','Linewidth',2);

% PST
h = errorbar(.5 , PST_mean,PST_SEM,'ko','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',PST_col);
removeErrorBarEnds(h,0);

% CST
h = herrorbar(CST_mean,.5, CST_SEM,'ko',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',CST_col);

% DT theory point
scatter(CST_mean,PST_mean,100,TAt_col,'filled');

% DT actual point w/ errorbars
h = errorbar(CDT_mean,PDT_mean,PDT_SEM,'ko','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAa_col);
removeErrorBarEnds(h,0);
h = herrorbar(CDT_mean,PDT_mean, CDT_SEM,'ko',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAa_col);

xlim([.481,.67])
ylim([.481,.67])
set(gca,'XTick',0:0.02:1,'YTick',0:0.02:1)
set(gca,'TickDir','out','PlotBoxAspectRatio',[1 1 1],'FontSize',16)

xlabel('Central Type II AUC','FontSize',20);
ylabel('Peripheral Type II AUC','FontSize',20);

box off

title('Metacognition: Gender','FontSize',24)

% OffsetAxes

original_dir = pwd;
cd(saveplace)
naming = 'gender_metacognition';

saveas(gcf,naming,'fig')
print(naming,'-depsc');

cd(original_dir)

%% FACE: Confidence
this_measure = Faces.ST_Central.Confidence_MEAN_correct;

CST_mean = mean(this_measure);
CST_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Faces.ST_Peripheral.Confidence_MEAN_correct;

PST_mean = mean(this_measure);
PST_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Faces.DT_Central.Confidence_MEAN_correct;

CDT_mean = mean(this_measure);
CDT_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Faces.DT_Peripheral.Confidence_MEAN_correct;

PDT_mean = mean(this_measure);
PDT_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Faces.ST_Central.Confidence_MEAN_incorrect;

CST_mean_in = mean(this_measure);
CST_SEM_in = std(this_measure)/sqrt(length(this_measure));

this_measure = Faces.ST_Peripheral.Confidence_MEAN_incorrect;

PST_mean_in = mean(this_measure);
PST_SEM_in = std(this_measure)/sqrt(length(this_measure));

this_measure = Faces.DT_Central.Confidence_MEAN_incorrect;

CDT_mean_in = mean(this_measure);
CDT_SEM_in = std(this_measure)/sqrt(length(this_measure));

this_measure = Faces.DT_Peripheral.Confidence_MEAN_incorrect;

PDT_mean_in = mean(this_measure);
PDT_SEM_in = std(this_measure)/sqrt(length(this_measure));

% Trade off values

% [~, DT_x, DT_y, ~] = ...
%     trade_off(CST_mean,PST_mean,CDT_mean,PDT_mean);
% 
% [~, ST_x, ST_y, ~] = ...
%     trade_off(CST_mean,PST_mean,CST_mean,PST_mean);

%% Plot em

figure;

set(gcf,'Position',[1100 100 800 800])

% line([1 4],[1 1],'Color','k','LineStyle',':','Linewidth',1)
hold on
% line([1 1],[1 4],'Color','k','LineStyle',':','Linewidth',1)

% Confidence incorrect lines
line([1 CST_mean_in],[PST_mean_in PST_mean_in],'Color',TAt_col,'LineStyle','-','Linewidth',2);
line([CST_mean_in CST_mean_in],[1 PST_mean_in],'Color',TAt_col,'LineStyle','-','Linewidth',2);
% line([1 CST_mean_in],[PST_mean_in 1],'Color',TAt_col,'LineStyle','-','Linewidth',2);

% Confidence correct lines
line([.95 CST_mean],[PST_mean PST_mean],'Color',CST_col,'LineStyle','-','Linewidth',2);
line([CST_mean CST_mean],[.95 PST_mean],'Color',CST_col,'LineStyle','-','Linewidth',2);
% line([.95 CST_mean],[PST_mean .95],'Color',CST_col,'LineStyle','-','Linewidth',2);

% Incorrect points
h = errorbar(1 , PST_mean_in,PST_SEM_in,'ks','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAt_col);
removeErrorBarEnds(h,0);

h = herrorbar(CST_mean_in,1, CST_SEM_in,'ks',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAt_col);

h = errorbar(CDT_mean_in,PDT_mean_in,PDT_SEM_in,'ks','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAt_col);
removeErrorBarEnds(h,0);
h = herrorbar(CDT_mean_in,PDT_mean_in, CDT_SEM_in,'ks',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAt_col);

% Correct points
h = errorbar(.95, PST_mean,PST_SEM,'ko','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',CST_col);
removeErrorBarEnds(h,0);

h = herrorbar(CST_mean,.95, CST_SEM,'ko',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',CST_col);

h = errorbar(CDT_mean,PDT_mean,PDT_SEM,'ko','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',CST_col);
removeErrorBarEnds(h,0);
h = herrorbar(CDT_mean,PDT_mean, CDT_SEM,'ko',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',CST_col);

% Defaults for legend
correct = plot([0 .1],[0 .1],'ko-','Color',CST_col,'LineWidth',2,...
    'MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor',CST_col);
incorrect = plot([0 .1],[0 .1],'ks-','Color',TAt_col,'LineWidth',2,...
    'MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor',TAt_col);

xlim([.85,3.2])
ylim([.85,3.2])
set(gca,'XTick',0:1:4,'YTick',0:1:4)
set(gca,'TickDir','out','PlotBoxAspectRatio',[1 1 1],'FontSize',16)

xlabel('Central Confidence(1:4)','FontSize',20);
ylabel('Peripheral Confidence(1:4)','FontSize',20);

box off

title('Confidence: Gender','FontSize',24)

legend([correct incorrect],{'Correct' 'Incorrect'},'FontSize',20)
legend('boxoff')

% OffsetAxes

original_dir = pwd;
cd(saveplace)
naming = 'gender_confidence';

saveas(gcf,naming,'fig')
print(naming,'-depsc');

cd(original_dir)

%% DISK: OBJECTIVE PERFORMANCE
this_measure = Disks.ST_Central.Objective_Performance_MEAN;

CST_mean = mean(this_measure);
CST_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Disks.ST_Peripheral.Objective_Performance_MEAN;

PST_mean = mean(this_measure);
PST_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Disks.DT_Central.Objective_Performance_MEAN;

CDT_mean = mean(this_measure);
CDT_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Disks.DT_Peripheral.Objective_Performance_MEAN;

PDT_mean = mean(this_measure);
PDT_SEM = std(this_measure)/sqrt(length(this_measure));

% Trade off values

[~, DT_x, DT_y, ~] = ...
    trade_off(CST_mean,PST_mean,CDT_mean,PDT_mean);

[~, ST_x, ST_y, ~] = ...
    trade_off(CST_mean,PST_mean,CST_mean,PST_mean);

%% Plot em

figure;

set(gcf,'Position',[1100 100 800 800])

line([0 1],[.5 .5],'Color','k','LineStyle',':','Linewidth',1)
hold on
line([.5 .5],[0 1],'Color','k','LineStyle',':','Linewidth',1)

% TAtheory line rgb(202, 0, 32)
line([ST_x,CST_mean],[ST_y,PST_mean],'Color',TAt_col,'LineStyle','-','Linewidth',2)

% TAactual line rgb(244, 165, 130)
line([DT_x,CDT_mean],[DT_y,PDT_mean],'Color',TAa_col,'LineStyle','-','Linewidth',2)

% PST line rgb(146, 197, 222)
line([.5 CST_mean],[PST_mean PST_mean],'Color',PST_col,'LineStyle','-','Linewidth',2);

% CST line rgb(5, 113, 176)
line([CST_mean CST_mean],[.5 PST_mean],'Color',CST_col,'LineStyle','-','Linewidth',2);

% Connecting line
line([.5 CST_mean],[PST_mean .5],'Color','k','LineStyle','-','Linewidth',2);

% PST
h = errorbar(.5 , PST_mean,PST_SEM,'ko','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',PST_col);
removeErrorBarEnds(h,0);

% CST
h = herrorbar(CST_mean,.5, CST_SEM,'ko',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',CST_col);

% DT theory point
scatter(CST_mean,PST_mean,100,TAt_col,'filled');

% DT actual point w/ errorbars
h = errorbar(CDT_mean,PDT_mean,PDT_SEM,'ko','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAa_col);
removeErrorBarEnds(h,0);
h = herrorbar(CDT_mean,PDT_mean, CDT_SEM,'ko',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAa_col);

xlim([.47,.83])
ylim([.47,.83])
set(gca,'XTick',0:0.05:1,'YTick',0:0.05:1)
set(gca,'TickDir','out','PlotBoxAspectRatio',[1 1 1],'FontSize',16)

xlabel('Central Type I AUC','FontSize',20);
ylabel('Peripheral Type I AUC','FontSize',20);

box off

title('Objective Performance: Disks','FontSize',24)

% OffsetAxes

original_dir = pwd;
cd(saveplace)
naming = 'disk_performance';

saveas(gcf,naming,'fig')
print(naming,'-depsc');

cd(original_dir)

%% DISK: Metacognition
this_measure = Disks.ST_Central.Metacognition_MEAN;

CST_mean = mean(this_measure);
CST_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Disks.ST_Peripheral.Metacognition_MEAN;

PST_mean = mean(this_measure);
PST_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Disks.DT_Central.Metacognition_MEAN;

CDT_mean = mean(this_measure);
CDT_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Disks.DT_Peripheral.Metacognition_MEAN;

PDT_mean = mean(this_measure);
PDT_SEM = std(this_measure)/sqrt(length(this_measure));

% Trade off values

[~, DT_x, DT_y, ~] = ...
    trade_off(CST_mean,PST_mean,CDT_mean,PDT_mean);

[~, ST_x, ST_y, ~] = ...
    trade_off(CST_mean,PST_mean,CST_mean,PST_mean);

%% Plot em

figure;

set(gcf,'Position',[1100 100 800 800])

line([0 1],[.5 .5],'Color','k','LineStyle',':','Linewidth',1)
hold on
line([.5 .5],[0 1],'Color','k','LineStyle',':','Linewidth',1)

% TAtheory line rgb(202, 0, 32)
line([ST_x,CST_mean],[ST_y,PST_mean],'Color',TAt_col,'LineStyle','-','Linewidth',2)

% TAactual line rgb(244, 165, 130)
line([DT_x,CDT_mean],[DT_y,PDT_mean],'Color',TAa_col,'LineStyle','-','Linewidth',2)

% PST line rgb(146, 197, 222)
line([.5 CST_mean],[PST_mean PST_mean],'Color',PST_col,'LineStyle','-','Linewidth',2);

% CST line rgb(5, 113, 176)
line([CST_mean CST_mean],[.5 PST_mean],'Color',CST_col,'LineStyle','-','Linewidth',2);

% Connecting line
line([.5 CST_mean],[PST_mean .5],'Color','k','LineStyle','-','Linewidth',2);

% PST
h = errorbar(.5 , PST_mean,PST_SEM,'ko','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',PST_col);
removeErrorBarEnds(h,0);

% CST
h = herrorbar(CST_mean,.5, CST_SEM,'ko',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',CST_col);

% DT theory point
scatter(CST_mean,PST_mean,100,TAt_col,'filled');

% DT actual point w/ errorbars
h = errorbar(CDT_mean,PDT_mean,PDT_SEM,'ko','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAa_col);
removeErrorBarEnds(h,0);
h = herrorbar(CDT_mean,PDT_mean, CDT_SEM,'ko',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAa_col);

xlim([.481,.63])
ylim([.481,.63])
set(gca,'XTick',0:0.02:1,'YTick',0:0.02:1)
set(gca,'TickDir','out','PlotBoxAspectRatio',[1 1 1],'FontSize',16)

xlabel('Central Type II AUC','FontSize',20);
ylabel('Peripheral Type II AUC','FontSize',20);

box off

title('Metacognition: Disks','FontSize',24)

% OffsetAxes

original_dir = pwd;
cd(saveplace)
naming = 'disk_metacognition';

saveas(gcf,naming,'fig')
print(naming,'-depsc');

cd(original_dir)

%% DISK: Confidence
this_measure = Disks.ST_Central.Confidence_MEAN_correct;

CST_mean = mean(this_measure);
CST_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Disks.ST_Peripheral.Confidence_MEAN_correct;

PST_mean = mean(this_measure);
PST_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Disks.DT_Central.Confidence_MEAN_correct;

CDT_mean = mean(this_measure);
CDT_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Disks.DT_Peripheral.Confidence_MEAN_correct;

PDT_mean = mean(this_measure);
PDT_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Disks.ST_Central.Confidence_MEAN_incorrect;

CST_mean_in = mean(this_measure);
CST_SEM_in = std(this_measure)/sqrt(length(this_measure));

this_measure = Disks.ST_Peripheral.Confidence_MEAN_incorrect;

PST_mean_in = mean(this_measure);
PST_SEM_in = std(this_measure)/sqrt(length(this_measure));

this_measure = Disks.DT_Central.Confidence_MEAN_incorrect;

CDT_mean_in = mean(this_measure);
CDT_SEM_in = std(this_measure)/sqrt(length(this_measure));

this_measure = Disks.DT_Peripheral.Confidence_MEAN_incorrect;

PDT_mean_in = mean(this_measure);
PDT_SEM_in = std(this_measure)/sqrt(length(this_measure));

% Trade off values

% [~, DT_x, DT_y, ~] = ...
%     trade_off(CST_mean,PST_mean,CDT_mean,PDT_mean);
% 
% [~, ST_x, ST_y, ~] = ...
%     trade_off(CST_mean,PST_mean,CST_mean,PST_mean);

%% Plot em

figure;

set(gcf,'Position',[1100 100 800 800])

% line([1 4],[1 1],'Color','k','LineStyle',':','Linewidth',1)
hold on
% line([1 1],[1 4],'Color','k','LineStyle',':','Linewidth',1)

% Confidence incorrect lines
line([1 CST_mean_in],[PST_mean_in PST_mean_in],'Color',TAt_col,'LineStyle','-','Linewidth',2);
line([CST_mean_in CST_mean_in],[1 PST_mean_in],'Color',TAt_col,'LineStyle','-','Linewidth',2);
% line([1 CST_mean_in],[PST_mean_in 1],'Color',TAt_col,'LineStyle','-','Linewidth',2);

% Confidence correct lines
line([.95 CST_mean],[PST_mean PST_mean],'Color',CST_col,'LineStyle','-','Linewidth',2);
line([CST_mean CST_mean],[.95 PST_mean],'Color',CST_col,'LineStyle','-','Linewidth',2);
% line([.95 CST_mean],[PST_mean .95],'Color',CST_col,'LineStyle','-','Linewidth',2);

% Incorrect points
h = errorbar(1 , PST_mean_in,PST_SEM_in,'ks','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAt_col);
removeErrorBarEnds(h,0);

h = herrorbar(CST_mean_in,1, CST_SEM_in,'ks',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAt_col);

h = errorbar(CDT_mean_in,PDT_mean_in,PDT_SEM_in,'ks','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAt_col);
removeErrorBarEnds(h,0);
h = herrorbar(CDT_mean_in,PDT_mean_in, CDT_SEM_in,'ks',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAt_col);

% Correct points
h = errorbar(.95 , PST_mean,PST_SEM,'ko','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',CST_col);
removeErrorBarEnds(h,0);

h = herrorbar(CST_mean,.95, CST_SEM,'ko',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',CST_col);

h = errorbar(CDT_mean,PDT_mean,PDT_SEM,'ko','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',CST_col);
removeErrorBarEnds(h,0);
h = herrorbar(CDT_mean,PDT_mean, CDT_SEM,'ko',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',CST_col);

% Defaults for legend
correct = plot([0 .1],[0 .1],'ko-','Color',CST_col,'LineWidth',2,...
    'MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor',CST_col);
incorrect = plot([0 .1],[0 .1],'ks-','Color',TAt_col,'LineWidth',2,...
    'MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor',TAt_col);

xlim([.85,3.2])
ylim([.85,3.2])
set(gca,'XTick',0:1:4,'YTick',0:1:4)
set(gca,'TickDir','out','PlotBoxAspectRatio',[1 1 1],'FontSize',16)

xlabel('Central Confidence(1:4)','FontSize',20);
ylabel('Peripheral Confidence(1:4)','FontSize',20);

box off

title('Confidence: Disks','FontSize',24)

legend([correct incorrect],{'Correct' 'Incorrect'},'FontSize',20)
legend('boxoff')

% OffsetAxes

original_dir = pwd;
cd(saveplace)
naming = 'disk_confidence';

saveas(gcf,naming,'fig')
print(naming,'-depsc');

cd(original_dir)

%% CHANGE IN CONFIDENCE PLOTS

%% FACE: Confidence
this_measure = Faces.ST_Central.Confidence_MEAN_correct - Faces.ST_Central.Confidence_MEAN_incorrect;

CST_mean = mean(this_measure);
CST_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Faces.ST_Peripheral.Confidence_MEAN_correct - Faces.ST_Peripheral.Confidence_MEAN_incorrect;

PST_mean = mean(this_measure);
PST_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Faces.DT_Central.Confidence_MEAN_correct - Faces.DT_Central.Confidence_MEAN_incorrect;

CDT_mean = mean(this_measure);
CDT_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Faces.DT_Peripheral.Confidence_MEAN_correct - Faces.DT_Peripheral.Confidence_MEAN_incorrect;

PDT_mean = mean(this_measure);
PDT_SEM = std(this_measure)/sqrt(length(this_measure));

% Trade off values

[~, DT_x, DT_y, ~] = ...
    trade_off(CST_mean,PST_mean,CDT_mean,PDT_mean,0);

[~, ST_x, ST_y, ~] = ...
    trade_off(CST_mean,PST_mean,CST_mean,PST_mean,0);

%% Plot em

figure;

set(gcf,'Position',[1100 100 800 800])

line([-1 1],[0 0],'Color','k','LineStyle',':','Linewidth',1)
hold on
line([0 0],[-1 1],'Color','k','LineStyle',':','Linewidth',1)

% TAtheory line rgb(202, 0, 32)
line([ST_x,CST_mean],[ST_y,PST_mean],'Color',TAt_col,'LineStyle','-','Linewidth',2)

% TAactual line rgb(244, 165, 130)
line([DT_x,CDT_mean],[DT_y,PDT_mean],'Color',TAa_col,'LineStyle','-','Linewidth',2)

% PST line rgb(146, 197, 222)
line([0 CST_mean],[PST_mean PST_mean],'Color',PST_col,'LineStyle','-','Linewidth',2);

% CST line rgb(5, 113, 176)
line([CST_mean CST_mean],[0 PST_mean],'Color',CST_col,'LineStyle','-','Linewidth',2);

% Connecting line
line([0 CST_mean],[PST_mean 0],'Color','k','LineStyle','-','Linewidth',2);

% PST
h = errorbar(0 , PST_mean,PST_SEM,'ko','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',PST_col);
removeErrorBarEnds(h,0);

% CST
h = herrorbar(CST_mean,0, CST_SEM,'ko',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',CST_col);

% DT theory point
scatter(CST_mean,PST_mean,100,TAt_col,'filled');

% DT actual point w/ errorbars
h = errorbar(CDT_mean,PDT_mean,PDT_SEM,'ko','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAa_col);
removeErrorBarEnds(h,0);
h = herrorbar(CDT_mean,PDT_mean, CDT_SEM,'ko',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAa_col);

xlim([-.05,.55])
ylim([-.05,.55])
set(gca,'XTick',0:.05:1,'YTick',0:.05:1)
set(gca,'TickDir','out','PlotBoxAspectRatio',[1 1 1],'FontSize',16)

xlabel('Central Confidence','FontSize',20);
ylabel('Peripheral Confidence','FontSize',20);

box off

title('Confidence Difference(Correct-Incorrect): Gender','FontSize',24)

% OffsetAxes

original_dir = pwd;
cd(saveplace)
naming = 'gender_confidence_diff';

saveas(gcf,naming,'fig')
print(naming,'-depsc');

cd(original_dir)

%% DISKS: Confidence
this_measure = Disks.ST_Central.Confidence_MEAN_correct - Disks.ST_Central.Confidence_MEAN_incorrect;

CST_mean = mean(this_measure);
CST_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Disks.ST_Peripheral.Confidence_MEAN_correct - Disks.ST_Peripheral.Confidence_MEAN_incorrect;

PST_mean = mean(this_measure);
PST_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Disks.DT_Central.Confidence_MEAN_correct - Disks.DT_Central.Confidence_MEAN_incorrect;

CDT_mean = mean(this_measure);
CDT_SEM = std(this_measure)/sqrt(length(this_measure));

this_measure = Disks.DT_Peripheral.Confidence_MEAN_correct - Disks.DT_Peripheral.Confidence_MEAN_incorrect;

PDT_mean = mean(this_measure);
PDT_SEM = std(this_measure)/sqrt(length(this_measure));

% Trade off values

[~, DT_x, DT_y, ~] = ...
    trade_off(CST_mean,PST_mean,CDT_mean,PDT_mean,0);

[~, ST_x, ST_y, ~] = ...
    trade_off(CST_mean,PST_mean,CST_mean,PST_mean,0);

%% Plot em

figure;

set(gcf,'Position',[1100 100 800 800])

line([-1 1],[0 0],'Color','k','LineStyle',':','Linewidth',1)
hold on
line([0 0],[-1 1],'Color','k','LineStyle',':','Linewidth',1)

% TAtheory line rgb(202, 0, 32)
line([ST_x,CST_mean],[ST_y,PST_mean],'Color',TAt_col,'LineStyle','-','Linewidth',2)

% TAactual line rgb(244, 165, 130)
line([DT_x,CDT_mean],[DT_y,PDT_mean],'Color',TAa_col,'LineStyle','-','Linewidth',2)

% PST line rgb(146, 197, 222)
line([0 CST_mean],[PST_mean PST_mean],'Color',PST_col,'LineStyle','-','Linewidth',2);

% CST line rgb(5, 113, 176)
line([CST_mean CST_mean],[0 PST_mean],'Color',CST_col,'LineStyle','-','Linewidth',2);

% Connecting line
line([0 CST_mean],[PST_mean 0],'Color','k','LineStyle','-','Linewidth',2);

% PST
h = errorbar(0 , PST_mean,PST_SEM,'ko','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',PST_col);
removeErrorBarEnds(h,0);

% CST
h = herrorbar(CST_mean,0, CST_SEM,'ko',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',CST_col);

% DT theory point
scatter(CST_mean,PST_mean,100,TAt_col,'filled');

% DT actual point w/ errorbars
h = errorbar(CDT_mean,PDT_mean,PDT_SEM,'ko','MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAa_col);
removeErrorBarEnds(h,0);
h = herrorbar(CDT_mean,PDT_mean, CDT_SEM,'ko',1);
set(h,'MarkerSize',10,'LineWidth',2,'MarkerFaceColor',TAa_col);

xlim([-.05,.5])
ylim([-.05,.5])
set(gca,'XTick',0:.05:1,'YTick',0:.05:1)
set(gca,'TickDir','out','PlotBoxAspectRatio',[1 1 1],'FontSize',16)

xlabel('Central Confidence','FontSize',20);
ylabel('Peripheral Confidence','FontSize',20);

box off

title('Confidence Difference(Correct-Incorrect): Disks','FontSize',24)

% OffsetAxes

original_dir = pwd;
cd(saveplace)
naming = 'disk_confidence_diff';

saveas(gcf,naming,'fig')
print(naming,'-depsc');

cd(original_dir)

%% TAactual COMPARISON BARS

%% OBJECTIVE PERFORMANCE

TAa_Face = zeros(1,8);
TAt_Face = zeros(1,8);
TAa_Disk = zeros(1,8);
TAt_Disk = zeros(1,8);

for subj = 1:8

% Actual performance altitude
[TAa_Face(subj),~,~,~] = trade_off(...
    Faces.ST_Central.Objective_Performance_MEAN(subj),...
    Faces.ST_Peripheral.Objective_Performance_MEAN(subj),...
    Faces.DT_Central.Objective_Performance_MEAN(subj),...
    Faces.DT_Peripheral.Objective_Performance_MEAN(subj),...
    0.5);

% Theoretical performance altitude
[TAt_Face(subj),~,~,~] = trade_off(...
    Faces.ST_Central.Objective_Performance_MEAN(subj),...
    Faces.ST_Peripheral.Objective_Performance_MEAN(subj),...
    Faces.ST_Central.Objective_Performance_MEAN(subj),...
    Faces.ST_Peripheral.Objective_Performance_MEAN(subj),...
    0.5);

% Disks actual
[TAa_Disk(subj),~,~,~] = trade_off(...
    Disks.ST_Central.Objective_Performance_MEAN(subj),...
    Disks.ST_Peripheral.Objective_Performance_MEAN(subj),...
    Disks.DT_Central.Objective_Performance_MEAN(subj),...
    Disks.DT_Peripheral.Objective_Performance_MEAN(subj),...
    0.5);

% Disks theoretical
[TAt_Disk(subj),~,~,~] = trade_off(...
    Disks.ST_Central.Objective_Performance_MEAN(subj),...
    Disks.ST_Peripheral.Objective_Performance_MEAN(subj),...
    Disks.ST_Central.Objective_Performance_MEAN(subj),...
    Disks.ST_Peripheral.Objective_Performance_MEAN(subj),...
    0.5);

end

% Comparison
TA_Face = TAa_Face./TAt_Face;
TAf_mean = mean(TA_Face);
TAf_SEM = std(TA_Face)/sqrt(length(TA_Face));

TA_Disk = TAa_Disk./TAt_Disk;
TAd_mean = mean(TA_Disk);
TAd_SEM = std(TA_Disk)/sqrt(length(TA_Disk));

%% PLOT 'EM
figure;

set(gcf,'Position',[1100 100 800 800])

% [h, errh] = barwitherr([TAf_SEM TAd_SEM],[1 2],[TAf_mean TAd_mean],'r');
% set(errh,'LineWidth',2)
% set(h,'LineWidth',2)
% set(h,'FaceColor',TAa_col)
% removeErrorBarEnds(errh,0);

h = bar(1,TAf_mean,'FaceColor',TAa_col,'LineStyle','none');
hold on
sh = bar(2,TAd_mean,'FaceColor',PST_col,'LineStyle','none');

line([-1 3],[0 0],'Color','k','LineStyle','-','Linewidth',.5)

errh = errorbar([1 2],[TAf_mean TAd_mean],[TAf_SEM TAd_SEM],'k');
set(errh,'LineWidth',6,'LineStyle','none')
removeErrorBarEnds(errh,0);

xlim([0.25 2.75])
ylim([-.15,.9])
set(gca,'YTick',-1:.1:1)
set(gca,'TickDir','out','PlotBoxAspectRatio',[1 1 1],'FontSize',16)
set(gca, 'XTick', 1:2, 'XTickLabel', {'Gender', 'Disks'})

xlabel('Stimulus Type','FontSize',20);
ylabel('Dual-Task as a proportion of Single-Task','FontSize',20);

box off

title('Objective Performance','FontSize',24)

% Save em

original_dir = pwd;
cd(saveplace)
naming = 'comparison_performance';

saveas(gcf,naming,'fig')
print(naming,'-depsc');

cd(original_dir)

%% METACOGNITION

TAa_Face = zeros(1,8);
TAt_Face = zeros(1,8);
TAa_Disk = zeros(1,8);
TAt_Disk = zeros(1,8);

for subj = 1:8

% Actual performance altitude
[TAa_Face(subj),~,~,~] = trade_off(...
    Faces.ST_Central.Metacognition_MEAN(subj),...
    Faces.ST_Peripheral.Metacognition_MEAN(subj),...
    Faces.DT_Central.Metacognition_MEAN(subj),...
    Faces.DT_Peripheral.Metacognition_MEAN(subj),...
    0.5);

% Theoretical performance altitude
[TAt_Face(subj),~,~,~] = trade_off(...
    Faces.ST_Central.Metacognition_MEAN(subj),...
    Faces.ST_Peripheral.Metacognition_MEAN(subj),...
    Faces.ST_Central.Metacognition_MEAN(subj),...
    Faces.ST_Peripheral.Metacognition_MEAN(subj),...
    0.5);

% Disks actual
[TAa_Disk(subj),~,~,~] = trade_off(...
    Disks.ST_Central.Metacognition_MEAN(subj),...
    Disks.ST_Peripheral.Metacognition_MEAN(subj),...
    Disks.DT_Central.Metacognition_MEAN(subj),...
    Disks.DT_Peripheral.Metacognition_MEAN(subj),...
    0.5);

% Disks theoretical
[TAt_Disk(subj),~,~,~] = trade_off(...
    Disks.ST_Central.Metacognition_MEAN(subj),...
    Disks.ST_Peripheral.Metacognition_MEAN(subj),...
    Disks.ST_Central.Metacognition_MEAN(subj),...
    Disks.ST_Peripheral.Metacognition_MEAN(subj),...
    0.5);

end

% Comparison
TA_Face = TAa_Face./TAt_Face;
TAf_mean = mean(TA_Face);
TAf_SEM = std(TA_Face)/sqrt(length(TA_Face));

TA_Disk = TAa_Disk./TAt_Disk;
TAd_mean = mean(TA_Disk);
TAd_SEM = std(TA_Disk)/sqrt(length(TA_Disk));

%% PLOT 'EM
figure;

set(gcf,'Position',[1100 100 800 800])

h = bar(1,TAf_mean,'FaceColor',TAa_col,'LineStyle','none');
hold on
sh = bar(2,TAd_mean,'FaceColor',PST_col,'LineStyle','none');

line([-1 3],[0 0],'Color','k','LineStyle','-','Linewidth',.5)

errh = errorbar([1 2],[TAf_mean TAd_mean],[TAf_SEM TAd_SEM],'k');
set(errh,'LineWidth',6,'LineStyle','none')
removeErrorBarEnds(errh,0);

xlim([0.25 2.75])
ylim([-.15,.9])
set(gca,'YTick',-1:.1:1)
set(gca,'TickDir','out','PlotBoxAspectRatio',[1 1 1],'FontSize',16)
set(gca, 'XTick', 1:2, 'XTickLabel', {'Gender', 'Disks'})

xlabel('Stimulus Type','FontSize',20);
ylabel('Dual-Task as a proportion of Single-Task','FontSize',20);

box off

title('Metacognition','FontSize',24)

% Save em

original_dir = pwd;
cd(saveplace)
naming = 'comparison_metacognition';

saveas(gcf,naming,'fig')
print(naming,'-depsc');

cd(original_dir)

%% CHANGE IN CONFIDENCE

TAa_Face = zeros(1,8);
TAt_Face = zeros(1,8);
TAa_Disk = zeros(1,8);
TAt_Disk = zeros(1,8);

for subj = 1:8

% Actual performance altitude
[TAa_Face(subj),~,~,~] = trade_off(...
    Faces.ST_Central.Confidence_MEAN_correct(subj)-Faces.ST_Central.Confidence_MEAN_incorrect(subj),...
    Faces.ST_Peripheral.Confidence_MEAN_correct(subj)-Faces.ST_Peripheral.Confidence_MEAN_incorrect(subj),...
    Faces.DT_Central.Confidence_MEAN_correct(subj)-Faces.DT_Central.Confidence_MEAN_incorrect(subj),...
    Faces.DT_Peripheral.Confidence_MEAN_correct(subj)-Faces.DT_Peripheral.Confidence_MEAN_incorrect(subj),...
    0);

% Theoretical performance altitude
[TAt_Face(subj),~,~,~] = trade_off(...
    Faces.ST_Central.Confidence_MEAN_correct(subj)-Faces.ST_Central.Confidence_MEAN_incorrect(subj),...
    Faces.ST_Peripheral.Confidence_MEAN_correct(subj)-Faces.ST_Peripheral.Confidence_MEAN_incorrect(subj),...
    Faces.ST_Central.Confidence_MEAN_correct(subj)-Faces.ST_Central.Confidence_MEAN_incorrect(subj),...
    Faces.ST_Peripheral.Confidence_MEAN_correct(subj)-Faces.ST_Peripheral.Confidence_MEAN_incorrect(subj),...
    0);

% Disks actual
[TAa_Disk(subj),~,~,~] = trade_off(...
    Disks.ST_Central.Confidence_MEAN_correct(subj)-Disks.ST_Central.Confidence_MEAN_incorrect(subj),...
    Disks.ST_Peripheral.Confidence_MEAN_correct(subj)-Disks.ST_Peripheral.Confidence_MEAN_incorrect(subj),...
    Disks.DT_Central.Confidence_MEAN_correct(subj)-Disks.DT_Central.Confidence_MEAN_incorrect(subj),...
    Disks.DT_Peripheral.Confidence_MEAN_correct(subj)-Disks.DT_Peripheral.Confidence_MEAN_incorrect(subj),...
    0);

% Disks theoretical
[TAt_Disk(subj),~,~,~] = trade_off(...
    Disks.ST_Central.Confidence_MEAN_correct(subj)-Disks.ST_Central.Confidence_MEAN_incorrect(subj),...
    Disks.ST_Peripheral.Confidence_MEAN_correct(subj)-Disks.ST_Peripheral.Confidence_MEAN_incorrect(subj),...
    Disks.ST_Central.Confidence_MEAN_correct(subj)-Disks.ST_Central.Confidence_MEAN_incorrect(subj),...
    Disks.ST_Peripheral.Confidence_MEAN_correct(subj)-Disks.ST_Peripheral.Confidence_MEAN_incorrect(subj),...
    0);

end

% Comparison
TA_Face = TAa_Face./TAt_Face;
TAf_mean = mean(TA_Face);
TAf_SEM = std(TA_Face)/sqrt(length(TA_Face));

TA_Disk = TAa_Disk./TAt_Disk;
TA_Disk = [TA_Disk(1:5) TA_Disk(7:8)]; % Remove serious outlier
TAd_mean = mean(TA_Disk);
TAd_SEM = std(TA_Disk)/sqrt(length(TA_Disk));

%% PLOT 'EM
figure;

set(gcf,'Position',[1100 100 800 800])

h = bar(1,TAf_mean,'FaceColor',TAa_col,'LineStyle','none');
hold on
sh = bar(2,TAd_mean,'FaceColor',PST_col,'LineStyle','none');

line([-1 3],[0 0],'Color','k','LineStyle','-','Linewidth',.5)

errh = errorbar([1 2],[TAf_mean TAd_mean],[TAf_SEM TAd_SEM],'k');
set(errh,'LineWidth',6,'LineStyle','none')
removeErrorBarEnds(errh,0);

xlim([0.25 2.75])
ylim([-.15,.9])
set(gca,'YTick',-1:.1:1)
set(gca,'TickDir','out','PlotBoxAspectRatio',[1 1 1],'FontSize',16)
set(gca, 'XTick', 1:2, 'XTickLabel', {'Gender', 'Disks (n=7)'})

xlabel('Stimulus Type','FontSize',20);
ylabel('Dual-Task as a proportion of Single-Task','FontSize',20);

box off

title('Confidence (Correct-Incorrect)','FontSize',24)

% Save em

original_dir = pwd;
cd(saveplace)
naming = 'comparison_confidence_sub7';

saveas(gcf,naming,'fig')
print(naming,'-depsc');

cd(original_dir)