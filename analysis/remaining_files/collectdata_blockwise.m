clear all;

%% Collect relevant data per block and save in matrix

Exp = 'Exp2/'; % Choose experiemnt here
% Files = {'01_JT/01_JT_', '02_DA/02_DA_', '03_BK/03_BK_', '04_JK/04_JK_', '05_AN/05_AN_', '06_MS/06_MS_', '07_KK/07_KK_', '08_LE/08_LE_'}; % Choose files here

% Exp = 'Exp2/'; % Choose experiemnt here
% Files = {'01_JT/01_JT_', '02_DA/02_DA_', '03_BK/03_BK_', '04_JK/04_JK_', '05_AN/05_AN_', '06_MS/06_MS_', '07_LE/07_LE_', '08_BJ/08_BJ_'}; % Choose files here
% Final participants, excludes those with missing data 
% '13_IG/13_IG_'
Files = {'04_JK/04_JK_', '07_LE/07_LE_', '08_BJ/08_BJ_', '09_VC/09_VC_', '10_EW/10_EW_', '11_CM/11_CM_', '12_TM/12_TM_', '13_IG/13_IG_'};

% Exp = 'Exp4/'; % Choose experiment here
% Files = {'01_AN/01_AN_', '02_SN/02_SN_', '03_AN/03_AN_', '04_NK/04_NK_', '05_HB/05_HB_'}; % Choose files here & SPECIFY TWICE AGAIN BELOW!!!

Path = ['../data/preprocessed/' Exp];

%% Matrix contents
% ROWS: Blocks
% COLUMNS: 
% 1. Subject
% 2. Condition
% 3. Block
% 4. Central accuracy
% 5. Peripheral accuracy
% 6. Central confidence
% 7. Peripheral confidence
% 8. Central AUC (legacy metacognition method)
% 9. Peripheral AUC (legacy metacognition method)
% 10. Central SOA
% 11. Peripheral SOA
% 12. Central Type-2 AUC (Fleming & Lau, 2014 method)
% 13. Peripheral Type-2 AUC (Fleming & Lau, 2014 method)
% 14. Central Type-1 AUC (Objective Performance)
% 15. Peripheral Type-1 AUC (Objective Performance)

for condition = 1:4; % one matrix per condition (central, peripheral, dual, partial dual)
    
    line = 1;
    
    for subj = 1:length(Files)
        block = 1;
        for session = 1:3
            for run = 1:4
                
                if ~(session == 1 && run == 2)
                    if exist([Path Files{subj} num2str(session) '_' num2str(run) '_preprocessed.mat'], 'file');
                        
                        load([Path Files{subj} num2str(session) '_' num2str(run) '_preprocessed'], 'Data');
                        relData = Data([Data.condition] == condition);
                        if condition == 1
                            if session == 1 && run == 1
                                for training = 1:2
                                    central_data(line,1) = subj;
                                    central_data(line,2) = condition;
                                    central_data(line,3) = training-3;
                                    central_data(line,4) = relData(training).c_performance;
                                    central_data(line,5) = NaN;
                                    central_data(line,6) = relData(training).c_confidence;
                                    central_data(line,7) = NaN;
                                    central_data(line,8) = relData(training).c_AUC;
                                    central_data(line,9) = NaN;
                                    central_data(line,10) = relData(training).c_SOA;
                                    central_data(line,11) = NaN;
                                    central_data(line,12) = relData(training).c_metacognition;
                                    central_data(line,13) = NaN;
                                    central_data(line,14) = relData(training).c_objective_perf;
                                    central_data(line,15) = NaN;
                                    line = line + 1;
                                end
                            else
                                central_data(line,1) = subj;
                                central_data(line,2) = condition;
                                central_data(line,3) = block;
                                central_data(line,4) = relData(1).c_performance;
                                central_data(line,5) = NaN;
                                central_data(line,6) = relData(1).c_confidence;
                                central_data(line,7) = NaN;
                                central_data(line,8) = relData(1).c_AUC;
                                central_data(line,9) = NaN;
                                central_data(line,10) = relData(1).c_SOA;
                                central_data(line,11) = NaN;
                                central_data(line,12) = relData(1).c_metacognition;
                                central_data(line,13) = NaN;
                                central_data(line,14) = relData(1).c_objective_perf;
                                central_data(line,15) = NaN;
                                
                                line = line + 1;
                                block = block + 1;
                            end
                            
                        elseif condition == 2
                            if session == 1 && run == 1
                                for training = 1:2
                                    peripheral_data(line,1) = subj;
                                    peripheral_data(line,2) = condition;
                                    peripheral_data(line,3) = training-3;
                                    peripheral_data(line,4) = NaN;
                                    peripheral_data(line,5) = relData(training).p_performance;
                                    peripheral_data(line,6) = NaN;
                                    peripheral_data(line,7) = relData(training).p_confidence;
                                    peripheral_data(line,8) = NaN;
                                    peripheral_data(line,9) = relData(training).p_AUC;
                                    peripheral_data(line,10) = NaN;
                                    peripheral_data(line,11) = relData(training).p_SOA;
                                    peripheral_data(line,12) = NaN;
                                    peripheral_data(line,13) = relData(training).p_metacognition;
                                    peripheral_data(line,14) = NaN;
                                    peripheral_data(line,15) = relData(training).p_objective_perf;
                                    
                                    line = line + 1;
                                end
                            else
                                peripheral_data(line,1) = subj;
                                peripheral_data(line,2) = condition;
                                peripheral_data(line,3) = block;
                                peripheral_data(line,4) = NaN;
                                peripheral_data(line,5) = relData(1).p_performance;
                                peripheral_data(line,6) = NaN;
                                peripheral_data(line,7) = relData(1).p_confidence;
                                peripheral_data(line,8) = NaN;
                                peripheral_data(line,9) = relData(1).p_AUC;
                                peripheral_data(line,10) = NaN;
                                peripheral_data(line,11) = relData(1).p_SOA;
                                peripheral_data(line,12) = NaN;
                                peripheral_data(line,13) = relData(1).p_metacognition;
                                peripheral_data(line,14) = NaN;
                                peripheral_data(line,15) = relData(1).p_objective_perf;
                                
                                line = line + 1;
                                block = block + 1;
                            end
                        elseif condition == 3 && ~isempty(relData)
                            dual_data(line,1) = subj;
                            dual_data(line,2) = condition;
                            dual_data(line,3) = block;
                            dual_data(line,4) = relData(1).c_performance;
                            dual_data(line,5) = relData(1).p_performance;
                            dual_data(line,6) = relData(1).c_confidence;
                            dual_data(line,7) = relData(1).p_confidence;
                            dual_data(line,8) = relData(1).c_AUC;
                            dual_data(line,9) = relData(1).p_AUC;
                            dual_data(line,10) = relData(1).c_SOA;
                            dual_data(line,11) = relData(1).p_SOA;
                            dual_data(line,12) = relData(1).c_metacognition;
                            dual_data(line,13) = relData(1).p_metacognition;
                            dual_data(line,14) = relData(1).c_objective_perf;
                            dual_data(line,15) = relData(1).p_objective_perf;
                            
                            line = line + 1;
                            block = block + 1;
                            
                        elseif condition == 4 && ~isempty(relData)
                            
                            part_dual_data(line,1) = subj;
                            part_dual_data(line,2) = condition;
                            part_dual_data(line,3) = block;
                            part_dual_data(line,4) = mean([relData(1:2).c_performance]);
                            part_dual_data(line,5) = mean([relData(1:2).p_performance]);
                            part_dual_data(line,6) = mean([relData(1:2).c_confidence]);
                            part_dual_data(line,7) = mean([relData(1:2).p_confidence]);
                            part_dual_data(line,8) = mean([relData(1:2).c_AUC]);
                            part_dual_data(line,9) = mean([relData(1:2).p_AUC]);
                            part_dual_data(line,10) = mean([relData(1:2).c_SOA]);
                            part_dual_data(line,11) = mean([relData(1:2).p_SOA]);
                            part_dual_data(line,12) = mean([relData(1:2).c_metacognition]);
                            part_dual_data(line,13) = mean([relData(1:2).p_metacognition]);
                            part_dual_data(line,14) = mean([relData(1:2).c_objective_perf]);
                            part_dual_data(line,15) = mean([relData(1:2).p_objective_perf]);
                            
                            line = line + 1;
                            block = block + 1;
                            
                        end
                    end
                end
            end
        end
    end
    
    NewPath = ['../data/blockwise/' Exp];
    
    switch condition
        
        case 1
            save([NewPath 'central_data'],'central_data','Files');
        case 2
            save([NewPath 'peripheral_data'],'peripheral_data','Files');
        case 3
            save([NewPath 'dual_data'],'dual_data','Files');
        case 4
            if ~isempty(relData)
                save([NewPath 'part_dual_data'],'part_dual_data','Files');
            end
    end
    
end

if strcmp(Exp, 'Exp4/')
    
    clear all;
    
    Exp = 'Exp4/'; % Choose experiment here
    Files = {'01_AN/01_AN_', '02_SN/02_SN_', '03_AN/03_AN_', '04_NK/04_NK_', '05_HB/05_HB_'}; % Choose files here
    
    Path = ['../data/preprocessed/' Exp];
    
    if strcmp(Exp,'Exp4/')
        %% SOLOPAIRS
        % Comparison within colours (ala Exp2 or Exp3)
        % diskTypes 1 & 2 (BY/YB) and 3 & 4 (RG/GR)
        
        for condition = 1:4; % one matrix per condition (central, peripheral, dual, partial dual)
            
            line = 1;
            
            for subj = 1:length(Files)
                block = 1;
                for session = 1:3
                    for run = 1:4
                        
                        if ~(session == 1 && run == 2)
                            if exist([Path Files{subj} num2str(session) '_' num2str(run) '_preprocessed.mat'], 'file');
                                
                                load([Path Files{subj} num2str(session) '_' num2str(run) '_preprocessed'], 'SoloPair');
                                relData = SoloPair([SoloPair.condition] == condition);
                                if condition == 1
                                    if session == 1 && run == 1
                                        for training = 1:2
                                            central_data(line,1) = subj;
                                            central_data(line,2) = condition;
                                            central_data(line,3) = training-3;
                                            central_data(line,4) = relData(training).c_performance;
                                            central_data(line,5) = NaN;
                                            central_data(line,6) = relData(training).c_confidence;
                                            central_data(line,7) = NaN;
                                            central_data(line,8) = relData(training).c_AUC;
                                            central_data(line,9) = NaN;
                                            central_data(line,10) = relData(training).c_SOA;
                                            central_data(line,11) = NaN;
                                            
                                            line = line + 1;
                                        end
                                    else
                                        central_data(line,1) = subj;
                                        central_data(line,2) = condition;
                                        central_data(line,3) = block;
                                        central_data(line,4) = relData(1).c_performance;
                                        central_data(line,5) = NaN;
                                        central_data(line,6) = relData(1).c_confidence;
                                        central_data(line,7) = NaN;
                                        central_data(line,8) = relData(1).c_AUC;
                                        central_data(line,9) = NaN;
                                        central_data(line,10) = relData(1).c_SOA;
                                        central_data(line,11) = NaN;
                                        
                                        line = line + 1;
                                        block = block + 1;
                                    end
                                    
                                elseif condition == 2
                                    if session == 1 && run == 1
                                        for training = 1:2
                                            peripheral_data(line,1) = subj;
                                            peripheral_data(line,2) = condition;
                                            peripheral_data(line,3) = training-3;
                                            peripheral_data(line,4) = NaN;
                                            peripheral_data(line,5) = relData(training).p_performance;
                                            peripheral_data(line,6) = NaN;
                                            peripheral_data(line,7) = relData(training).p_confidence;
                                            peripheral_data(line,8) = NaN;
                                            peripheral_data(line,9) = relData(training).p_AUC;
                                            peripheral_data(line,10) = NaN;
                                            peripheral_data(line,11) = relData(training).p_SOA;
                                            
                                            line = line + 1;
                                        end
                                    else
                                        peripheral_data(line,1) = subj;
                                        peripheral_data(line,2) = condition;
                                        peripheral_data(line,3) = block;
                                        peripheral_data(line,4) = NaN;
                                        peripheral_data(line,5) = relData(1).p_performance;
                                        peripheral_data(line,6) = NaN;
                                        peripheral_data(line,7) = relData(1).p_confidence;
                                        peripheral_data(line,8) = NaN;
                                        peripheral_data(line,9) = relData(1).p_AUC;
                                        peripheral_data(line,10) = NaN;
                                        peripheral_data(line,11) = relData(1).p_SOA;
                                        
                                        line = line + 1;
                                        block = block + 1;
                                    end
                                elseif condition == 3 && ~isempty(relData)
                                    dual_data(line,1) = subj;
                                    dual_data(line,2) = condition;
                                    dual_data(line,3) = block;
                                    dual_data(line,4) = relData(1).c_performance;
                                    dual_data(line,5) = relData(1).p_performance;
                                    dual_data(line,6) = relData(1).c_confidence;
                                    dual_data(line,7) = relData(1).p_confidence;
                                    dual_data(line,8) = relData(1).c_AUC;
                                    dual_data(line,9) = relData(1).p_AUC;
                                    dual_data(line,10) = relData(1).c_SOA;
                                    dual_data(line,11) = relData(1).p_SOA;
                                    
                                    line = line + 1;
                                    block = block + 1;
                                    
                                elseif condition == 4 && ~isempty(relData)
                                    
                                    part_dual_data(line,1) = subj;
                                    part_dual_data(line,2) = condition;
                                    part_dual_data(line,3) = block;
                                    part_dual_data(line,4) = mean([relData(1:2).c_performance]);
                                    part_dual_data(line,5) = mean([relData(1:2).p_performance]);
                                    part_dual_data(line,6) = mean([relData(1:2).c_confidence]);
                                    part_dual_data(line,7) = mean([relData(1:2).p_confidence]);
                                    part_dual_data(line,8) = mean([relData(1:2).c_AUC]);
                                    part_dual_data(line,9) = mean([relData(1:2).p_AUC]);
                                    part_dual_data(line,10) = mean([relData(1:2).c_SOA]);
                                    part_dual_data(line,11) = mean([relData(1:2).p_SOA]);
                                    
                                    line = line + 1;
                                    block = block + 1;
                                    
                                end
                            end
                        end
                    end
                end
            end
            
            NewPath = ['../data/blockwise/' Exp];
            
            switch condition
                
                case 1
                    save([NewPath 'solo_central_data'],'central_data','Files');
                case 2
                    save([NewPath 'solo_peripheral_data'],'peripheral_data','Files');
                case 3
                    save([NewPath 'solo_dual_data'],'dual_data','Files');
                case 4
                    if ~isempty(relData)
                        save([NewPath 'solo_part_dual_data'],'part_dual_data','Files');
                    end
            end
            
        end
        
    end
    
    clear all;
    
    Exp = 'Exp4/'; % Choose experiment here
    Files = {'01_AN/01_AN_', '02_SN/02_SN_', '03_AN/03_AN_', '04_NK/04_NK_', '05_HB/05_HB_'}; % Choose files here
    
    Path = ['../data/preprocessed/' Exp];
    
    if strcmp(Exp,'Exp4/')
        
        %% BOTHPAIRS
        % Comparison between colours (ie. RG vs. BY)
        % diskTypes 9 & 10 (BY/RG) and 11 & 12 (GR/YB)
        
        for condition = 1:4; % one matrix per condition (central, peripheral, dual, partial dual)
            
            line = 1;
            
            for subj = 1:length(Files)
                block = 1;
                for session = 1:3
                    for run = 1:4
                        
                        if ~(session == 1 && run == 2)
                            if exist([Path Files{subj} num2str(session) '_' num2str(run) '_preprocessed.mat'], 'file');
                                
                                load([Path Files{subj} num2str(session) '_' num2str(run) '_preprocessed'], 'BothPair');
                                relData = BothPair([BothPair.condition] == condition);
                                if condition == 1
                                    if session == 1 && run == 1
                                        for training = 1:2
                                            central_data(line,1) = subj;
                                            central_data(line,2) = condition;
                                            central_data(line,3) = training-3;
                                            central_data(line,4) = relData(training).c_performance;
                                            central_data(line,5) = NaN;
                                            central_data(line,6) = relData(training).c_confidence;
                                            central_data(line,7) = NaN;
                                            central_data(line,8) = relData(training).c_AUC;
                                            central_data(line,9) = NaN;
                                            central_data(line,10) = relData(training).c_SOA;
                                            central_data(line,11) = NaN;
                                            
                                            line = line + 1;
                                        end
                                    else
                                        central_data(line,1) = subj;
                                        central_data(line,2) = condition;
                                        central_data(line,3) = block;
                                        central_data(line,4) = relData(1).c_performance;
                                        central_data(line,5) = NaN;
                                        central_data(line,6) = relData(1).c_confidence;
                                        central_data(line,7) = NaN;
                                        central_data(line,8) = relData(1).c_AUC;
                                        central_data(line,9) = NaN;
                                        central_data(line,10) = relData(1).c_SOA;
                                        central_data(line,11) = NaN;
                                        
                                        line = line + 1;
                                        block = block + 1;
                                    end
                                    
                                elseif condition == 2
                                    if session == 1 && run == 1
                                        for training = 1:2
                                            peripheral_data(line,1) = subj;
                                            peripheral_data(line,2) = condition;
                                            peripheral_data(line,3) = training-3;
                                            peripheral_data(line,4) = NaN;
                                            peripheral_data(line,5) = relData(training).p_performance;
                                            peripheral_data(line,6) = NaN;
                                            peripheral_data(line,7) = relData(training).p_confidence;
                                            peripheral_data(line,8) = NaN;
                                            peripheral_data(line,9) = relData(training).p_AUC;
                                            peripheral_data(line,10) = NaN;
                                            peripheral_data(line,11) = relData(training).p_SOA;
                                            
                                            line = line + 1;
                                        end
                                    else
                                        peripheral_data(line,1) = subj;
                                        peripheral_data(line,2) = condition;
                                        peripheral_data(line,3) = block;
                                        peripheral_data(line,4) = NaN;
                                        peripheral_data(line,5) = relData(1).p_performance;
                                        peripheral_data(line,6) = NaN;
                                        peripheral_data(line,7) = relData(1).p_confidence;
                                        peripheral_data(line,8) = NaN;
                                        peripheral_data(line,9) = relData(1).p_AUC;
                                        peripheral_data(line,10) = NaN;
                                        peripheral_data(line,11) = relData(1).p_SOA;
                                        
                                        line = line + 1;
                                        block = block + 1;
                                    end
                                elseif condition == 3 && ~isempty(relData)
                                    dual_data(line,1) = subj;
                                    dual_data(line,2) = condition;
                                    dual_data(line,3) = block;
                                    dual_data(line,4) = relData(1).c_performance;
                                    dual_data(line,5) = relData(1).p_performance;
                                    dual_data(line,6) = relData(1).c_confidence;
                                    dual_data(line,7) = relData(1).p_confidence;
                                    dual_data(line,8) = relData(1).c_AUC;
                                    dual_data(line,9) = relData(1).p_AUC;
                                    dual_data(line,10) = relData(1).c_SOA;
                                    dual_data(line,11) = relData(1).p_SOA;
                                    
                                    line = line + 1;
                                    block = block + 1;
                                    
                                elseif condition == 4 && ~isempty(relData)
                                    
                                    part_dual_data(line,1) = subj;
                                    part_dual_data(line,2) = condition;
                                    part_dual_data(line,3) = block;
                                    part_dual_data(line,4) = mean([relData(1:2).c_performance]);
                                    part_dual_data(line,5) = mean([relData(1:2).p_performance]);
                                    part_dual_data(line,6) = mean([relData(1:2).c_confidence]);
                                    part_dual_data(line,7) = mean([relData(1:2).p_confidence]);
                                    part_dual_data(line,8) = mean([relData(1:2).c_AUC]);
                                    part_dual_data(line,9) = mean([relData(1:2).p_AUC]);
                                    part_dual_data(line,10) = mean([relData(1:2).c_SOA]);
                                    part_dual_data(line,11) = mean([relData(1:2).p_SOA]);
                                    
                                    line = line + 1;
                                    block = block + 1;
                                    
                                end
                            end
                        end
                    end
                end
            end
            
            NewPath = ['../data/blockwise/' Exp];
            
            switch condition
                
                case 1
                    save([NewPath 'both_central_data'],'central_data','Files');
                case 2
                    save([NewPath 'both_peripheral_data'],'peripheral_data','Files');
                case 3
                    save([NewPath 'both_dual_data'],'dual_data','Files');
                case 4
                    if ~isempty(relData)
                        save([NewPath 'both_part_dual_data'],'part_dual_data','Files');
                    end
            end
            
        end
        
    end
    
end

clear all;