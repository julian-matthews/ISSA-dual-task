function [Concat Files] = concat_1

%% Concatenate data from all sessions per subject
% Concat:   Concatenated data
% Files:    Files that were used for concatenating data

Files = {'01_JT/01_JT_', '02_DA/02_DA_', '03_BK/03_BK_', '04_JK/04_JK_', '05_AN/05_AN_', '06_MS/06_MS_', '07_KK/07_KK_', '08_LE/08_LE_'};
Exp = 'Exp1/';
Path = ['../data/raw/' Exp];



nSessions = 3;
nRuns = 4;

aux = cell(1,length(Files));

Concat = struct('CSTdata', aux, 'PSTdata', aux, 'DTdata', aux);


for f = 1:length(Files)

Concat(f).CSTdata.c_intensity = [];
Concat(f).CSTdata.c_response = [];
Concat(f).CSTdata.c_confidence = [];
Concat(f).CSTdata.c_keyid = [];
Concat(f).CSTdata.c_decision = [];

Concat(f).PSTdata.p_intensity = [];
Concat(f).PSTdata.p_response = [];
Concat(f).PSTdata.p_confidence = [];
Concat(f).PSTdata.p_keyid = [];
Concat(f).PSTdata.p_decision = [];

Concat(f).DTdata.c_intensity = [];
Concat(f).DTdata.c_response = [];
Concat(f).DTdata.c_confidence = [];
Concat(f).DTdata.c_keyid = [];
Concat(f).DTdata.c_decision = [];
Concat(f).DTdata.p_intensity = [];
Concat(f).DTdata.p_response = [];
Concat(f).DTdata.p_confidence = [];
Concat(f).DTdata.p_keyid = [];
Concat(f).DTdata.p_decision = [];

for s = 1:nSessions
    for r = 1:nRuns
        
        if exist([Path Files{f} num2str(s) '_' num2str(r) '.mat'], 'file');
            
            load([Path Files{f} num2str(s) '_' num2str(r)], 'Data');
            
            % Use central trials (cond == 1)
            centralAux = Data([Data.condition] == 1);
            l = length(centralAux);
            
            % Concatenate trials from all blocks and sessions
            for c = 1:l

                Concat(f).CSTdata.c_intensity = cat(2,Concat(f).CSTdata.c_intensity,[centralAux(c).TR(:).cSOA]);
                Concat(f).CSTdata.c_response = cat(2,Concat(f).CSTdata.c_response,[centralAux(c).TR(:).c_response]);
                Concat(f).CSTdata.c_confidence = cat(2,Concat(f).CSTdata.c_confidence,[centralAux(c).TR(:).c_confidence]);       
                Concat(f).CSTdata.c_keyid = cat(2,Concat(f).CSTdata.c_keyid,[centralAux(c).TR(:).c_keyid]);
                
            end
                                   
            % Use peripheral trials (cond == 2)
            periphAux = Data([Data.condition] == 2);
            l = length(periphAux);
            
            % Concatenate trials from all blocks and sessions
            for c = 1:l

                Concat(f).PSTdata.p_intensity = cat(2,Concat(f).PSTdata.p_intensity,[periphAux(c).TR(:).pSOA]);
                Concat(f).PSTdata.p_response = cat(2,Concat(f).PSTdata.p_response,[periphAux(c).TR(:).p_response]);
                Concat(f).PSTdata.p_confidence = cat(2,Concat(f).PSTdata.p_confidence,[periphAux(c).TR(:).p_confidence]);
                Concat(f).PSTdata.p_keyid = cat(2,Concat(f).PSTdata.p_keyid,[periphAux(c).TR(:).p_keyid]);
                
            end
            
            % Use dual trials (cond == 3) but not from training session (20
            % trials)
            if ~(s==1 && r==2)
                dualAux = Data([Data.condition] == 3);
                l = length(dualAux);
                
                % Concatenate trials from all blocks and sessions
                for c = 1:l

                    Concat(f).DTdata.p_intensity = cat(2,Concat(f).DTdata.p_intensity,[dualAux(c).TR(:).pSOA]);
                    Concat(f).DTdata.c_intensity = cat(2,Concat(f).DTdata.c_intensity,[dualAux(c).TR(:).cSOA]);
                    Concat(f).DTdata.p_response = cat(2,Concat(f).DTdata.p_response,[dualAux(c).TR(:).p_response]);
                    Concat(f).DTdata.c_response = cat(2,Concat(f).DTdata.c_response,[dualAux(c).TR(:).c_response]);
                    Concat(f).DTdata.p_confidence = cat(2,Concat(f).DTdata.p_confidence,[dualAux(c).TR(:).p_confidence]);
                    Concat(f).DTdata.c_confidence = cat(2,Concat(f).DTdata.c_confidence,[dualAux(c).TR(:).c_confidence]);
                    Concat(f).DTdata.c_keyid = cat(2,Concat(f).DTdata.c_keyid,[dualAux(c).TR(:).c_keyid]);
                    Concat(f).DTdata.p_keyid = cat(2,Concat(f).DTdata.p_keyid,[dualAux(c).TR(:).p_keyid]);
                    
                end
            end
        end
    end
end

%% SWITCH keyid VALUES TO CORRESPONDING -1 & 1 (LEFT/RIGHT)

for trial = 1:length(Concat(f).CSTdata.c_keyid)
    if Concat(f).CSTdata.c_keyid(trial) == 1
        Concat(f).CSTdata.c_keyid(trial) = -1;
    elseif Concat(f).CSTdata.c_keyid(trial) == 2
        Concat(f).CSTdata.c_keyid(trial) = 1;
    end
end

for trial = 1:length(Concat(f).PSTdata.p_keyid)
    if Concat(f).PSTdata.p_keyid(trial) == 1
        Concat(f).PSTdata.p_keyid(trial) = -1;
    elseif Concat(f).PSTdata.p_keyid(trial) == 2
        Concat(f).PSTdata.p_keyid(trial) = 1;
    end
end

for trial = 1:length(Concat(f).DTdata.c_keyid)
    if Concat(f).DTdata.c_keyid(trial) == 1
        Concat(f).DTdata.c_keyid(trial) = -1;
    elseif Concat(f).DTdata.c_keyid(trial) == 2
        Concat(f).DTdata.c_keyid(trial) = 1;
    end
end

for trial = 1:length(Concat(f).DTdata.p_keyid)
    if Concat(f).DTdata.p_keyid(trial) == 1
        Concat(f).DTdata.p_keyid(trial) = -1;
    elseif Concat(f).DTdata.p_keyid(trial) == 2
        Concat(f).DTdata.p_keyid(trial) = 1;
    end
end

%% DEFINE PARTICIPANTS' RESPONSE FOR type-I AUC CALCULATION

% Central Single Task
for trial = 1:length(Concat(f).CSTdata.c_keyid);
    if Concat(f).CSTdata.c_response(trial) == 1
        Concat(f).CSTdata.c_decision(trial) = Concat(f).CSTdata.c_keyid(trial);
    elseif Concat(f).CSTdata.c_response(trial) == 0
        if Concat(f).CSTdata.c_keyid(trial) == 1
            Concat(f).CSTdata.c_decision(trial) = -1;
        elseif Concat(f).CSTdata.c_keyid(trial) == -1
            Concat(f).CSTdata.c_decision(trial) = 1;
        end
    end
end

% Peripheral Single Task
for trial = 1:length(Concat(f).PSTdata.p_keyid);
    if Concat(f).PSTdata.p_response(trial) == 1
        Concat(f).PSTdata.p_decision(trial) = Concat(f).PSTdata.p_keyid(trial);
    elseif Concat(f).PSTdata.p_response(trial) == 0
        if Concat(f).PSTdata.p_keyid(trial) == 1
            Concat(f).PSTdata.p_decision(trial) = -1;
        elseif Concat(f).PSTdata.p_keyid(trial) == -1
            Concat(f).PSTdata.p_decision(trial) = 1;
        end
    end
end
    
% Dual Task
for trial = 1:length(Concat(f).DTdata.c_keyid);
    if Concat(f).DTdata.c_response(trial) == 1
        Concat(f).DTdata.c_decision(trial) = Concat(f).DTdata.c_keyid(trial);
    elseif Concat(f).DTdata.c_response(trial) == 0
        if Concat(f).DTdata.c_keyid(trial) == 1
            Concat(f).DTdata.c_decision(trial) = -1;
        elseif Concat(f).DTdata.c_keyid(trial) == -1
            Concat(f).DTdata.c_decision(trial) = 1;
        end
    end
end

for trial = 1:length(Concat(f).DTdata.p_keyid);
    if Concat(f).DTdata.p_response(trial) == 1
        Concat(f).DTdata.p_decision(trial) = Concat(f).DTdata.p_keyid(trial);
    elseif Concat(f).DTdata.p_response(trial) == 0
        if Concat(f).DTdata.p_keyid(trial) == 1
            Concat(f).DTdata.p_decision(trial) = -1;
        elseif Concat(f).DTdata.p_keyid(trial) == -1
            Concat(f).DTdata.p_decision(trial) = 1;
        end
    end
end
    
end

