
clear all;

%% Adds the fields c_confidence, p_confidence, c_SOA, p_SOA, c_frq, p_frq, c_AUC, and p_AUC to the data structure 'Data'

Exp = 'Exp2/'; % Choose experiment here
% Files = {'01_JT/01_JT_', '02_DA/02_DA_', '03_BK/03_BK_', '04_JK/04_JK_', '05_AN/05_AN_', '06_MS/06_MS_', '07_KK/07_KK_', '08_LE/08_LE_'}; % Choose files here

% Exp = 'Exp2/'; % Choose experiment here
% Files = {'01_JT/01_JT_', '02_DA/02_DA_', '03_BK/03_BK_', '04_JK/04_JK_', '05_AN/05_AN_', '06_MS/06_MS_', '07_LE/07_LE_', '08_BJ/08_BJ_'}; % Choose files here
% Final participants, excludes those with missing data 
% 
Files = {'04_JK/04_JK_', '07_LE/07_LE_', '08_BJ/08_BJ_', '09_VC/09_VC_', '10_EW/10_EW_', '11_CM/11_CM_', '12_TM/12_TM_', '13_IG/13_IG_'};
% JK,BJ,TM=Male; LE,VC,EW,CM,IG=Female

% Exp = 'Exp4/'; % Choose experiment here
% Files = {'01_AN/01_AN_', '02_SN/02_SN_', '03_AN/03_AN_', '04_NK/04_NK_', '05_HB/05_HB_'}; % Choose files here

Path = ['../data/raw/' Exp];

if strcmp(Exp,'Exp4/')
    
    for subj = 1:length(Files)
        for session = 1:3
            for run = 1:3
                if exist([Path Files{subj} num2str(session) '_' num2str(run) '.mat'],'file');
                    
                    load([Path Files{subj} num2str(session) '_' num2str(run)],'Data');
                    clear SoloPair;
                    clear BothPair;
                    
                    
                    for block = 1:length(Data)
                        
                        % Save "data" structs of certain diskTypes
                        within = 1;
                        between = 1;
                        
                        for trial = 1:length(Data(block).TR)
                            
                            % Within colour (ala Exp2 & Exp3)
                            % Disktypes 1 & 2 (RG/GR) and 3 & 4 (BY/YB)
                            if Data(block).TR(trial).diskType < 5
                                SoloPair(block).TR(within) = Data(block).TR(trial);
                                SoloPair(block).condition = Data(block).condition;
                                
                                within = within + 1;
                            
                            % Between colour    
                            elseif Data(block).TR(trial).diskType > 5
                                BothPair(block).TR(between) = Data(block).TR(trial);
                                BothPair(block).condition = Data(block).condition;
                                
                                between = between + 1;
                            
                            end
                            
                        end
                        
                        BothPair(block).c_performance = [];
                        BothPair(block).p_performance = [];
                        SoloPair(block).c_performance = [];
                        SoloPair(block).p_performance = [];
    
                        % Store performance
                        % SOAs a bit of a mess to calc, different refresh
                        % rates
                        switch Data(block).condition
                            case 1
                                BothPair(block).c_performance = sum([BothPair(block).TR(:).c_response])/length(BothPair(block).TR);
                                SoloPair(block).c_performance = sum([SoloPair(block).TR(:).c_response])/length(SoloPair(block).TR);
                            
                            case 2
                                BothPair(block).p_performance = sum([BothPair(block).TR(:).p_response])/length(BothPair(block).TR);
                                SoloPair(block).p_performance = sum([SoloPair(block).TR(:).p_response])/length(SoloPair(block).TR);
                            
                            case 3
                                BothPair(block).c_performance = sum([BothPair(block).TR(:).c_response])/length(BothPair(block).TR);
                                BothPair(block).p_performance = sum([BothPair(block).TR(:).p_response])/length(BothPair(block).TR);
                                
                                SoloPair(block).c_performance = sum([SoloPair(block).TR(:).c_response])/length(SoloPair(block).TR);
                                SoloPair(block).p_performance = sum([SoloPair(block).TR(:).p_response])/length(SoloPair(block).TR);
                            
                            case 4
                                BothPair(block).c_performance = sum([BothPair(block).TR(:).c_response])/length([BothPair(block).TR(:).c_response]);
                                BothPair(block).p_performance = sum([BothPair(block).TR(:).p_response])/length([BothPair(block).TR(:).p_response]);
                                
                                SoloPair(block).c_performance = sum([SoloPair(block).TR(:).c_response])/length([SoloPair(block).TR(:).c_response]);
                                SoloPair(block).p_performance = sum([SoloPair(block).TR(:).p_response])/length([SoloPair(block).TR(:).p_response]);
                        end
                        
                        % Central task
                        if Data(block).condition == 1 || Data(block).condition == 3 || Data(block).condition == 4
                            
                            % Mean confidence rating
                            Data(block).c_confidence = nanmean([Data(block).TR(:).c_confidence]);
                            % Mean SOA
                            Data(block).c_SOA = nanmean([Data(block).TR(:).cSOA]);
                            % AUC
                            c_frq = zeros(2,4);
                            for r = 1:2
                                for c = 1:4
                                    c_frq(r,c) = sum([Data(block).TR(:).c_confidence] == c & [Data(block).TR(:).c_response] ~= r-1);
                                end
                            end
                            Data(block).c_frq = c_frq;
                            [x, Data(block).c_AUC] = calculate_AUC(c_frq);
                            
                            %% Comparison within colours (ala Exp2 or Exp3)
                            % diskTypes 1 & 2 (BY/YB) and 3 & 4 (RG/GR)
                            % THESE SHOULDN'T DIFFER FOR SOLO/BOTH PAIR
                            
                            % Mean confidence rating
                            SoloPair(block).c_confidence = nanmean([SoloPair(block).TR(:).c_confidence]);
                            % Mean SOA
                            SoloPair(block).c_SOA = nanmean([SoloPair(block).TR(:).cSOA]);
                            % AUC
                            c_frq = zeros(2,4);
                            for r = 1:2
                                for c = 1:4
                                    c_frq(r,c) = sum([SoloPair(block).TR(:).c_confidence] == c & [SoloPair(block).TR(:).c_response] ~= r-1);
                                end
                            end
                            SoloPair(block).c_frq = c_frq;
                            [x, SoloPair(block).c_AUC] = calculate_AUC(c_frq);                           
                            
                            %% Comparison between colours (ie. RG vs. BY)
                            % diskTypes 9 & 10 (BY/RG) and 11 & 12 (GR/YB)
                            % THESE SHOULDN'T DIFFER FOR SOLO/BOTH PAIR
                            
                            % Mean confidence rating
                            BothPair(block).c_confidence = nanmean([BothPair(block).TR(:).c_confidence]);
                            % Mean SOA
                            BothPair(block).c_SOA = nanmean([BothPair(block).TR(:).cSOA]);
                            % AUC
                            c_frq = zeros(2,4);
                            for r = 1:2
                                for c = 1:4
                                    c_frq(r,c) = sum([BothPair(block).TR(:).c_confidence] == c & [BothPair(block).TR(:).c_response] ~= r-1);
                                end
                            end
                            BothPair(block).c_frq = c_frq;
                            [x, BothPair(block).c_AUC] = calculate_AUC(c_frq);
                            
                        end
                        
                        if Data(block).condition == 2 || Data(block).condition == 3 || Data(block).condition == 4
                            %% Disregarding diskType
                            % Mean confidence rating
                            Data(block).p_confidence = nanmean([Data(block).TR(:).p_confidence]);
                            % Mean SOA
                            Data(block).p_SOA = nanmean([Data(block).TR(:).pSOA]);
                            % AUC
                            p_frq = zeros(2,4);
                            for r = 1:2
                                for c = 1:4
                                    p_frq(r,c) = sum([Data(block).TR(:).p_confidence] == c & [Data(block).TR(:).p_response] ~= r-1);
                                end
                            end
                            Data(block).p_frq = p_frq;
                            [x, Data(block).p_AUC] = calculate_AUC(p_frq);
                            
                            %% Comparison within colours (ala Exp2 or Exp3)
                            % diskTypes 1 & 2 (BY/YB) and 3 & 4 (RG/GR)
                            % Mean confidence rating
                            SoloPair(block).p_confidence = nanmean([SoloPair(block).TR(:).p_confidence]);
                            % Mean SOA
                            SoloPair(block).p_SOA = nanmean([SoloPair(block).TR(:).pSOA]);
                            % AUC
                            p_frq = zeros(2,4);
                            for r = 1:2
                                for c = 1:4
                                    p_frq(r,c) = sum([SoloPair(block).TR(:).p_confidence] == c & [SoloPair(block).TR(:).p_response] ~= r-1);
                                end
                            end
                            SoloPair(block).p_frq = p_frq;
                            [x, SoloPair(block).p_AUC] = calculate_AUC(p_frq);                           
                            
                            %% Comparison between colours (ie. RG vs. BY)
                            % diskTypes 9 & 10 (BY/RG) and 11 & 12 (GR/YB)
                            % Mean confidence rating
                            BothPair(block).p_confidence = nanmean([BothPair(block).TR(:).p_confidence]);
                            % Mean SOA
                            BothPair(block).p_SOA = nanmean([BothPair(block).TR(:).pSOA]);
                            % AUC
                            p_frq = zeros(2,4);
                            for r = 1:2
                                for c = 1:4
                                    p_frq(r,c) = sum([BothPair(block).TR(:).p_confidence] == c & [BothPair(block).TR(:).p_response] ~= r-1);
                                end
                            end
                            BothPair(block).p_frq = p_frq;
                            [x, BothPair(block).p_AUC] = calculate_AUC(p_frq);
                            
                        end
                    end
                    
                    %% SAVE 
                    if ~exist(['../data/preprocessed/' Exp Files{subj}(1:5)],'dir')
                        mkdir(['../data/preprocessed/' Exp], Files{subj}(1:5));
                    end
                    
                    fileName = ['../data/preprocessed/' Exp Files{subj} num2str(session) '_' num2str(run) '_preprocessed.mat'];
                    save(fileName, 'Data', 'SoloPair', 'BothPair')
                    
                end
            end
        end
    end
    
else
    
    for subj = 1:length(Files)
        for session = 1:3
            for run = 1:4
                
                if exist([Path Files{subj} num2str(session) '_' num2str(run) '.mat'], 'file');
                    
                    load([Path Files{subj} num2str(session) '_' num2str(run)], 'Data');
                    
                    for block = 1:length(Data)
                        
                        if Data(block).condition == 1 || Data(block).condition == 3 || Data(block).condition == 4
                            
                            % mean confidence rating
                            Data(block).c_confidence = nanmean([Data(block).TR(:).c_confidence]);
                            
                            % mean SOA
                            Data(block).c_SOA = nanmean([Data(block).TR(:).cSOA]);
                            
                            % Legacy AUC method (21/12/2015)
                            % Keeping for sake of posterity but only
                            % metacognition & obj-perf values are used
                            
                            c_frq = zeros(2,4);
                            
                            for r = 1:2
                               for c = 1:4
                                   c_frq(r,c) = sum([Data(block).TR(:).c_confidence] == c & [Data(block).TR(:).c_response] ~= r-1);
                               end
                            end
                            
                            Data(block).c_frq = c_frq;
                            
                            [x, Data(block).c_AUC] = calculate_AUC(c_frq);
                            
                            Nratings = 4;
                            
                            correct = [Data(block).TR(:).c_response];
                            conf = [Data(block).TR(:).c_confidence];
                            
                            % Metacognition
                            Data(block).c_metacognition = type2roc(correct, conf, Nratings);
                            
                            % Objective performance
                            truth = [];
                                        
                            for trial = 1:length(Data(block).TR)
                                if Data(block).TR(trial).c_keyid == 1
                                    Data(block).TR(trial).c_keyid = -1;
                                elseif Data(block).TR(trial).c_keyid == 2
                                    Data(block).TR(trial).c_keyid = 1;
                                end
                            end
                            
                            for trial = 1:length(Data(block).TR);
                                if Data(block).TR(trial).c_response == 1
                                    truth(trial) = Data(block).TR(trial).c_keyid;
                                    Data(block).TR(trial).c_truth = Data(block).TR(trial).c_keyid;
                                elseif Data(block).TR(trial).c_response == 0
                                    if Data(block).TR(trial).c_keyid == 1
                                        truth(trial) = -1;
                                        Data(block).TR(trial).c_truth = -1;
                                    elseif Data(block).TR(trial).c_keyid == -1
                                        truth(trial) = 1;
                                        Data(block).TR(trial).c_truth = 1;
                                    end
                                elseif isempty(Data(block).TR(trial).c_response)
                                    truth(trial) = NaN;
                                    Data(block).TR(trial).c_truth = [];
                                end
                            end
                            
                            % This is actually the response not the signal
                            % signal = [Data(block).TR(:).c_keyid];
                            signal = [Data(block).TR(:).c_truth];
                            confidence = [Data(block).TR(:).c_confidence];
                            
                            % No need for this operation anymore
                            % response = truth(~isnan(truth)); 
                            response = [Data(block).TR(:).c_keyid];
                            detection = confidence .* response;
                            
                            [~,~,Data(block).c_objective_perf] = type1auc(signal,detection);
                            
                        end
                        
                        if Data(block).condition == 2 || Data(block).condition == 3 || Data(block).condition == 4
                            
                            % mean confidence rating
                            Data(block).p_confidence = nanmean([Data(block).TR(:).p_confidence]);
                            
                            % mean SOA
                            Data(block).p_SOA = nanmean([Data(block).TR(:).pSOA]);
                            
                            % Legacy AUC method (21/12/2015)
                            % Keeping for sake of posterity but only
                            % metacognition & obj-perf values are used
                            p_frq = zeros(2,4);
                            
                            for r = 1:2
                               for c = 1:4
                                   p_frq(r,c) = sum([Data(block).TR(:).p_confidence] == c & [Data(block).TR(:).p_response] ~= r-1);
                               end
                            end
                            
                            Data(block).p_frq = p_frq;
                            
                            [x, Data(block).p_AUC] = calculate_AUC(p_frq);
                            
                            Nratings = 4;
                            
                            correct = [Data(block).TR(:).p_response];
                            conf = [Data(block).TR(:).p_confidence];
                            
                            % Metacognition
                            Data(block).p_metacognition = type2roc(correct, conf, Nratings);
                            
                            % Objective performance
                            truth = [];
                                        
                            for trial = 1:length(Data(block).TR)
                                if Data(block).TR(trial).p_keyid == 1
                                    Data(block).TR(trial).p_keyid = -1;
                                elseif Data(block).TR(trial).p_keyid == 2
                                    Data(block).TR(trial).p_keyid = 1;
                                end
                            end
                            
                            for trial = 1:length(Data(block).TR);
                                if Data(block).TR(trial).p_response == 1
                                    truth(trial) = Data(block).TR(trial).p_keyid;
                                    Data(block).TR(trial).p_truth = Data(block).TR(trial).p_keyid;
                                elseif Data(block).TR(trial).p_response == 0
                                    if Data(block).TR(trial).p_keyid == 1
                                        truth(trial) = -1;
                                        Data(block).TR(trial).p_truth = -1;
                                    elseif Data(block).TR(trial).p_keyid == -1
                                        truth(trial) = 1;
                                        Data(block).TR(trial).p_truth = 1;
                                    end
                                elseif isempty(Data(block).TR(trial).p_response)
                                    truth(trial) = NaN;
                                    Data(block).TR(trial).p_truth = [];
                                end
                            end
                            
                            % This is actually the response not the signal
                            % signal = [Data(block).TR(:).c_keyid];
                            signal = [Data(block).TR(:).p_truth];
                            confidence = [Data(block).TR(:).p_confidence];
                            
                            % No need for this operation anymore
                            % response = truth(~isnan(truth)); 
                            response = [Data(block).TR(:).p_keyid];
                            detection = confidence .* response;
                            
                            [~,~,Data(block).p_objective_perf] = type1auc(signal,detection);
                            
                        end
                        
                        
                    end
                    
                    if ~exist(['../data/preprocessed/' Exp Files{subj}(1:5)],'dir')
                        mkdir(['../data/preprocessed/' Exp], Files{subj}(1:5));
                    end
                    
                    fileName = ['../data/preprocessed/' Exp Files{subj} num2str(session) '_' num2str(run) '_preprocessed.mat'];
                    save(fileName, 'Data')
                    
                end
                
            end
        end
    end
end

clear all;