%% 2016-05-11 GLOBAL_ANALYSIS
% Concantenates objective performance, confidence, and metacognition data
% for either/both gender and disk dual-task experiments. Specify which
% experiment you wish to analyse by inputting (1) into the appropriate

function Indi = individual_analysis(run_gender,run_disks,red_flag)

% Optional 'red_flag' input for averaging over runs
% This cleans up data for plotting but default is /not/ to reduce
reduce = 0;

if nargin == 3
    reduce = red_flag;
end

addpath('./remaining_files');

% Number of runs over which means are calculated/etc. This is fixed for our
% experiment at 8 for each task condition
if reduce == 1
    run_total = 4; 
else
    run_total = 8;
end

if run_gender == 1 && run_disks == 1
    which_one = input('Gender or Disk task? G/D:','s');
    
    if strcmp(which_one,'g') || strcmp(which_one,'G')
        run_disks = 0;
    elseif strcmp(which_one,'d') || strcmp(which_one,'D')
        run_gender = 0;
    end
    
end

if run_gender == 1
    
    Exp = 'Exp1/';
    Type = 'Gender';
    Partial_report = 0;
    
elseif run_disks == 1
    
    Exp = 'Exp2/';
    Type = 'Disk';
    Partial_report = 1;
    
end

Path = ['../data/blockwise/' Exp];

% Load this experiment's 'Files' variable
load([Path 'central_data.mat'], 'Files');

Indi.Experiment = Type;
Indi.Subjects = length(Files);

if reduce == 1
    [that.confidence, that.truth] = collect_confidence_objective(Files,Exp);
    [~,~,that.correct] = collect_confidence(Files,Exp);
else
    [Indi.confidence, Indi.truth] = collect_confidence_objective(Files,Exp);
    [~,~,Indi.correct] = collect_confidence(Files,Exp);
end

%% REMOVE FIRST TWO RUNS OF TRIALS FOR SINGLE-TASK EXPERIMENTS

if reduce == 1
    that.confidence.SC = that.confidence.SC(:,(3:end),:);
    that.truth.SC = that.truth.SC(:,(3:end),:);
    that.correct.SC = that.correct.SC(:,(3:end),:);
    
    that.confidence.SP = that.confidence.SP(:,(3:end),:);
    that.truth.SP = that.truth.SP(:,(3:end),:);
    that.correct.SP = that.correct.SP(:,(3:end),:);
else
    Indi.confidence.SC = Indi.confidence.SC(:,(3:end),:);
    Indi.truth.SC = Indi.truth.SC(:,(3:end),:);
    Indi.correct.SC = Indi.correct.SC(:,(3:end),:);
    
    Indi.confidence.SP = Indi.confidence.SP(:,(3:end),:);
    Indi.truth.SP = Indi.truth.SP(:,(3:end),:);
    Indi.correct.SP = Indi.correct.SP(:,(3:end),:);
end

%% IF REDUCING FIGURES, CONCATENATE COLUMNS TO (?? x 4 x subjects)
if reduce == 1
    for s = 1:Indi.Subjects
       Indi.confidence.SC(:,:,s) = reshape(that.confidence.SC(:,:,s),[],4);
       Indi.truth.SC(:,:,s) = reshape(that.truth.SC(:,:,s),[],4);
       Indi.correct.SC(:,:,s) = reshape(that.correct.SC(:,:,s),[],4);
       
       Indi.confidence.SP(:,:,s) = reshape(that.confidence.SP(:,:,s),[],4);
       Indi.truth.SP(:,:,s) = reshape(that.truth.SP(:,:,s),[],4);
       Indi.correct.SP(:,:,s) = reshape(that.correct.SP(:,:,s),[],4);
       
       Indi.confidence.DC(:,:,s) = reshape(that.confidence.DC(:,:,s),[],4);
       Indi.truth.DC(:,:,s) = reshape(that.truth.DC(:,:,s),[],4);
       Indi.correct.DC(:,:,s) = reshape(that.correct.DC(:,:,s),[],4);
       
       Indi.confidence.DP(:,:,s) = reshape(that.confidence.DP(:,:,s),[],4);
       Indi.truth.DP(:,:,s) = reshape(that.truth.DP(:,:,s),[],4);
       Indi.correct.DP(:,:,s) = reshape(that.correct.DP(:,:,s),[],4);
       
       if Partial_report
          
           Indi.confidence.PDC(:,:,s) = reshape(that.confidence.PDC(:,:,s),[],4);
           Indi.truth.PDC(:,:,s) = reshape(that.truth.PDC(:,:,s),[],4);
           Indi.correct.PDC(:,:,s) = reshape(that.correct.PDC(:,:,s),[],4);
           
           Indi.confidence.PDP(:,:,s) = reshape(that.confidence.PDP(:,:,s),[],4);
           Indi.truth.PDP(:,:,s) = reshape(that.truth.PDP(:,:,s),[],4);
           Indi.correct.PDP(:,:,s) = reshape(that.correct.PDP(:,:,s),[],4);
           
       end
    end
end
    
% CALCULATE MEAN value FOR EACH SUBJECT THEN GLOBAL Exp1/2 MEAN FOR value
%% CONFIDENCE - dual task central vs. peripheral (x vs. y)

for s = 1:Indi.Subjects
    for run = 1:run_total
        % Mean absolute confidence for each subject across all trials
        temp.dc_confidence(s,run) = mean(nanmean(abs(Indi.confidence.DC(:,run,s))));
        temp.dp_confidence(s,run) = mean(nanmean(abs(Indi.confidence.DP(:,run,s))));
        
        temp.dc_confidence_correct(s,run) = ...
            mean(nanmean(abs(Indi.confidence.DC(Indi.correct.DC(:,run,s)==1,run,s))));
        temp.dc_confidence_incorrect(s,run) = ...
            mean(nanmean(abs(Indi.confidence.DC(Indi.correct.DC(:,run,s)==0,run,s))));
        
        temp.dp_confidence_correct(s,run) = ...
            mean(nanmean(abs(Indi.confidence.DP(Indi.correct.DP(:,run,s)==1,run,s))));
        temp.dp_confidence_incorrect(s,run) = ...
            mean(nanmean(abs(Indi.confidence.DP(Indi.correct.DP(:,run,s)==0,run,s))));
    end
end

if Partial_report
    
    for s = 1:Indi.Subjects
        for run = 1:run_total
            temp.pdc_confidence(s,run) = mean(nanmean(abs(Indi.confidence.PDC(:,run,s))));
            temp.pdp_confidence(s,run) = mean(nanmean(abs(Indi.confidence.PDP(:,run,s))));
            
            temp.pdc_confidence_correct(s,run) = ...
                mean(nanmean(abs(Indi.confidence.PDC(Indi.correct.PDC(:,run,s)==1,run,s))));
            temp.pdc_confidence_incorrect(s,run) = ...
                mean(nanmean(abs(Indi.confidence.PDC(Indi.correct.PDC(:,run,s)==0,run,s))));
            
            temp.pdp_confidence_correct(s,run) = ...
                mean(nanmean(abs(Indi.confidence.PDP(Indi.correct.PDP(:,run,s)==1,run,s))));
            temp.pdp_confidence_incorrect(s,run) = ...
                mean(nanmean(abs(Indi.confidence.PDP(Indi.correct.PDP(:,run,s)==0,run,s))));
        
        end
    end
end

% For single-trial experiments first run is excluded

for s = 1:Indi.Subjects
    for run = 1:run_total
        temp.sc_confidence(s,run) = mean(nanmean(abs(Indi.confidence.SC(:,run,s))));
        temp.sp_confidence(s,run) = mean(nanmean(abs(Indi.confidence.SP(:,run,s))));
        
        temp.sc_confidence_correct(s,run) = ...
            mean(nanmean(abs(Indi.confidence.SC(Indi.correct.SC(:,run,s)==1,run,s))));
        temp.sc_confidence_incorrect(s,run) = ...
            mean(nanmean(abs(Indi.confidence.SC(Indi.correct.SC(:,run,s)==0,run,s))));
        
        temp.sp_confidence_correct(s,run) = ...
            mean(nanmean(abs(Indi.confidence.SP(Indi.correct.SP(:,run,s)==1,run,s))));
        temp.sp_confidence_incorrect(s,run) = ...
            mean(nanmean(abs(Indi.confidence.SP(Indi.correct.SP(:,run,s)==0,run,s))));
    
    end
end

%% Type I AUC - dual task central vs. peripheral (x vs. y)

% DUAL-TASKS

for s = 1:Indi.Subjects
    for run = 1:run_total
        % Calculate Objective Performance for Dual Central per subject
        signal = [];
        decision = [];
        
        signal = reshape(Indi.truth.DC(:,run,s),[],1);
        decision = reshape(Indi.confidence.DC(:,run,s),[],1);
        signal(isnan(signal)) = []; % Remove NaNs
        decision(isnan(decision)) = [];
        
        [~,~,temp.dc_type1auc(s,run)] = type1auc(signal,decision);
        
        % Calculate Objective Performance for Dual Peripheral per subject
        signal = [];
        decision = [];
        
        signal = reshape(Indi.truth.DP(:,run,s),[],1);
        decision = reshape(Indi.confidence.DP(:,run,s),[],1);
        signal(isnan(signal)) = []; % Remove NaNs
        decision(isnan(decision)) = [];
        
        [~,~,temp.dp_type1auc(s,run)] = type1auc(signal,decision);
    end
end

if Partial_report
    for s = 1:Indi.Subjects
        for run = 1:run_total
            % Calculate Objective Performance for Dual Central per subject
            signal = [];
            decision = [];
            
            signal = reshape(Indi.truth.PDC(:,run,s),[],1);
            decision = reshape(Indi.confidence.PDC(:,run,s),[],1);
            signal(isnan(signal)) = []; % Remove NaNs
            decision(isnan(decision)) = [];
            
            [~,~,temp.pdc_type1auc(s,run)] = type1auc(signal,decision);
            
            % Calculate Objective Performance for Dual Peripheral per subject
            signal = [];
            decision = [];
            
            signal = reshape(Indi.truth.PDP(:,run,s),[],1);
            decision = reshape(Indi.confidence.PDP(:,run,s),[],1);
            signal(isnan(signal)) = []; % Remove NaNs
            decision(isnan(decision)) = [];
            
            [~,~,temp.pdp_type1auc(s,run)] = type1auc(signal,decision);
        end
    end
end

% SINGLE-TASKS
for s = 1:Indi.Subjects
    for run = 1:run_total
        
        % Calculate Objective Performance for ST Central per subject
        signal = [];
        decision = [];
        
        signal = reshape(Indi.truth.SC(:,run,s),[],1);
        decision = reshape(Indi.confidence.SC(:,run,s),[],1);
        signal(isnan(signal)) = []; % Remove NaNs
        decision(isnan(decision)) = [];
        
        [~,~,temp.sc_type1auc(s,run)] = type1auc(signal,decision);
        
        % Calculate Objective Performance for ST Peripheral per subject
        signal = [];
        decision = [];
        
        signal = reshape(Indi.truth.SP(:,run,s),[],1);
        decision = reshape(Indi.confidence.SP(:,run,s),[],1);
        signal(isnan(signal)) = []; % Remove NaNs
        decision(isnan(decision)) = [];
        
        [~,~,temp.sp_type1auc(s,run)] = type1auc(signal,decision);
    end
end

%% Type II AUC - dual task central vs. peripheral (x vs. y)

Nratings = 4;

for s = 1:Indi.Subjects
    for run = 1:run_total
        
        % Calculate Metacognition for Dual Central per subject
        correct = [];
        confidence = [];
        
        correct = reshape(Indi.correct.DC(:,run,s),[],1);
        confidence = abs(reshape(Indi.confidence.DC(:,run,s),[],1));
        correct(isnan(correct)) = []; % Remove NaNs
        confidence(isnan(confidence)) = [];
        
        temp.dc_type2auc(s,run) = type2roc(correct,confidence,Nratings);
        
        % Calculate Metacognition for Dual Peripehral per subject
        correct = [];
        confidence = [];
        
        correct = reshape(Indi.correct.DP(:,run,s),[],1);
        confidence = abs(reshape(Indi.confidence.DP(:,run,s),[],1));
        correct(isnan(correct)) = []; % Remove NaNs
        confidence(isnan(confidence)) = [];
        
        temp.dp_type2auc(s,run) = type2roc(correct,confidence,Nratings);
    end
end

if Partial_report
    
    for s = 1:Indi.Subjects
        for run = 1:run_total
            
            % Calculate Metacognition for Dual Central per subject
            correct = [];
            confidence = [];
            
            correct = reshape(Indi.correct.PDC(:,run,s),[],1);
            confidence = abs(reshape(Indi.confidence.PDC(:,run,s),[],1));
            correct(isnan(correct)) = []; % Remove NaNs
            confidence(isnan(confidence)) = [];
            
            temp.pdc_type2auc(s,run) = type2roc(correct,confidence,Nratings);
            
            % Calculate Metacognition for Dual Peripehral per subject
            correct = [];
            confidence = [];
            
            correct = reshape(Indi.correct.PDP(:,run,s),[],1);
            confidence = abs(reshape(Indi.confidence.PDP(:,run,s),[],1));
            correct(isnan(correct)) = []; % Remove NaNs
            confidence(isnan(confidence)) = [];
            
            temp.pdp_type2auc(s,run) = type2roc(correct,confidence,Nratings);
        end
    end
end

for s = 1:Indi.Subjects
    for run = 1:run_total
        % Calculate Metacognition for ST Central per subject
        correct = [];
        confidence = [];
        
        correct = reshape(Indi.correct.SC(:,run,s),[],1);
        confidence = abs(reshape(Indi.confidence.SC(:,run,s),[],1));
        correct(isnan(correct)) = []; % Remove NaNs
        confidence(isnan(confidence)) = [];
        
        temp.sc_type2auc(s,run) = type2roc(correct,confidence,Nratings);
        
        % Calculate Metacognition for ST Peripehral per subject
        correct = [];
        confidence = [];
        
        correct = reshape(Indi.correct.SP(:,run,s),[],1);
        confidence = abs(reshape(Indi.confidence.SP(:,run,s),[],1));
        correct(isnan(correct)) = []; % Remove NaNs
        confidence(isnan(confidence)) = [];
        
        temp.sp_type2auc(s,run) = type2roc(correct,confidence,Nratings);
    end
end

Indi.ST_Central.Confidence_SubByRun = temp.sc_confidence;
Indi.ST_Peripheral.Confidence_SubByRun = temp.sp_confidence;

Indi.DT_Central.Confidence_SubByRun = temp.dc_confidence;
Indi.DT_Peripheral.Confidence_SubByRun = temp.dp_confidence;

%% CONFIDENCE CORRECT & INCORRECT
Indi.ST_Central.Confidence_SubByRun_correct = temp.sc_confidence_correct;
Indi.ST_Peripheral.Confidence_SubByRun_correct = temp.sp_confidence_correct;
Indi.DT_Central.Confidence_SubByRun_correct = temp.dc_confidence_correct;
Indi.DT_Peripheral.Confidence_SubByRun_correct = temp.dp_confidence_correct;

Indi.ST_Central.Confidence_SubByRun_incorrect = temp.sc_confidence_incorrect;
Indi.ST_Peripheral.Confidence_SubByRun_incorrect = temp.sp_confidence_incorrect;
Indi.DT_Central.Confidence_SubByRun_incorrect = temp.dc_confidence_incorrect;
Indi.DT_Peripheral.Confidence_SubByRun_incorrect = temp.dp_confidence_incorrect;

%% REMAINING VALUES
Indi.ST_Central.Objective_Performance_SubByRun = temp.sc_type1auc;
Indi.ST_Peripheral.Objective_Performance_SubByRun = temp.sp_type1auc;

Indi.DT_Central.Objective_Performance_SubByRun = temp.dc_type1auc;
Indi.DT_Peripheral.Objective_Performance_SubByRun = temp.dp_type1auc;

Indi.ST_Central.Metacognition_SubByRun = temp.sc_type2auc;
Indi.ST_Peripheral.Metacognition_SubByRun = temp.sp_type2auc;

Indi.DT_Central.Metacognition_SubByRun = temp.dc_type2auc;
Indi.DT_Peripheral.Metacognition_SubByRun = temp.dp_type2auc;

if Partial_report
    
    Indi.PDT_Central.Confidence_SubByRun = temp.pdc_confidence;
    Indi.PDT_Central.Objective_Performance_SubByRun = temp.pdc_type1auc;
    Indi.PDT_Central.Metacognition_SubByRun = temp.pdc_type2auc;
    
    Indi.PDT_Peripheral.Confidence_SubByRun = temp.pdp_confidence;
    Indi.PDT_Peripheral.Objective_Performance_SubByRun = temp.pdp_type1auc;
    Indi.PDT_Peripheral.Metacognition_SubByRun = temp.pdp_type2auc;
    
    % Correct & incorrect confidence values
    Indi.PDT_Central.Confidence_SubByRun_correct = temp.pdc_confidence_correct;
    Indi.PDT_Peripheral.Confidence_SubByRun_correct = temp.pdp_confidence_correct;
    
    Indi.PDT_Central.Confidence_SubByRun_incorrect = temp.pdc_confidence_incorrect;
    Indi.PDT_Peripheral.Confidence_SubByRun_incorrect = temp.pdp_confidence_incorrect;
end

%% CALCULATE GLOBAL MEANS + SEMs FOR EACH EXPERIMENT


%% Confidence
Indi.DT_Central.Confidence_MEAN = mean(temp.dc_confidence,2);
Indi.DT_Central.Confidence_STD = std(temp.dc_confidence,[],2);
Indi.DT_Central.Confidence_SEM = std(temp.dc_confidence,[],2)/...
    sqrt(run_total);

Indi.DT_Peripheral.Confidence_MEAN = mean(temp.dp_confidence,2);
Indi.DT_Peripheral.Confidence_STD = std(temp.dp_confidence,[],2);
Indi.DT_Peripheral.Confidence_SEM = std(temp.dp_confidence,[],2)/...
    sqrt(run_total);

Indi.ST_Central.Confidence_MEAN = mean(temp.sc_confidence,2);
Indi.ST_Central.Confidence_STD = std(temp.sc_confidence,[],2);
Indi.ST_Central.Confidence_SEM = std(temp.sc_confidence,[],2)/...
    sqrt(run_total);

Indi.ST_Peripheral.Confidence_MEAN = mean(temp.sp_confidence,2);
Indi.ST_Peripheral.Confidence_STD = std(temp.sp_confidence,[],2);
Indi.ST_Peripheral.Confidence_SEM = std(temp.sp_confidence,[],2)/...
    sqrt(run_total);

if Partial_report
    
    Indi.PDT_Central.Confidence_MEAN = mean(temp.pdc_confidence,2);
    Indi.PDT_Central.Confidence_STD = std(temp.pdc_confidence,[],2);
    Indi.PDT_Central.Confidence_SEM = std(temp.pdc_confidence,[],2)/...
        sqrt(run_total);
    
    Indi.PDT_Peripheral.Confidence_MEAN = mean(temp.pdp_confidence,2);
    Indi.PDT_Peripheral.Confidence_STD = std(temp.pdp_confidence,[],2);
    Indi.PDT_Peripheral.Confidence_SEM = std(temp.pdp_confidence,[],2)/...
        sqrt(run_total);
end

% Correct

Indi.DT_Central.Confidence_MEAN_correct = mean(temp.dc_confidence_correct,2);
Indi.DT_Central.Confidence_STD_correct = std(temp.dc_confidence_correct,[],2);
Indi.DT_Central.Confidence_SEM_correct = std(temp.dc_confidence_correct,[],2)/...
    sqrt(run_total);

Indi.DT_Peripheral.Confidence_MEAN_correct = mean(temp.dp_confidence_correct,2);
Indi.DT_Peripheral.Confidence_STD_correct = std(temp.dp_confidence_correct,[],2);
Indi.DT_Peripheral.Confidence_SEM_correct = std(temp.dp_confidence_correct,[],2)/...
    sqrt(run_total);

Indi.ST_Central.Confidence_MEAN_correct = mean(temp.sc_confidence_correct,2);
Indi.ST_Central.Confidence_STD_correct = std(temp.sc_confidence_correct,[],2);
Indi.ST_Central.Confidence_SEM_correct = std(temp.sc_confidence_correct,[],2)/...
    sqrt(run_total);

Indi.ST_Peripheral.Confidence_MEAN_correct = mean(temp.sp_confidence_correct,2);
Indi.ST_Peripheral.Confidence_STD_correct = std(temp.sp_confidence_correct,[],2);
Indi.ST_Peripheral.Confidence_SEM_correct = std(temp.sp_confidence_correct,[],2)/...
    sqrt(run_total);

if Partial_report
    
    Indi.PDT_Central.Confidence_MEAN_correct = mean(temp.pdc_confidence_correct,2);
    Indi.PDT_Central.Confidence_STD_correct = std(temp.pdc_confidence_correct,[],2);
    Indi.PDT_Central.Confidence_SEM_correct = std(temp.pdc_confidence_correct,[],2)/...
        sqrt(run_total);
    
    Indi.PDT_Peripheral.Confidence_MEAN_correct = mean(temp.pdp_confidence_correct,2);
    Indi.PDT_Peripheral.Confidence_STD_correct = std(temp.pdp_confidence_correct,[],2);
    Indi.PDT_Peripheral.Confidence_SEM_correct = std(temp.pdp_confidence_correct,[],2)/...
        sqrt(run_total);
end

% Incorrect

Indi.DT_Central.Confidence_MEAN_incorrect = mean(temp.dc_confidence_incorrect,2);
Indi.DT_Central.Confidence_STD_incorrect = std(temp.dc_confidence_incorrect,[],2);
Indi.DT_Central.Confidence_SEM_incorrect = std(temp.dc_confidence_incorrect,[],2)/...
    sqrt(run_total);

Indi.DT_Peripheral.Confidence_MEAN_incorrect = mean(temp.dp_confidence_incorrect,2);
Indi.DT_Peripheral.Confidence_STD_incorrect = std(temp.dp_confidence_incorrect,[],2);
Indi.DT_Peripheral.Confidence_SEM_incorrect = std(temp.dp_confidence_incorrect,[],2)/...
    sqrt(run_total);

Indi.ST_Central.Confidence_MEAN_incorrect = mean(temp.sc_confidence_incorrect,2);
Indi.ST_Central.Confidence_STD_incorrect = std(temp.sc_confidence_incorrect,[],2);
Indi.ST_Central.Confidence_SEM_incorrect = std(temp.sc_confidence_incorrect,[],2)/...
    sqrt(run_total);

Indi.ST_Peripheral.Confidence_MEAN_incorrect = mean(temp.sp_confidence_incorrect,2);
Indi.ST_Peripheral.Confidence_STD_incorrect = std(temp.sp_confidence_incorrect,[],2);
Indi.ST_Peripheral.Confidence_SEM_incorrect = std(temp.sp_confidence_incorrect,[],2)/...
    sqrt(run_total);

if Partial_report
    
    Indi.PDT_Central.Confidence_MEAN_incorrect = mean(temp.pdc_confidence_incorrect,2);
    Indi.PDT_Central.Confidence_STD_incorrect = std(temp.pdc_confidence_incorrect,[],2);
    Indi.PDT_Central.Confidence_SEM_incorrect = std(temp.pdc_confidence_incorrect,[],2)/...
        sqrt(run_total);
    
    Indi.PDT_Peripheral.Confidence_MEAN_incorrect = mean(temp.pdp_confidence_incorrect,2);
    Indi.PDT_Peripheral.Confidence_STD_incorrect = std(temp.pdp_confidence_incorrect,[],2);
    Indi.PDT_Peripheral.Confidence_SEM_incorrect = std(temp.pdp_confidence_incorrect,[],2)/...
        sqrt(run_total);
end


%% Objective Performance

Indi.DT_Central.Objective_Performance_MEAN = mean(temp.dc_type1auc,2);
Indi.DT_Central.Objective_Performance_STD = std(temp.dc_type1auc,[],2);
Indi.DT_Central.Objective_Performance_SEM = std(temp.dc_type1auc,[],2)/...
    sqrt(run_total);

Indi.DT_Peripheral.Objective_Performance_MEAN = mean(temp.dp_type1auc,2);
Indi.DT_Peripheral.Objective_Performance_STD = std(temp.dp_type1auc,[],2);
Indi.DT_Peripheral.Objective_Performance_SEM = std(temp.dp_type1auc,[],2)/...
    sqrt(run_total);

Indi.ST_Central.Objective_Performance_MEAN = mean(temp.sc_type1auc,2);
Indi.ST_Central.Objective_Performance_STD = std(temp.sc_type1auc,[],2);
Indi.ST_Central.Objective_Performance_SEM = std(temp.sc_type1auc,[],2)/...
    sqrt(run_total);

Indi.ST_Peripheral.Objective_Performance_MEAN = mean(temp.sp_type1auc,2);
Indi.ST_Peripheral.Objective_Performance_STD = std(temp.sp_type1auc,[],2);
Indi.ST_Peripheral.Objective_Performance_SEM = std(temp.sp_type1auc,[],2)/...
    sqrt(run_total);

if Partial_report
    
    Indi.PDT_Central.Objective_Performance_MEAN = mean(temp.pdc_type1auc,2);
    Indi.PDT_Central.Objective_Performance_STD = std(temp.pdc_type1auc,[],2);
    Indi.PDT_Central.Objective_Performance_SEM = std(temp.pdc_type1auc,[],2)/...
        sqrt(run_total);
    
    Indi.PDT_Peripheral.Objective_Performance_MEAN = mean(temp.pdp_type1auc,2);
    Indi.PDT_Peripheral.Objective_Performance_STD = std(temp.pdp_type1auc,[],2);
    Indi.PDT_Peripheral.Objective_Performance_SEM = std(temp.pdp_type1auc,[],2)/...
        sqrt(run_total);
    
end

%% Metacognition

Indi.DT_Central.Metacognition_MEAN = mean(temp.dc_type2auc,2);
Indi.DT_Central.Metacognition_STD = std(temp.dc_type2auc,[],2);
Indi.DT_Central.Metacognition_SEM = std(temp.dc_type2auc,[],2)/...
    sqrt(run_total);

Indi.DT_Peripheral.Metacognition_MEAN = mean(temp.dp_type2auc,2);
Indi.DT_Peripheral.Metacognition_STD = std(temp.dp_type2auc,[],2);
Indi.DT_Peripheral.Metacognition_SEM = std(temp.dp_type2auc,[],2)/...
    sqrt(run_total);

Indi.ST_Central.Metacognition_MEAN = mean(temp.sc_type2auc,2);
Indi.ST_Central.Metacognition_STD = std(temp.sc_type2auc,[],2);
Indi.ST_Central.Metacognition_SEM = std(temp.sc_type2auc,[],2)/...
    sqrt(run_total);

Indi.ST_Peripheral.Metacognition_MEAN = mean(temp.sp_type2auc,2);
Indi.ST_Peripheral.Metacognition_STD = std(temp.sp_type2auc,[],2);
Indi.ST_Peripheral.Metacognition_SEM = std(temp.sp_type2auc,[],2)/...
    sqrt(run_total);

if Partial_report
    
    Indi.PDT_Central.Metacognition_MEAN = mean(temp.pdc_type2auc,2);
    Indi.PDT_Central.Metacognition_STD = std(temp.pdc_type2auc,[],2);
    Indi.PDT_Central.Metacognition_SEM = std(temp.pdc_type2auc,[],2)/...
        sqrt(run_total);
    
    Indi.PDT_Peripheral.Metacognition_MEAN = mean(temp.pdp_type2auc,2);
    Indi.PDT_Peripheral.Metacognition_STD = std(temp.pdp_type2auc,[],2);
    Indi.PDT_Peripheral.Metacognition_SEM = std(temp.pdp_type2auc,[],2)/...
        sqrt(run_total);
    
end


end