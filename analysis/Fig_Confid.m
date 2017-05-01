%% FIG_CONFID: Creates confidence plots
%
% Input: Data, save_flag, PDT_flag, figurepath
%
% Individual subject data (n=8) + group plot are presented in 3x3
% Use individual_analysis.m to create data file

function Fig_Confid(Data,save_flag,PDT_flag,path_flag)
%% GROUP Confidence PLOT

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
chance_value = 1;

% Visibility of the single-task axes (removes labels) 0=no
clear_axis = 0;

% Markersize
mark = 6;

% Axis width
axis_width = 2;

% Define limits of axes (and bounds of mean-value triangle)
y_limit = 0.01;
x_limit = y_limit;
% edges = .95; % Edges set by maximum per subject
edge_further = .05; % Expansion of axis bounds beyond max ST/DT value

% Percent of axis range the single-task points & means are displayed
% Lower equals closer to axis (0.00 = on axis, 1.00 = on border);
line_off = .05; % ST points
mean_off = .10; % ST mean

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
num_runs = size(Data.ST_Central.Confidence_SubByRun,2);

% Edge colour is sustained but fill cycles as listed
right_col = 'b'; % Fill cycles green to blue
wrong_col = 'r'; % Fill cycles yellow to red

right_map = 'winter';
wrong_map = 'autumn';

% Define gradient colormap for marker face colours
gradData = linspace(0,1,num_runs*2);

% GradData counts backwards (lighter to darker to represent passage of
% time) therefore first half is for incorrect choices
gradient_incorrect = gradData(1:num_runs);

% GradData counts backwards (lighter to darker to represent passage of
% time) therefore second half is for correct choices
gradient_correct = gradData(num_runs+1:end);

colormap([autumn(num_runs);winter(num_runs)])

% Analysis to be performed individually for each participant
for sub = 1:Data.Subjects
    %% INDIVIDUAL PLOTS - Emphasizes changes (or lack there-of) over blocks
    % Confidence
    % Calculated separately for each block - points gradient shifted over time
    % Single-task results presented along (x,y) axes, dual-task within centre
    
    % Peripheral data
    subplot('position',[plot_2_x(sub+1),plot_2_y(sub+1),big_W,big_H])
    
    hold on
    
    % Find edges of axis, bit greater than ST or DT overall maximum
    max_vector = [Data.ST_Peripheral.Confidence_SubByRun(sub,:),...
        Data.ST_Central.Confidence_SubByRun(sub,:),...
        Data.DT_Peripheral.Confidence_SubByRun(sub,:),...
        Data.DT_Central.Confidence_SubByRun(sub,:)];
    edges = max(max_vector) + edge_further;
    
    % Limiting axes causes issues with OffsetAxes.m
    % xlim([x_limit edges]);
    % ylim([y_limit edges]);
    set(gca, 'FontSize', 12);
    set(gca,'XTick',[0 1 2 3 4 ]);
    set(gca,'YTick',[0 1 2 3 4 ]);
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
    SINGLE_PERIPHERAL = Data.ST_Peripheral.Confidence_MEAN(sub);
    SINGLE_CENTRAL = Data.ST_Central.Confidence_MEAN(sub);
    DUAL_PERIPHERAL = Data.DT_Peripheral.Confidence_MEAN(sub);
    DUAL_CENTRAL = Data.DT_Central.Confidence_MEAN(sub);
    
    % Correct
    SINGLE_PERIPHERAL = Data.ST_Peripheral.Confidence_MEAN_correct(sub);
    SINGLE_CENTRAL = Data.ST_Central.Confidence_MEAN_correct(sub);
    
    line([x_limit SINGLE_CENTRAL],[SINGLE_PERIPHERAL SINGLE_PERIPHERAL],'Color',[0 0 1],'LineStyle','-');
    line([SINGLE_CENTRAL SINGLE_CENTRAL],[y_limit SINGLE_PERIPHERAL],'Color',[0 0 1],'LineStyle','-');
    line([chance_value SINGLE_CENTRAL],[SINGLE_PERIPHERAL chance_value],'Color',[0 0 1],'LineStyle','-');
    
    % Incorrect
    SINGLE_PERIPHERAL = Data.ST_Peripheral.Confidence_MEAN_incorrect(sub);
    SINGLE_CENTRAL = Data.ST_Central.Confidence_MEAN_incorrect(sub);
    
    line([x_limit SINGLE_CENTRAL],[SINGLE_PERIPHERAL SINGLE_PERIPHERAL],'Color',[1 0 0],'LineStyle','--');
    line([SINGLE_CENTRAL SINGLE_CENTRAL],[y_limit SINGLE_PERIPHERAL],'Color',[1 0 0],'LineStyle','--');
    line([chance_value SINGLE_CENTRAL],[SINGLE_PERIPHERAL chance_value],'Color',[1 0 0],'LineStyle','--');
    
    % Find distance between dual-task result and conecting line
    % Find coordinates or intersecting point with connecting line
    %     [DT_height, x_coord, y_coord, coord_col] = ...
    %         trade_off(SINGLE_CENTRAL,SINGLE_PERIPHERAL,DUAL_CENTRAL,DUAL_PERIPHERAL);
    %
    %     [ST_height, ST_x_coord, ST_y_coord, ST_coord_col] = ...
    %         trade_off(SINGLE_CENTRAL,SINGLE_PERIPHERAL,SINGLE_CENTRAL,SINGLE_PERIPHERAL);
    
    %% PERIPHERAL DATA
    
    full_span = x_limit+((edges-x_limit)*line_off); % x-coord of data, .075 of limit
    line_fill = ones(num_runs,1)*full_span;
    mean_coord = x_limit+((edges-x_limit)*line_off*2); % x-coord of data,
    
    % Define location/offset of single-task results for correct/incorrect
    new_span = x_limit+((edges-x_limit)*line_off*3);
    line_fill_back = ones(num_runs,1)*new_span;
    mean_coord_back = x_limit+((edges-x_limit)*line_off*4);
    
    con_i = scatter(line_fill_back,Data.ST_Peripheral.Confidence_SubByRun_incorrect(sub,:),...
        mark*8.5,gradient_incorrect,'filled');
    set(con_i,'MarkerEdgeColor',wrong_col);
    set(con_i,'Marker','^');
    
    con_c = scatter(line_fill,Data.ST_Peripheral.Confidence_SubByRun_correct(sub,:),...
        mark*8.5,gradient_correct,'filled');
    set(con_c,'MarkerEdgeColor',right_col);
    
    %     h = errorbar(mean_coord, Data.ST_Peripheral.Confidence_MEAN_incorrect(sub),...
    %         Data.ST_Peripheral.Confidence_SEM_incorrect(sub),[wrong_col '^']);
    h = errorbar(mean_coord_back, Data.ST_Peripheral.Confidence_MEAN_incorrect(sub),...
        Data.ST_Peripheral.Confidence_SEM_incorrect(sub),'k^');
    set(h,'MarkerSize',mark,'LineWidth',2);
    set(h,'MarkerFaceColor',wrong_col);
    
    if clear_tees
        removeErrorBarEnds(h,0);
    end
    
    %     h = errorbar(mean_coord_back, Data.ST_Peripheral.Confidence_MEAN_correct(sub),...
    %         Data.ST_Peripheral.Confidence_SEM_correct(sub),[right_col 'o']);
    h = errorbar(mean_coord, Data.ST_Peripheral.Confidence_MEAN_correct(sub),...
        Data.ST_Peripheral.Confidence_SEM_correct(sub),'ko');
    set(h,'MarkerSize',mark,'LineWidth',2);
    set(h,'MarkerFaceColor',right_col);
    
    if clear_tees
        removeErrorBarEnds(h,0);
    end
    
    if sub == 3
        ylabel('Peripheral Confidence');
    end
    
    %% CENTRAL DATA
    
    full_span = y_limit+((edges-y_limit)*line_off);
    line_fill = ones(num_runs,1)*full_span;
    mean_coord = y_limit+((edges-y_limit)*line_off*2);
    
    % Define location/offset of single-task results for correct/incorrect
    new_span = y_limit+((edges-y_limit)*line_off*3);
    line_fill_back = ones(num_runs,1)*new_span;
    mean_coord_back = y_limit+((edges-y_limit)*line_off*4);
    
    con_i = scatter(Data.ST_Central.Confidence_SubByRun_incorrect(sub,:),line_fill_back,...
        mark*8.5,gradient_incorrect,'filled');
    set(con_i,'MarkerEdgeColor',wrong_col);
    set(con_i,'Marker','^');
    
    con_c = scatter(Data.ST_Central.Confidence_SubByRun_correct(sub,:),line_fill,...
        mark*8.5,gradient_correct,'filled');
    set(con_c,'MarkerEdgeColor',right_col);
    
    %     h = herrorbar(Data.ST_Central.Confidence_MEAN_incorrect(sub), mean_coord,...
    %         Data.ST_Central.Confidence_SEM_incorrect(sub),[wrong_col '^'], clear_tees);
    h = herrorbar(Data.ST_Central.Confidence_MEAN_incorrect(sub), mean_coord_back,...
        Data.ST_Central.Confidence_SEM_incorrect(sub),'k^', clear_tees);
    set(h,'MarkerSize',mark,'LineWidth',2)
    set(h,'MarkerFaceColor',wrong_col);
    
    %     h = herrorbar(Data.ST_Central.Confidence_MEAN_correct(sub), mean_coord_back,...
    %         Data.ST_Central.Confidence_SEM_correct(sub),[right_col 'o'], clear_tees);
    h = herrorbar(Data.ST_Central.Confidence_MEAN_correct(sub), mean_coord,...
        Data.ST_Central.Confidence_SEM_correct(sub),'ko', clear_tees);
    set(h,'MarkerSize',mark,'LineWidth',2)
    set(h,'MarkerFaceColor',right_col);
    
    if sub == 7
        xlabel('Central Confidence');
    end
    
    %% DUAL DATA
    
    % Scatter of participant's dual-task data
    
    wrong = scatter(Data.DT_Central.Confidence_SubByRun_incorrect(sub,:),...
        Data.DT_Peripheral.Confidence_SubByRun_incorrect(sub,:),...
        mark*8.5,gradient_incorrect,'filled');
    set(wrong,'MarkerEdgeColor',wrong_col);
    set(wrong,'Marker','^');
    
    right = scatter(Data.DT_Central.Confidence_SubByRun_correct(sub,:),...
        Data.DT_Peripheral.Confidence_SubByRun_correct(sub,:),...
        mark*8.5,gradient_correct,'filled');
    set(right,'MarkerEdgeColor',right_col);
    
    % 'Target' point representing dual-task means along with SEMs
    %     h = errorbar(Data.DT_Central.Confidence_MEAN_incorrect(sub), Data.DT_Peripheral.Confidence_MEAN_incorrect(sub),...
    %         Data.DT_Peripheral.Confidence_SEM_incorrect(sub),[wrong_col '^']);
    h = errorbar(Data.DT_Central.Confidence_MEAN_incorrect(sub), Data.DT_Peripheral.Confidence_MEAN_incorrect(sub),...
        Data.DT_Peripheral.Confidence_SEM_incorrect(sub),'k^');
    set(h,'MarkerSize',mark+2,'LineWidth',2);
    set(h,'MarkerFaceColor',wrong_col);
    
    if clear_tees
        removeErrorBarEnds(h,0);
    end
    
    %     h = herrorbar(Data.DT_Central.Confidence_MEAN_incorrect(sub), Data.DT_Peripheral.Confidence_MEAN_incorrect(sub),...
    %         Data.DT_Central.Confidence_SEM_incorrect(sub),[wrong_col '^'], clear_tees);
    h = herrorbar(Data.DT_Central.Confidence_MEAN_incorrect(sub), Data.DT_Peripheral.Confidence_MEAN_incorrect(sub),...
        Data.DT_Central.Confidence_SEM_incorrect(sub),'k^', clear_tees);
    set(h,'MarkerSize',mark+2,'LineWidth',2)
    set(h,'MarkerFaceColor',wrong_col);
    
    %     h = errorbar(Data.DT_Central.Confidence_MEAN_correct(sub), Data.DT_Peripheral.Confidence_MEAN_correct(sub),...
    %         Data.DT_Peripheral.Confidence_SEM_correct(sub),[right_col 'o']);
    h = errorbar(Data.DT_Central.Confidence_MEAN_correct(sub), Data.DT_Peripheral.Confidence_MEAN_correct(sub),...
        Data.DT_Peripheral.Confidence_SEM_correct(sub),'ko');
    set(h,'MarkerSize',mark+2,'LineWidth',2);
    set(h,'MarkerFaceColor',right_col);
    
    if clear_tees
        removeErrorBarEnds(h,0);
    end
    
    %     h = herrorbar(Data.DT_Central.Confidence_MEAN_correct(sub), Data.DT_Peripheral.Confidence_MEAN_correct(sub),...
    %         Data.DT_Central.Confidence_SEM_correct(sub),[right_col 'o'], clear_tees);
    h = herrorbar(Data.DT_Central.Confidence_MEAN_correct(sub), Data.DT_Peripheral.Confidence_MEAN_correct(sub),...
        Data.DT_Central.Confidence_SEM_correct(sub),'ko', clear_tees);
    set(h,'MarkerSize',mark+2,'LineWidth',2)
    set(h,'MarkerFaceColor',right_col);
    
    if PDT
        
        % Might include stuff with PDT here, plots already very busy
        
    end
    
    OffsetAxes_special
    
    axis equal
    
    hold off
    
end

%% PLOT GROUP DATA (1,1) - Confidence
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
max_vector = [mean(Data.ST_Peripheral.Confidence_SubByRun,1),...
    mean(Data.ST_Central.Confidence_SubByRun,1),...
    mean(Data.DT_Peripheral.Confidence_SubByRun,1),...
    mean(Data.DT_Central.Confidence_SubByRun,1)];
max_vector = reshape(max_vector,1,[]);
edges = max(max_vector) + edge_further;

% xlim([x_limit edges]);
% ylim([y_limit edges]);
set(gca, 'FontSize', 12);
set(gca,'XTick',[0 1 2 3 ]);
set(gca,'YTick',[0 1 2 3 ]);
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
% Correct
SINGLE_PERIPHERAL = mean(Data.ST_Peripheral.Confidence_MEAN_correct);
SINGLE_CENTRAL = mean(Data.ST_Central.Confidence_MEAN_correct);

line([x_limit SINGLE_CENTRAL],[SINGLE_PERIPHERAL SINGLE_PERIPHERAL],'Color',[0 0 1],'LineStyle','-');
line([SINGLE_CENTRAL SINGLE_CENTRAL],[y_limit SINGLE_PERIPHERAL],'Color',[0 0 1],'LineStyle','-');
line([chance_value SINGLE_CENTRAL],[SINGLE_PERIPHERAL chance_value],'Color',[0 0 1],'LineStyle','-');

% Incorrect
SINGLE_PERIPHERAL = mean(Data.ST_Peripheral.Confidence_MEAN_incorrect);
SINGLE_CENTRAL = mean(Data.ST_Central.Confidence_MEAN_incorrect);

line([x_limit SINGLE_CENTRAL],[SINGLE_PERIPHERAL SINGLE_PERIPHERAL],'Color',[1 0 0],'LineStyle','--');
line([SINGLE_CENTRAL SINGLE_CENTRAL],[y_limit SINGLE_PERIPHERAL],'Color',[1 0 0],'LineStyle','--');
line([chance_value SINGLE_CENTRAL],[SINGLE_PERIPHERAL chance_value],'Color',[1 0 0],'LineStyle','--');

% Find distance between dual-task result and conecting line
% Find coordinates or intersecting point with connecting line
% [DT_height, x_coord, y_coord, coord_col] =...
%     trade_off(SINGLE_CENTRAL,SINGLE_PERIPHERAL,DUAL_CENTRAL,DUAL_PERIPHERAL);
% % Perform analysis for single-task means
% [ST_height, ST_x_coord, ST_y_coord, ST_coord_col] =...
%     trade_off(SINGLE_CENTRAL,SINGLE_PERIPHERAL,SINGLE_CENTRAL,SINGLE_PERIPHERAL);

%% PERIPHERAL DATA

full_span = x_limit+((edges-x_limit)*line_off); % x-coord of data, .075 of limit
line_fill = ones(num_runs,1)*full_span;
mean_coord = x_limit+((edges-x_limit)*line_off*2); % x-coord of data,

% Define location/offset of single-task results for correct/incorrect
new_span = x_limit+((edges-x_limit)*line_off*3);
line_fill_back = ones(num_runs,1)*new_span;
mean_coord_back = x_limit+((edges-x_limit)*line_off*4);

con_i = scatter(line_fill_back,mean(Data.ST_Peripheral.Confidence_SubByRun_incorrect,1),...
    mark*8.5,gradient_incorrect,'filled');
set(con_i,'MarkerEdgeColor',wrong_col);
set(con_i,'Marker','^');

con_c = scatter(line_fill,mean(Data.ST_Peripheral.Confidence_SubByRun_correct,1),...
    mark*8.5,gradient_correct,'filled');
set(con_c,'MarkerEdgeColor',right_col);

h = errorbar(mean_coord_back, mean(Data.ST_Peripheral.Confidence_MEAN_incorrect),...
    mean(Data.ST_Peripheral.Confidence_SEM_incorrect),'k^');
set(h,'MarkerSize',mark,'LineWidth',2);
set(h,'MarkerFaceColor',wrong_col);

if clear_tees
    removeErrorBarEnds(h,0);
end

h = errorbar(mean_coord, mean(Data.ST_Peripheral.Confidence_MEAN_correct),...
    mean(Data.ST_Peripheral.Confidence_SEM_correct),'ko');
set(h,'MarkerSize',mark,'LineWidth',2);
set(h,'MarkerFaceColor',right_col);

if clear_tees
    removeErrorBarEnds(h,0);
end

%% CENTRAL DATA

full_span = y_limit+((edges-y_limit)*line_off);
line_fill = ones(num_runs,1)*full_span;
mean_coord = y_limit+((edges-y_limit)*line_off*2);

% Define location/offset of single-task results for correct/incorrect
new_span = y_limit+((edges-y_limit)*line_off*3);
line_fill_back = ones(num_runs,1)*new_span;
mean_coord_back = y_limit+((edges-y_limit)*line_off*4);

con_i = scatter(mean(Data.ST_Central.Confidence_SubByRun_incorrect,1),line_fill_back,...
    mark*8.5,gradient_incorrect,'filled');
set(con_i,'MarkerEdgeColor',wrong_col);
set(con_i,'Marker','^');

con_c = scatter(mean(Data.ST_Central.Confidence_SubByRun_correct,1),line_fill,...
    mark*8.5,gradient_correct,'filled');
set(con_c,'MarkerEdgeColor',right_col);

h = herrorbar(mean(Data.ST_Central.Confidence_MEAN_incorrect), mean_coord_back,...
    mean(Data.ST_Central.Confidence_SEM_incorrect),'k^',clear_tees);
set(h,'MarkerSize',mark,'LineWidth',2)
set(h,'MarkerFaceColor',wrong_col);

h = herrorbar(mean(Data.ST_Central.Confidence_MEAN_correct),mean_coord,...
    mean(Data.ST_Central.Confidence_SEM_correct),'ko',clear_tees);
set(h,'MarkerSize',mark,'LineWidth',2)
set(h,'MarkerFaceColor',right_col);

%% DUAL DATA

wrong = scatter(mean(Data.DT_Central.Confidence_SubByRun_incorrect,1),...
    mean(Data.DT_Peripheral.Confidence_SubByRun_incorrect,1),...
    mark*8.5,gradient_incorrect,'filled');
set(wrong,'MarkerEdgeColor',wrong_col);
set(wrong,'Marker','^');

right = scatter(mean(Data.DT_Central.Confidence_SubByRun_correct,1),...
    mean(Data.DT_Peripheral.Confidence_SubByRun_correct,1),...
    mark*8.5,gradient_correct,'filled');
set(right,'MarkerEdgeColor',right_col);

% 'Target' point representing dual-task means along with SEMs
h = errorbar(mean(Data.DT_Central.Confidence_MEAN_incorrect), mean(Data.DT_Peripheral.Confidence_MEAN_incorrect),...
    mean(Data.DT_Peripheral.Confidence_SEM_incorrect),'k^');
set(h,'MarkerSize',mark+2,'LineWidth',2);
set(h,'MarkerFaceColor',wrong_col);

if clear_tees
    removeErrorBarEnds(h,0);
end

h = herrorbar(mean(Data.DT_Central.Confidence_MEAN_incorrect), mean(Data.DT_Peripheral.Confidence_MEAN_incorrect),...
    mean(Data.DT_Central.Confidence_SEM_incorrect),'k^',clear_tees);
set(h,'MarkerSize',mark+2,'LineWidth',2)
set(h,'MarkerFaceColor',wrong_col);

h = errorbar(mean(Data.DT_Central.Confidence_MEAN_correct), mean(Data.DT_Peripheral.Confidence_MEAN_correct),...
    mean(Data.DT_Peripheral.Confidence_SEM_correct),'ko');
set(h,'MarkerSize',mark+2,'LineWidth',2);
set(h,'MarkerFaceColor',right_col);

if clear_tees
    removeErrorBarEnds(h,0);
end

h = herrorbar(mean(Data.DT_Central.Confidence_MEAN_correct), mean(Data.DT_Peripheral.Confidence_MEAN_correct),...
    mean(Data.DT_Central.Confidence_SEM_correct),'ko',clear_tees);
set(h,'MarkerSize',mark+2,'LineWidth',2)
set(h,'MarkerFaceColor',right_col);

OffsetAxes_special

axis equal

% legend([right wrong],'Correct','Incorrect');
lh = legend([right wrong],{'Correct','Incorrect'},...
    'Position',[(plot_2_x(3)+big_W+(little_mid_w*1.2)),(plot_2_y(3)+(big_W/2)),0.03,0.015]);
legend('boxoff');

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
%     'Position',[(plot_3_x(6)+big_W+(little_mid_w*1.2)),(plot_2_y(9)+big_H),...
%     (little_mid_w*1.1),((big_H)+little_H+(2*big_mid_h)+little_mid_h)]);

% Setup labels in middle of each color band
the_ticks = (0:1/(num_runs*2):1)-(.5/(num_runs*2));
the_ticks = the_ticks(2:end);

ch = colorbar('YTick',the_ticks,...
    'YTickLabel',labels,...
    'LineWidth',axis_width,...
    'Position',[(plot_3_x(6)+big_W+little_mid_w),plot_3_y(4),...
    (little_mid_w/1.2),(big_H+little_H+little_mid_h)]);
set(ch,'TickDir','out')
set(ch,'TickLength',[0 0])

title([Data.Experiment ' Confidence (n=8)'],'FontSize',16);

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
    
    saveas(gcf,[FigurePath 'All_Confidence' patch_string clear],'fig');
    % saveas(gcf,[FigurePath 'All_Confidence'],'eps');
    
    original_dir = pwd;
    cd(FigurePath)
    
    print([Data.Experiment '_All_Confidence' patch_string clear],'-depsc','-tiff')
    
    cd(original_dir)
end

close all

end

function OffsetAxes_special(h,drawXYs)
drawXY = 'XY';

if nargin == 2
    drawXY = drawXYs;
end
if nargin == 0
    h=gca;
end

set(h, 'Visible', 'off');

set(get(h,'Xlabel'),'Visible','off');
set(get(h,'Ylabel'),'Visible','off');


% do automatic rescaling if axis are not manually adjusted
xlimmode    = get(gca,'XLimMode');
ylimmode    = get(gca,'YLimMode');
if strcmp(xlimmode,'auto')
    xtickpos    = get(h,'Xtick');
    xticklims   = [min(xtickpos) max(xtickpos)];
    xtickstep   = xtickpos(2)-xtickpos(1);
    set(h,'Xlim',[xticklims(1)-0.8*xtickstep (xticklims(2)+0.8*xtickstep)+0.01]);
end
if strcmp(ylimmode,'auto')
    ytickpos    = get(h,'Ytick');
    yticklims   = [min(ytickpos) max(ytickpos)];
    ytickstep   = ytickpos(2)-ytickpos(1);
    set(h,'Ylim',[yticklims(1)-0.8*ytickstep yticklims(2)+0.01]);
end
xxlim = get(gca,'Xlim');
set(h,'Xlim',[xxlim(1) xxlim(2)*1.01]);
yylim = get(gca,'Ylim');
set(h,'Ylim',[yylim(1) yylim(2)*1.01]);

%%%% take new measurements after rescaling
xtickpos    = get(h,'Xtick');
ytickpos    = get(h,'Ytick');
xlimit      = get(h,'Xlim');
ylimit      = get(h,'Ylim');
xlabels     = get(h,'XTickLabel');
ylabels     = get(h,'YTickLabel');

% Special update 2016-09-13 (Julian)
% Removes the 'zero' confidence rating but retains axes
xtickpos = xtickpos(2:end);
ytickpos = ytickpos(2:end);
xlabels = xlabels(2:end);
ylabels = ylabels(2:end);

linewidth   = get(h,'LineWidth');
fontsize    = get(h,'FontSize');

%position    = get(gcf,'Position');
positiona   = get(h,'Position');

tickdirin   = strcmp(get(gca,'TickDir'),'in');
xticklims   = [min(xtickpos) max(xtickpos)];
yticklims   = [min(ytickpos) max(ytickpos)];



xrange      = diff(xlimit);
yrange      = diff(ylimit);
xlimmin     = min(xlimit)+0.01*xrange;
ylimmin     = min(ylimit);

xaxis_ypos  = ylimmin;% ytickpos(1);
%figsize    = position(3:4);

ticklength  = [xrange/70/positiona(3) yrange/80/positiona(4)];%get(h,'TickLength');
xaxis_labeloffset = -1*[xrange/50 yrange/50];

% reposition y axis on new (shorter) y-axis
posy        = get(get(h,'Ylabel'),'Position');
posy(2)     = yticklims(1) +diff(yticklims)/2;



%Delete the current offset axes, before drawing new ones
delete(findobj(h,'Tag','offset_xaxis'));
delete(findobj(h,'Tag','offset_yaxis'));

if any(drawXY=='X')
    x_handles = hggroup('Tag','offset_xaxis');
    if tickdirin
        line('Xdata',xticklims,'Ydata',[xaxis_ypos xaxis_ypos],'LineWidth',linewidth,'Parent',x_handles);
    else
        line('Xdata',xticklims,'Ydata',[xaxis_ypos+ticklength(2) xaxis_ypos+ticklength(2)],'LineWidth',linewidth,'Parent',x_handles);
    end
    if ischar(xlabels)
        xlabels = cellstr(xlabels);
    end
    for tt = xtickpos
        line('Xdata',[tt tt],'Ydata',[xaxis_ypos xaxis_ypos+ticklength(2)],'LineWidth',linewidth/2,'Parent',x_handles);
    end
    for i=1:length(xlabels)
        text(xtickpos(i),xaxis_ypos,xlabels{i},'VerticalAlignment','top','HorizontalAlignment','center','FontSize',fontsize,'Parent',x_handles);
    end
    set(get(h,'Xlabel'),'Visible','on');
end


if any(drawXY=='Y')
    y_handles = hggroup('Tag','offset_yaxis');
    if tickdirin
        line('Xdata',[xlimmin xlimmin],'Ydata',yticklims,'LineWidth',linewidth,'Parent',y_handles);
    else
        line('Xdata',[xlimmin+ticklength(1) xlimmin+ticklength(1)],'Ydata',yticklims,'LineWidth',linewidth,'Parent',y_handles);
    end
    for tt = ytickpos
        line('Xdata',[xlimmin xlimmin+ticklength(1)],'Ydata',[tt tt],'LineWidth',linewidth/2,'Parent',y_handles);
    end
    if ischar(ylabels)
        ylabels = cellstr(ylabels);
    end
    for i=1:length(ytickpos)
        text(xlimmin+0.2*xaxis_labeloffset(1)/positiona(3),ytickpos(i),ylabels{i},'HorizontalAlignment','right','FontSize',fontsize,'Parent',y_handles);
    end
    set(get(h,'Ylabel'),'Visible','on');
    set(get(gca,'Ylabel'), 'Position', posy);
end

set(get(h,'Title'),'Visible','on');

try
    allchildren=get(h,'Children');
    set(allchildren(end),'ShowBaseLine','off');
catch
end

end

