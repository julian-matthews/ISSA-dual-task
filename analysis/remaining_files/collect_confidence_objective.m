function [confidence truth] = collect_confidence_objective(Files,Exp)

%% Create matrices that contain all confidence ratings and truths: 
%  trials x blocks x subjects
%  1 matrix for each condition (SC, CP, DC, DP)

Path = ['../data/preprocessed/' Exp];


if strcmp(Exp,'Exp2/')
    confidence.SP = zeros(30,10,length(Files));
    confidence.SC = zeros(30,10,length(Files));
    confidence.DP = zeros(30,8,length(Files));
    confidence.DC = zeros(30,8,length(Files));
    confidence.PDP = zeros(30,8,length(Files));
    confidence.PDC = zeros(30,8,length(Files));
    truth.SP = zeros(30,10,length(Files));
    truth.SC = zeros(30,10,length(Files));
    truth.DP = zeros(30,8,length(Files));
    truth.DC = zeros(30,8,length(Files));
    truth.PDP = zeros(30,8,length(Files));
    truth.PDC = zeros(30,8,length(Files));
else
    confidence.SP = zeros(48,10,length(Files));
    confidence.SC = zeros(48,10,length(Files));
    confidence.DP = zeros(48,8,length(Files));
    confidence.DC = zeros(48,8,length(Files));
    truth.SP = zeros(48,10,length(Files));
    truth.SC = zeros(48,10,length(Files));
    truth.DP = zeros(48,8,length(Files));
    truth.DC = zeros(48,8,length(Files));
end

for subj = 1:length(Files)
    blockST = 1;
    blockDT = 1;
    for session = 1:3
        for run = 1:4
            
            if ~(session == 1 && run == 2)
                    if exist([Path Files{subj} num2str(session) '_' num2str(run) '_preprocessed.mat'], 'file');
                        
                        load([Path Files{subj} num2str(session) '_' num2str(run) '_preprocessed'], 'Data');
                        
                        % Create true confidence
                        % Assigns confidence rating and response side (-ve/+ve == left/right)
                        for blocks = 1:length(Data)
                            for trials = 1:length(Data(blocks).TR)
                                
                                if ~isempty(Data(blocks).TR(trials).c_confidence)
                                    Data(blocks).TR(trials).c_trueconf = ...
                                        Data(blocks).TR(trials).c_confidence * Data(blocks).TR(trials).c_keyid;
                                elseif isempty(Data(blocks).TR(trials).c_confidence)
                                    Data(blocks).TR(trials).c_trueconf = [];
                                end
                                
                                if ~isempty(Data(blocks).TR(trials).p_confidence)
                                    Data(blocks).TR(trials).p_trueconf = ...
                                        Data(blocks).TR(trials).p_confidence * Data(blocks).TR(trials).p_keyid;
                                elseif isempty(Data(blocks).TR(trials).p_confidence)
                                    Data(blocks).TR(trials).p_trueconf = [];
                                end
                                
                            end
                        end
                        
                        % Confidence on Single Task
                        SCData = Data([Data.condition] == 1);
                        SPData = Data([Data.condition] == 2);
                        
                        for b = 1:length(SCData);
                            
                            % 2016-05-09 STEP NO LONGER NECESSARY (SUB
                            % REMOVED)
                            
                            % Subject2 : Only 20 trials in Session 1 run 3 and 4 --> add nan to get
                            % arrays of length 30
                            
%                             if strcmp(Exp,'Exp2/') && subj == 2 && session == 1 && (run == 3 || run == 4)
%                                 confidence.SC(:,blockST,subj) = [SCData(b).TR(:).c_trueconf NaN(1,10)];
%                                 confidence.SP(:,blockST,subj) = [SPData(b).TR(:).p_trueconf NaN(1,10)];
%                                 truth.SC(:,blockST,subj) = [SCData(b).TR(:).c_truth NaN(1,10)];
%                                 truth.SP(:,blockST,subj) = [SPData(b).TR(:).p_truth NaN(1,10)];
%                             else
%                                 confidence.SC(:,blockST,subj) = [SCData(b).TR(:).c_trueconf];
%                                 confidence.SP(:,blockST,subj) = [SPData(b).TR(:).p_trueconf];
%                                 truth.SC(:,blockST,subj) = [SCData(b).TR(:).c_truth];
%                                 truth.SP(:,blockST,subj) = [SPData(b).TR(:).p_truth];
%                             end
                            
                            confidence.SC(:,blockST,subj) = [SCData(b).TR(:).c_trueconf];
                            confidence.SP(:,blockST,subj) = [SPData(b).TR(:).p_trueconf];
                            truth.SC(:,blockST,subj) = [SCData(b).TR(:).c_truth];
                            truth.SP(:,blockST,subj) = [SPData(b).TR(:).p_truth];
                            
                            blockST = blockST + 1;
                        end
                        
                        % Confidence on Dual Task
                        if ~(session == 1 && run == 1)
                            DData = Data([Data.condition] == 3);
                            
                            % Step no longer necessary (sub removed)
                            
                            % Subject2 : Only 20 trials in Session 1 run 3 and 4 --> add nan to get
                            % arrays of length 30                            
%                             if strcmp(Exp,'Exp2/') && subj == 2 && session == 1 && (run == 3 || run == 4)
%                                 confidence.DC(:,blockDT,subj) = [DData(1).TR(:).c_trueconf NaN(1,10)];
%                                 confidence.DP(:,blockDT,subj) = [DData(1).TR(:).p_trueconf NaN(1,10)];
%                                 truth.DC(:,blockDT,subj) = [DData(1).TR(:).c_truth NaN(1,10)];
%                                 truth.DP(:,blockDT,subj) = [DData(1).TR(:).p_truth NaN(1,10)];
%                             else
%                                 confidence.DC(:,blockDT,subj) = [DData(1).TR(:).c_trueconf];
%                                 confidence.DP(:,blockDT,subj) = [DData(1).TR(:).p_trueconf];
%                                 truth.DC(:,blockDT,subj) = [DData(1).TR(:).c_truth];
%                                 truth.DP(:,blockDT,subj) = [DData(1).TR(:).p_truth];
%                             end
                            
                            confidence.DC(:,blockDT,subj) = [DData(1).TR(:).c_trueconf];
                            confidence.DP(:,blockDT,subj) = [DData(1).TR(:).p_trueconf];
                            truth.DC(:,blockDT,subj) = [DData(1).TR(:).c_truth];
                            truth.DP(:,blockDT,subj) = [DData(1).TR(:).p_truth];
                            
                            if strcmp(Exp,'Exp2/')
                                PDData = Data([Data.condition] == 4);
                                
                                % Step no longer necessary (sub removed)
                                
                                % Subject2 : Only 20 trials in Session 1 run 3 and 4 --> add nan to get
                                % arrays of length 30                            
%                                 if subj == 2 && session == 1 && (run == 3 || run == 4)
%                                     confidence.PDC(:,blockDT,subj) = [PDData(1).TR(:).c_trueconf NaN(1,5) PDData(2).TR(:).c_trueconf NaN(1,5)];
%                                     confidence.PDP(:,blockDT,subj) = [PDData(1).TR(:).p_trueconf NaN(1,5) PDData(2).TR(:).p_trueconf NaN(1,5)];
%                                     truth.PDC(:,blockDT,subj) = [PDData(1).TR(:).c_truth NaN(1,5) PDData(2).TR(:).c_truth NaN(1,5)];
%                                     truth.PDP(:,blockDT,subj) = [PDData(1).TR(:).p_truth NaN(1,5) PDData(2).TR(:).p_truth NaN(1,5)];
%                                 else
%                                     confidence.PDC(:,blockDT,subj) = [PDData(1).TR(:).c_trueconf PDData(2).TR(:).c_trueconf];
%                                     confidence.PDP(:,blockDT,subj) = [PDData(1).TR(:).p_trueconf PDData(2).TR(:).p_trueconf];
%                                     truth.PDC(:,blockDT,subj) = [PDData(1).TR(:).c_truth PDData(2).TR(:).c_truth];
%                                     truth.PDP(:,blockDT,subj) = [PDData(1).TR(:).p_truth PDData(2).TR(:).p_truth];
%                                 end
%                                 
                                confidence.PDC(:,blockDT,subj) = [PDData(1).TR(:).c_trueconf PDData(2).TR(:).c_trueconf];
                                confidence.PDP(:,blockDT,subj) = [PDData(1).TR(:).p_trueconf PDData(2).TR(:).p_trueconf];
                                truth.PDC(:,blockDT,subj) = [PDData(1).TR(:).c_truth PDData(2).TR(:).c_truth];
                                truth.PDP(:,blockDT,subj) = [PDData(1).TR(:).p_truth PDData(2).TR(:).p_truth];
                                
                            end
                            blockDT = blockDT + 1;
                        end
                    end
            end
        end
    end
end

