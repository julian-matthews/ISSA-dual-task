function [confidence z_confidence response] = collect_confidence(Files,Exp)

%% Create matrices that contain all confidence ratings and responses: 
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
    response.SP = zeros(30,10,length(Files));
    response.SC = zeros(30,10,length(Files));
    response.DP = zeros(30,8,length(Files));
    response.DC = zeros(30,8,length(Files));
    response.PDP = zeros(30,8,length(Files));
    response.PDC = zeros(30,8,length(Files));
else
    confidence.SP = zeros(48,10,length(Files));
    confidence.SC = zeros(48,10,length(Files));
    confidence.DP = zeros(48,8,length(Files));
    confidence.DC = zeros(48,8,length(Files));
    response.SP = zeros(48,10,length(Files));
    response.SC = zeros(48,10,length(Files));
    response.DP = zeros(48,8,length(Files));
    response.DC = zeros(48,8,length(Files));
end

for subj = 1:length(Files)
    blockST = 1;
    blockDT = 1;
    for session = 1:3
        for run = 1:4
            
            if ~(session == 1 && run == 2)
                    if exist([Path Files{subj} num2str(session) '_' num2str(run) '_preprocessed.mat'], 'file');
                        
                        load([Path Files{subj} num2str(session) '_' num2str(run) '_preprocessed'], 'Data');
                        
                        % Confidence on Single Task
                        SCData = Data([Data.condition] == 1);
                        SPData = Data([Data.condition] == 2);
                       
                        
                        for b = 1:length(SCData);
                            
                            % 2016-05-09 - Step no longer necessary
                            
                            % Subject2 : Only 20 trials in Session 1 run 3 and 4 --> add nan to get
                            % arrays of length 30
                            
                            %  if strcmp(Exp,'Exp2/') && subj == 2 && session == 1 && (run == 3 || run == 4)
                            %      confidence.SC(:,blockST,subj) = [SCData(b).TR(:).c_confidence NaN(1,10)];
                            %      confidence.SP(:,blockST,subj) = [SPData(b).TR(:).p_confidence NaN(1,10)];
                            %      response.SC(:,blockST,subj) = [SCData(b).TR(:).c_response NaN(1,10)];
                            %      response.SP(:,blockST,subj) = [SPData(b).TR(:).p_response NaN(1,10)];
                            %  else
                            %      confidence.SC(:,blockST,subj) = [SCData(b).TR(:).c_confidence];
                            %      confidence.SP(:,blockST,subj) = [SPData(b).TR(:).p_confidence];
                            %      response.SC(:,blockST,subj) = [SCData(b).TR(:).c_response];
                            %      response.SP(:,blockST,subj) = [SPData(b).TR(:).p_response];
                            %  end
                            
                            confidence.SC(:,blockST,subj) = [SCData(b).TR(:).c_confidence];
                            confidence.SP(:,blockST,subj) = [SPData(b).TR(:).p_confidence];
                            response.SC(:,blockST,subj) = [SCData(b).TR(:).c_response];
                            response.SP(:,blockST,subj) = [SPData(b).TR(:).p_response];
                            
                            blockST = blockST + 1;
                        end
                        
                        % Confidence on Dual Task
                        if ~(session == 1 && run == 1)
                            DData = Data([Data.condition] == 3);
                            
                            % 2016-05-09 - Step no longer necessary
                            
                            % Subject2 : Only 20 trials in Session 1 run 3 and 4 --> add nan to get
                            % arrays of length 30                            
                            % if strcmp(Exp,'Exp2/') && subj == 2 && session == 1 && (run == 3 || run == 4)
                            %    confidence.DC(:,blockDT,subj) = [DData(1).TR(:).c_confidence NaN(1,10)];
                            %    confidence.DP(:,blockDT,subj) = [DData(1).TR(:).p_confidence NaN(1,10)];
                            %    response.DC(:,blockDT,subj) = [DData(1).TR(:).c_response NaN(1,10)];
                            %    response.DP(:,blockDT,subj) = [DData(1).TR(:).p_response NaN(1,10)];
                            % else
                            %    confidence.DC(:,blockDT,subj) = [DData(1).TR(:).c_confidence];
                            %    confidence.DP(:,blockDT,subj) = [DData(1).TR(:).p_confidence];
                            %    response.DC(:,blockDT,subj) = [DData(1).TR(:).c_response];
                            %    response.DP(:,blockDT,subj) = [DData(1).TR(:).p_response];
                            % end
                            
                            confidence.DC(:,blockDT,subj) = [DData(1).TR(:).c_confidence];
                            confidence.DP(:,blockDT,subj) = [DData(1).TR(:).p_confidence];
                            response.DC(:,blockDT,subj) = [DData(1).TR(:).c_response];
                            response.DP(:,blockDT,subj) = [DData(1).TR(:).p_response];
                            
                            
                            if strcmp(Exp,'Exp2/')
                                PDData = Data([Data.condition] == 4);
                                
                                % Subject removed so this step not necessary
                                
                                % Subject2 : Only 20 trials in Session 1 run 3 and 4 --> add nan to get
                                % arrays of length 30                            
%                                 if subj == 2 && session == 1 && (run == 3 || run == 4)
%                                     confidence.PDC(:,blockDT,subj) = [PDData(1).TR(:).c_confidence NaN(1,5) PDData(2).TR(:).c_confidence NaN(1,5)];
%                                     confidence.PDP(:,blockDT,subj) = [PDData(1).TR(:).p_confidence NaN(1,5) PDData(2).TR(:).p_confidence NaN(1,5)];
%                                     response.PDC(:,blockDT,subj) = [PDData(1).TR(:).c_response NaN(1,5) PDData(2).TR(:).c_response NaN(1,5)];
%                                     response.PDP(:,blockDT,subj) = [PDData(1).TR(:).p_response NaN(1,5) PDData(2).TR(:).p_response NaN(1,5)];
%                                 else
%                                     confidence.PDC(:,blockDT,subj) = [PDData(1).TR(:).c_confidence PDData(2).TR(:).c_confidence];
%                                     confidence.PDP(:,blockDT,subj) = [PDData(1).TR(:).p_confidence PDData(2).TR(:).p_confidence];
%                                     response.PDC(:,blockDT,subj) = [PDData(1).TR(:).c_response PDData(2).TR(:).c_response];
%                                     response.PDP(:,blockDT,subj) = [PDData(1).TR(:).p_response PDData(2).TR(:).p_response];
%                                 end
%                                 
                                confidence.PDC(:,blockDT,subj) = [PDData(1).TR(:).c_confidence PDData(2).TR(:).c_confidence];
                                confidence.PDP(:,blockDT,subj) = [PDData(1).TR(:).p_confidence PDData(2).TR(:).p_confidence];
                                response.PDC(:,blockDT,subj) = [PDData(1).TR(:).c_response PDData(2).TR(:).c_response];
                                response.PDP(:,blockDT,subj) = [PDData(1).TR(:).p_response PDData(2).TR(:).p_response];
                                
                            end
                            blockDT = blockDT + 1;
                        end
                    end
            end
        end
    end
end

%% Normalization (z-scores)

SC = reshape(confidence.SC,length(confidence.SC)*10,length(Files));
SP = reshape(confidence.SP,length(confidence.SP)*10,length(Files));

meanSC(1:length(Files)) = nanmean(SC);
meanSP(1:length(Files)) = nanmean(SP);

stdSC(1:length(Files)) = nanstd(SC);
stdSP(1:length(Files)) = nanstd(SP);

for subj = 1:length(Files)
    z_confidence.SC(:,:,subj) = (confidence.SC(:,:,subj) - meanSC(subj)) / stdSC(subj);
    z_confidence.SP(:,:,subj) = (confidence.SP(:,:,subj) - meanSP(subj)) / stdSP(subj);
    z_confidence.DC(:,:,subj) = (confidence.DC(:,:,subj) - meanSC(subj)) / stdSC(subj);
    z_confidence.DP(:,:,subj) = (confidence.DP(:,:,subj) - meanSP(subj)) / stdSP(subj);   
    
    if strcmp(Exp,'Exp2/')
        z_confidence.PDC(:,:,subj) = (confidence.PDC(:,:,subj) - meanSC(subj)) / stdSC(subj);
        z_confidence.PDP(:,:,subj) = (confidence.PDP(:,:,subj) - meanSP(subj)) / stdSP(subj); 
    end
end

