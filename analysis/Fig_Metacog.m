%% FIG_METACOG: Creates Type-II AUC plots
%
% Input: Data, save_flag, PDT_flag, figurepath
%
% Individual subject data (n=8) + group plot are presented in 3x3
% Use individual_analysis.m to create data file

function Fig_Metacog(Data,save_flag,PDT_flag,path_flag)
%% GROUP METACOGNITION PLOT

addpath('./remaining_files');

% Set defaults in case parameters not defined
SAVEIT = 0; % Default: Do not save
PDT = 0; % Default: Do not run solo-response dual-task
FigurePath = ['../figures/Manuscript_figure_2/' Data.Experiment '/'];

switch nargin
    case 4
        FigurePath = path_flag;
        if isfield(Data,'PDT_Peripheral')
            PDT = PDT_flag;
        end
        SAVEIT = save_flag;
    case 3
        if isfield(Data,'PDT_Peripheral')
            PDT = PDT_flag;
        end
        SAVEIT = save_flag;
    case 2
        SAVEIT = save_flag;
end

f = figure(1); set(f, 'Position', [0 0 900 900])
set(f,'PaperPositionMode','manual');
set(f,'PaperUnits','inches');
set(f,'PaperPosition', [2.5 2.5 16 16]);

% Include peripheral patches for single-tasks
patch_yes = 1;

% Gradient of sub-chance patches
if patch_yes
    patch_col = 0.7;
end

% Visibility of errorbar tees (0=no)
clear_tees = 1;

% Examine whether a reduced sample is being used and change labels from
% 'Run' to 'Set' if so
if size(Data.ST_Central.Confidence_SubByRun,2) < 8
    RUN_PAIRS = 1;
else
    RUN_PAIRS = 0;
end

% Set chance (0.5 for OP & Metacog, 1 for confidence plots)
chance_value = 0.5;

% Visibility of the single-task axes (removes labels) 0=no
clear_axis = 0;

% Markersize
mark = 6;

% Axis width
axis_width = 2;

% Define limits of axes (and bounds of mean-value triangle)
y_limit = 0.4;
x_limit = y_limit;
% edges = .95; % Edges set by maximum per subject
edge_further = .025; % Expansion of axis bounds beyond max ST/DT value

% Percent of axis range the single-task points & means are displayed
% Lower equals closer to axis (0.00 = on axis, 1.00 = on border);
line_off = .05; % ST points
mean_off = .125; % ST mean

% Define dimensions of plots (some width/height symmetry at the moment)
big_W = .18;
big_H = big_W;
little_W = .022;
little_H = little_W;

little_mid_w = .025; % Distance between axes
little_mid_h = little_mid_w-.003;
big_mid_w = .04; % Distance between plots
big_mid_h = big_mid_w-.01;

sides = 0.1; % Bounds of the full plot

% (1,1)
plot_1_x(1) = sides + (big_W * 0) + (little_W * 0) + (little_mid_w * 0) + (big_mid_w * 0);
plot_1_y(1) = sides + (big_H * 2) + (little_H * 3) + (little_mid_h * 3) + (big_mid_h * 2);
plot_2_x(1) = sides + (big_W * 0) + (little_W * 1) + (little_mid_w * 1) + (big_mid_w * 0);
plot_2_y(1) = plot_1_y(1);
plot_3_x(1) = sides + (big_W * 0) + (little_W * 1) + (little_mid_w * 1) + (big_mid_w * 0);
plot_3_y(1) = sides + (big_H * 2) + (little_H * 2) + (little_mid_h * 2) + (big_mid_h * 2);
% (1,2)
plot_1_x(2) = sides + (big_W * 1) + (little_W * 1) + (little_mid_w * 1) + (big_mid_w * 1);
plot_1_y(2) = plot_1_y(1);
plot_2_x(2) = sides + (big_W * 1) + (little_W * 2) + (little_mid_w * 2) + (big_mid_w * 1);
plot_2_y(2) = plot_2_y(1);
plot_3_x(2) = plot_2_x(2);
plot_3_y(2) = plot_3_y(1);
% (1,3)
plot_1_x(3) = sides + (big_W * 2) + (little_W * 2) + (little_mid_w * 2) + (big_mid_w * 2);
plot_1_y(3) = plot_1_y(2);
plot_2_x(3) = sides + (big_W * 2) + (little_W * 3) + (little_mid_w * 3) + (big_mid_w * 2);
plot_2_y(3) = plot_2_y(2);
plot_3_x(3) = plot_2_x(3);
plot_3_y(3) = plot_3_y(2);

% (2,1)
plot_1_x(4) = plot_1_x(1);
plot_1_y(4) = sides + (big_H * 1) + (little_H * 2) + (little_mid_h * 2) + (big_mid_h * 1);
plot_2_x(4) = plot_2_x(1);
plot_2_y(4) = plot_1_y(4);
plot_3_x(4) = plot_3_x(1);
plot_3_y(4) = sides + (big_H * 1) + (little_H * 1) + (little_mid_h * 1) + (big_mid_h * 1);
% (2,2)
plot_1_x(5) = plot_1_x(2);
plot_1_y(5) = plot_1_y(4);
plot_2_x(5) = plot_2_x(2);
plot_2_y(5) = plot_2_y(4);
plot_3_x(5) = plot_2_x(2);
plot_3_y(5) = plot_3_y(4);
% % (2,3)
plot_1_x(6) = plot_1_x(3);
plot_1_y(6) = plot_1_y(4);
plot_2_x(6) = plot_2_x(3);
plot_2_y(6) = plot_2_y(4);
plot_3_x(6) = plot_2_x(3);
plot_3_y(6) = plot_3_y(4);

% (3,1)
plot_1_x(7) = plot_1_x(1);
plot_1_y(7) = sides + (big_H * 0) + (little_H * 1) + (little_mid_h * 1) + (big_mid_h * 0);
plot_2_x(7) = plot_2_x(1);
plot_2_y(7) = plot_1_y(7);
plot_3_x(7) = plot_3_x(1);
plot_3_y(7) = sides + (big_H * 0) + (little_H * 0) + (little_mid_h * 0) + (big_mid_h * 0);
% (3,2)
plot_1_x(8) = plot_1_x(2);
plot_1_y(8) = plot_1_y(7);
plot_2_x(8) = plot_2_x(2);
plot_2_y(8) = plot_2_y(7);
plot_3_x(8) = plot_2_x(2);
plot_3_y(8) = plot_3_y(7);
% % (3,3)
plot_1_x(9) = plot_1_x(3);
plot_1_y(9) = plot_1_y(7);
plot_2_x(9) = plot_2_x(3);
plot_2_y(9) = plot_2_y(7);
plot_3_x(9) = plot_2_x(3);
plot_3_y(9) = plot_3_y(7);

% sub_string = mat2str(sub);
num_runs = size(Data.ST_Central.Metacognition_SubByRun,2);

% Define gradient colormap for marker face colours
% gradData = linspace(1,0,num_runs);
% 
% colormap('gray');

gradData = linspace(0,1,num_runs);

mapData = [gradData' gradData' gradData'];

colormap(mapData);

% Analysis to be performed individually for each participant
for sub = 1:Data.Subjects
    
    %% INDIVIDUAL PLOTS - Emphasizes changes (or lack there-of) over blocks
    %% Metacognition
    % Calculated separately for each block - points gradient shifted over time
    % Single-task results presented along (x,y) axes, dual-task within centre
    
    % Peripheral data
    subplot('position',[plot_2_x(sub+1),plot_2_y(sub+1),big_W,big_H])
    
    hold on
    
    % Find edges of axis, bit greater than ST or DT overall maximum
    max_vector = [Data.ST_Peripheral.Metacognition_SubByRun(sub,:),...
        Data.ST_Central.Metacognition_SubByRun(sub,:),...
        Data.DT_Peripheral.Metacognition_SubByRun(sub,:),...
        Data.DT_Central.Metacognition_SubByRun(sub,:)];
    edges = max(max_vector) + edge_further;
    
    % xlim([x_limit edges]);
    % ylim([y_limit edges]);
    set(gca, 'FontSize', 12);
    set(gca,'XTick',[.4 .5 .6 .7 .8 ]);
    set(gca,'YTick',[.4 .5 .6 .7 .8 ]);
    set(gca,'TickDir','out')
    set(gca,'Linewidth',axis_width);
    set(gca,'Layer','top');
    
    % Fill polygon with 'patch_col' gradient
    if patch_yes
        x_patch = [x_limit x_limit chance_value chance_value edges edges x_limit];
        y_patch = [y_limit edges edges chance_value chance_value y_limit y_limit];
        c_patch = zeros(1,3);
        f = fill(x_patch,y_patch,c_patch);
        % set(f,'EdgeColor','none');
        set(f,'EdgeAlpha',0);
        set(f,'FaceColor',[patch_col patch_col patch_col]);
    end
    
    % Chance lines
    line([x_limit edges],[chance_value chance_value],'Color',[0 0 0],'LineStyle',':','Linewidth',axis_width);
    line([chance_value chance_value],[y_limit edges],'Color',[0 0 0],'LineStyle',':','Linewidth',axis_width);
    
    % Comparison 'triangle' ranging from single-task means
    % Final 'line' connecting the triangle defined by limits
    SINGLE_PERIPHERAL = Data.ST_Peripheral.Metacognition_MEAN(sub);
    SINGLE_CENTRAL = Data.ST_Central.Metacognition_MEAN(sub);
    DUAL_PERIPHERAL = Data.DT_Peripheral.Metacognition_MEAN(sub);
    DUAL_CENTRAL = Data.DT_Central.Metacognition_MEAN(sub);
    
    % (x1,x2)(y1,y2)
    line([x_limit SINGLE_CENTRAL],[SINGLE_PERIPHERAL SINGLE_PERIPHERAL],'Color',[0 0 0],'LineStyle','-');
    line([SINGLE_CENTRAL SINGLE_CENTRAL],[y_limit SINGLE_PERIPHERAL],'Color',[0 0 0],'LineStyle','-');
    
    % Connecting line
    line([chance_value SINGLE_CENTRAL],[SINGLE_PERIPHERAL chance_value],'Color',[0 0 0],'LineStyle','-'...
        ,'Linewidth',axis_width);
    
    % Find distance between dual-task result and conecting line
    % Find coordinates or intersecting point with connecting line
    [DT_height, x_coord, y_coord, coord_col] = ...
        trade_off(SINGLE_CENTRAL,SINGLE_PERIPHERAL,DUAL_CENTRAL,DUAL_PERIPHERAL,chance_value);
    
    [ST_height, ST_x_coord, ST_y_coord, ST_coord_col] = ...
        trade_off(SINGLE_CENTRAL,SINGLE_PERIPHERAL,SINGLE_CENTRAL,SINGLE_PERIPHERAL,chance_value);
    
    full_span = x_limit+((edges-x_limit)*line_off); % x-coord of data, .075 of limit
    line_fill = ones(num_runs,1)*full_span;
    mean_coord = x_limit+((edges-x_limit)*mean_off); % x-coord of data,
    
    sh = scatter(line_fill,Data.ST_Peripheral.Metacognition_SubByRun(sub,:),...
        mark*8.5,gradData,'filled');
    set(sh,'MarkerEdgeColor','k');
    
    h = errorbar(mean_coord, Data.ST_Peripheral.Metacognition_MEAN(sub),...
        Data.ST_Peripheral.Metacognition_SEM(sub),'ko');
    set(h,'MarkerSize',mark+2,'LineWidth',2);
    set(h,'MarkerFaceColor','w');
    
    if clear_tees
        removeErrorBarEnds(h,0);
    end
    
    if sub == 3
        % set(gca, 'FontSize', 16);
        ylabel('Peripheral Type-II AUC');
    end
    
    % Central data
    
    full_span = y_limit+((edges-y_limit)*line_off);
    line_fill = ones(num_runs,1)*full_span;
    mean_coord = y_limit+((edges-y_limit)*mean_off);
    
    
    sh = scatter(Data.ST_Central.Metacognition_SubByRun(sub,:),line_fill,...
        mark*8.5,gradData,'filled');
    set(sh,'MarkerEdgeColor','k');
    
    h = herrorbar(Data.ST_Central.Metacognition_MEAN(sub), mean_coord,...
        Data.ST_Central.Metacognition_SEM(sub),'ko',clear_tees);
    set(h,'MarkerSize',mark+2,'LineWidth',2)
    set(h,'MarkerFaceColor','w');
    
    if sub == 7
        % set(gca, 'FontSize', 16);
        xlabel('Central Type-II AUC');
    end
    
    % Dual Data
    
    % Scatter of participant's dual-task data
    sh(1) = scatter(Data.DT_Central.Metacognition_SubByRun(sub,:),...
        Data.DT_Peripheral.Metacognition_SubByRun(sub,:),...
        mark*8.5,gradData,'filled');
    set(sh,'MarkerEdgeColor','k');
    
    % 'Target' point representing dual-task means along with SEMs
    h = errorbar(Data.DT_Central.Metacognition_MEAN(sub), Data.DT_Peripheral.Metacognition_MEAN(sub),...
        Data.DT_Peripheral.Metacognition_SEM(sub),'ko');
    set(h,'MarkerSize',mark+2,'LineWidth',2);
    set(h,'MarkerFaceColor','w');
    
    
    if clear_tees
        removeErrorBarEnds(h,0);
    end
    
    h = herrorbar(Data.DT_Central.Metacognition_MEAN(sub), Data.DT_Peripheral.Metacognition_MEAN(sub),...
        Data.DT_Central.Metacognition_SEM(sub),'ko',clear_tees);
    set(h,'MarkerSize',mark+2,'LineWidth',2)
    set(h,'MarkerFaceColor','w');
    
    % From single-task intersect (added 2016-09-01)
    line([ST_x_coord,SINGLE_CENTRAL],[ST_y_coord,SINGLE_PERIPHERAL],'Color','k',...
        'LineStyle',':','Linewidth',axis_width);
    
    % Plot line from chance intersect to dual-task results
    line([x_coord,DUAL_CENTRAL],[y_coord,DUAL_PERIPHERAL],'Color',coord_col,...
        'LineStyle','-','Linewidth',2);
    
    if PDT
        
        % Scatter of participant's partial dual-task data
        sh(1) = scatter(Data.PDT_Central.Metacognition_SubByRun(sub,:),...
            Data.PDT_Peripheral.Metacognition_SubByRun(sub,:),...
            mark*8.5,gradData,'filled','s');
        set(sh,'MarkerEdgeColor','k');
        
        % 'Target' point representing partial dual-task means along with SEMs
        h = errorbar(Data.PDT_Central.Metacognition_MEAN(sub), Data.PDT_Peripheral.Metacognition_MEAN(sub),...
            Data.PDT_Peripheral.Metacognition_SEM(sub),'ks');
        set(h,'MarkerSize',mark+2,'LineWidth',2);
        set(h,'MarkerFaceColor','w');
        
        if clear_tees
            removeErrorBarEnds(h,0);
        end
        
        h = herrorbar(Data.PDT_Central.Metacognition_MEAN(sub), Data.PDT_Peripheral.Metacognition_MEAN(sub),...
            Data.PDT_Central.Metacognition_SEM(sub),'ks',clear_tees);
        set(h,'MarkerSize',mark+2,'LineWidth',2)
        set(h,'MarkerFaceColor','w');
        
    end
    
    OffsetAxes
    
    axis equal
    
    hold off
    
end

%% PLOT GROUP DATA (1,1) - METACOGNITION
% Calculated separately for each block - points gradient shifted over time
% Single-task results presented along (x,y) axes, dual-task within centre

% Set new limits to maximise space for group data
% y_limit = 0.45;
% x_limit = y_limit;
% edges = .85;

% Peripheral data
subplot('position',[plot_2_x(1),plot_2_y(1),big_W,big_H])

hold on

% Find edges of axis, bit greater than ST or DT overall maximum
max_vector = [mean(Data.ST_Peripheral.Metacognition_SubByRun,1),...
    mean(Data.ST_Central.Metacognition_SubByRun,1),...
    mean(Data.DT_Peripheral.Metacognition_SubByRun,1),...
    mean(Data.DT_Central.Metacognition_SubByRun,1)];
max_vector = reshape(max_vector,1,[]);
edges = max(max_vector) + edge_further;

% xlim([x_limit edges]);
% ylim([y_limit edges]);
set(gca, 'FontSize', 12);
set(gca,'XTick',[.4 .5 .6 .7]);
set(gca,'YTick',[.4 .5 .6 .7]);
set(gca,'TickDir','out')
set(gca,'Linewidth',axis_width);
set(gca,'Layer','top');

% Fill polygon with 'patch_col' gradient
if patch_yes
    x_patch = [x_limit x_limit chance_value chance_value edges edges x_limit];
    y_patch = [y_limit edges edges chance_value chance_value y_limit y_limit];
    c_patch = zeros(1,3);
    f = fill(x_patch,y_patch,c_patch);
    % set(f,'EdgeColor','none');
    set(f,'EdgeAlpha',0);
    set(f,'FaceColor',[patch_col patch_col patch_col]);
end

% Chance lines
line([x_limit edges],[chance_value chance_value],'Color',[0 0 0],'LineStyle',':','Linewidth',axis_width);
line([chance_value chance_value],[y_limit edges],'Color',[0 0 0],'LineStyle',':','Linewidth',axis_width);

% Comparison 'triangle' ranging from single-task means
% Final 'line' connecting the triangle defined by limits
SINGLE_PERIPHERAL = mean(Data.ST_Peripheral.Metacognition_MEAN);
SINGLE_CENTRAL = mean(Data.ST_Central.Metacognition_MEAN);
DUAL_PERIPHERAL = mean(Data.DT_Peripheral.Metacognition_MEAN);
DUAL_CENTRAL = mean(Data.DT_Central.Metacognition_MEAN);

% (x1,x2)(y1,y2)
line([x_limit SINGLE_CENTRAL],[SINGLE_PERIPHERAL SINGLE_PERIPHERAL],'Color',[0 0 0],'LineStyle','-');
line([SINGLE_CENTRAL SINGLE_CENTRAL],[y_limit SINGLE_PERIPHERAL],'Color',[0 0 0],'LineStyle','-');
% line([chance_value SINGLE_CENTRAL],[SINGLE_PERIPHERAL chance_value],'Color',[0 0 0],'LineStyle','--');

% Find distance between dual-task result and conecting line
% Find coordinates or intersecting point with connecting line
[DT_height, x_coord, y_coord, coord_col] =...
    trade_off(SINGLE_CENTRAL,SINGLE_PERIPHERAL,DUAL_CENTRAL,DUAL_PERIPHERAL,chance_value);
% Perform analysis for single-task means
[ST_height, ST_x_coord, ST_y_coord, ST_coord_col] =...
    trade_off(SINGLE_CENTRAL,SINGLE_PERIPHERAL,SINGLE_CENTRAL,SINGLE_PERIPHERAL,chance_value);

% Coloured lines across chance
% line([x_limit chance_value],[SINGLE_PERIPHERAL SINGLE_PERIPHERAL],'Color',coord_col,'LineWidth',2);
% line([SINGLE_CENTRAL SINGLE_CENTRAL],[y_limit chance_value],'Color',coord_col,'LineWidth',2);
line([chance_value SINGLE_CENTRAL],[SINGLE_PERIPHERAL chance_value],'Color',coord_col,'LineWidth',2);

full_span = x_limit+((edges-x_limit)*line_off);
line_fill = ones(num_runs,1)*full_span;
mean_coord = x_limit+((edges-x_limit)*mean_off);


sh = scatter(line_fill,(mean(Data.ST_Peripheral.Metacognition_SubByRun,1)),...
    mark*8.5,gradData,'filled');
set(sh,'MarkerEdgeColor','k');

h = errorbar(mean_coord, mean(Data.ST_Peripheral.Metacognition_MEAN),...
    mean(Data.ST_Peripheral.Metacognition_SEM),'ko');
set(h,'MarkerSize',mark+2,'LineWidth',2);
set(h,'MarkerFaceColor','w');

if clear_tees
    removeErrorBarEnds(h,0);
end

% Central data

full_span = y_limit+((edges-y_limit)*line_off);
line_fill = ones(num_runs,1)*full_span;
mean_coord = y_limit+((edges-y_limit)*mean_off);

sh = scatter(mean(Data.ST_Central.Metacognition_SubByRun,1),line_fill,...
    mark*8.5,gradData,'filled');
set(sh,'MarkerEdgeColor','k');

h = herrorbar(mean(Data.ST_Central.Metacognition_MEAN), mean_coord,...
    Data.ST_Central.Metacognition_SEM(sub),'ko',clear_tees);
set(h,'MarkerSize',mark+2,'LineWidth',2)
set(h,'MarkerFaceColor','w');

% Dual Data

% Scatter of participant's dual-task data
dualdouble(1) = scatter(mean(Data.DT_Central.Metacognition_SubByRun,1),...
    mean(Data.DT_Peripheral.Metacognition_SubByRun,1),...
    mark*8.5,gradData,'filled');
set(dualdouble,'MarkerEdgeColor','k');

% 'Target' point representing dual-task means along with SEMs
h = errorbar(mean(Data.DT_Central.Metacognition_MEAN), mean(Data.DT_Peripheral.Metacognition_MEAN),...
    mean(Data.DT_Peripheral.Metacognition_SEM),'ko');
set(h,'MarkerSize',mark+2,'LineWidth',2);
set(h,'MarkerFaceColor','w');


if clear_tees
    removeErrorBarEnds(h,0);
end

h = herrorbar(mean(Data.DT_Central.Metacognition_MEAN), mean(Data.DT_Peripheral.Metacognition_MEAN),...
    mean(Data.DT_Central.Metacognition_SEM),'ko',clear_tees);
set(h,'MarkerSize',mark+2,'LineWidth',2)
set(h,'MarkerFaceColor','w');


% Respective line for single-task means
line([ST_x_coord,SINGLE_CENTRAL],[ST_y_coord,SINGLE_PERIPHERAL],'Color','k',...
    'LineStyle',':','Linewidth',2);
% Plot line from chance intersect to dual-task point (height in length)
line([x_coord,DUAL_CENTRAL],[y_coord,DUAL_PERIPHERAL],'Color',coord_col,...
    'LineStyle','-','Linewidth',2);

if PDT
    
    % Scatter of participant's partial dual-task data
    dualsolo(1) = scatter(mean(Data.PDT_Central.Metacognition_SubByRun,1),...
        mean(Data.PDT_Peripheral.Metacognition_SubByRun,1),...
        mark*8.5,gradData,'filled','s');
    set(dualsolo,'MarkerEdgeColor','k');
    
    % 'Target' point representing partial dual-task means along with SEMs
    h = errorbar(mean(Data.PDT_Central.Metacognition_MEAN), mean(Data.PDT_Peripheral.Metacognition_MEAN),...
        mean(Data.PDT_Peripheral.Metacognition_SEM),'ks');
    set(h,'MarkerSize',mark+2,'LineWidth',2);
    set(h,'MarkerFaceColor','w');
    
    if clear_tees
        removeErrorBarEnds(h,0);
    end
    
    h = herrorbar(mean(Data.PDT_Central.Metacognition_MEAN), mean(Data.PDT_Peripheral.Metacognition_MEAN),...
        mean(Data.PDT_Central.Metacognition_SEM),'ks',clear_tees);
    set(h,'MarkerSize',mark+2,'LineWidth',2);
    set(h,'MarkerFaceColor','w');
    
end

OffsetAxes

axis equal

if PDT
    % legend([right wrong],'Correct','Incorrect');
    lh = legend([dualsolo dualdouble],{'Dual-Solo','Dual-Double'},...
        'Position',[(plot_2_x(3)+big_W+(little_mid_w*1.2)),(plot_2_y(3)+(big_W/2)),0.03,0.015]);
    legend('boxoff');
end

labels = cell(1,num_runs);

if RUN_PAIRS == 1
    for run = 1:num_runs
        label_string = sprintf('%d',run);
        labels{run} = ['Set ' label_string];
    end
else
    labels = {'Run 1','Run 2','Run 3','Run 4','Run 5','Run 6','Run 7','Run 8'};
end

% colorbar('YTick',gradData,...
%     'YTickLabel',labels,...
%     'LineWidth',axis_width,...
%     'Position',[(plot_3_x(6)+big_W+little_mid_w),plot_3_y(4),...
%     (little_mid_w/1.2),(big_H+little_H+little_mid_h)]);

% Setup labels in middle of each color band
the_ticks = (0:1/num_runs:1)-(.5/num_runs);
the_ticks = the_ticks(2:end);

ch = colorbar('YTick',the_ticks,...
    'YTickLabel',labels,...
    'LineWidth',axis_width,...
    'Position',[(plot_3_x(6)+big_W+little_mid_w),plot_3_y(4),...
    (little_mid_w/1.2),(big_H+little_H+little_mid_h)]);
set(ch,'TickDir','out')
set(ch,'TickLength',[0 0])

title([Data.Experiment ' Metacognition (n=8)'],'FontSize',16);

hold off

%% SAVE FIGURE

% Save figure
if SAVEIT == 1
    
    if clear_axis == 1
        clear = '_clear';
    elseif clear_axis == 0
        clear = [];
    end
    
    if patch_yes == 1
        patch_string = '_patch';
    elseif patch_yes == 0
        patch_string = [];
    end
    
    saveas(gcf,[FigurePath 'All_Metacognition' patch_string clear],'fig');
    % saveas(gcf,[FigurePath 'All_Metacognition'],'eps');
    
    original_dir = pwd;
    cd(FigurePath)
    
    print([Data.Experiment '_All_Metacognition' patch_string clear],'-depsc','-tiff')
    
    cd(original_dir)
end

close all

end
