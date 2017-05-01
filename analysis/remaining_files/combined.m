clear all;
close all;

%% Plots individual confidence on single and dual task as well as
% the co-occurence of correct and incorrect responses in dual task

[Concat1 Files1] = concat_1;
[Concat2 Files2] = concat_2;

Files = Files1;


if ~exist(['../figures/Combined'],'dir')
    mkdir(['../figures/Combined']);
end

FigurePath = ['../figures/Combined/'];

SAVEIT = 1;

subplot = @(m,n,p) subtightplot (m, n, p, [0.005 0], [0.15 0.1], [0.1 0.05]);

%% Discard first 48 trials from ST (1 block)
for subj = 1:length(Concat2)
Concat1(subj).CSTdata.c_intensity = Concat1(subj).CSTdata.c_intensity(49:end);
Concat1(subj).CSTdata.c_response = Concat1(subj).CSTdata.c_response(49:end);
Concat1(subj).CSTdata.c_confidence = Concat1(subj).CSTdata.c_confidence(49:end);

Concat1(subj).PSTdata.p_intensity = Concat1(subj).PSTdata.p_intensity(49:end);
Concat1(subj).PSTdata.p_response = Concat1(subj).PSTdata.p_response(49:end);
Concat1(subj).PSTdata.p_confidence = Concat1(subj).PSTdata.p_confidence(49:end);

Concat2(subj).CSTdata.c_intensity = Concat2(subj).CSTdata.c_intensity(49:end);
Concat2(subj).CSTdata.c_response = Concat2(subj).CSTdata.c_response(49:end);
Concat2(subj).CSTdata.c_confidence = Concat2(subj).CSTdata.c_confidence(49:end);

Concat2(subj).PSTdata.p_intensity = Concat2(subj).PSTdata.p_intensity(49:end);
Concat2(subj).PSTdata.p_response = Concat2(subj).PSTdata.p_response(49:end);
Concat2(subj).PSTdata.p_confidence = Concat2(subj).PSTdata.p_confidence(49:end);
end

%% Individual difference in confidence Exp1 vs Exp2

for s = 1:length(Files)
    
% Single and Dual Task
central_conf(:,:,s) = [mean(Concat1(s).CSTdata.c_confidence) mean(Concat2(s).CSTdata.c_confidence);mean(Concat1(s).DTdata.c_confidence) mean(Concat2(s).DTdata.c_confidence)]';
SDcentral_conf(:,:,s) = [std(Concat1(s).CSTdata.c_confidence) std(Concat2(s).CSTdata.c_confidence);std(Concat1(s).DTdata.c_confidence) std(Concat2(s).DTdata.c_confidence)]';

periph_conf(:,:,s) = [mean(Concat1(s).PSTdata.p_confidence) mean(Concat2(s).PSTdata.p_confidence);mean(Concat1(s).DTdata.p_confidence) mean(Concat2(s).DTdata.p_confidence)]';
SDperiph_conf(:,:,s) = [std(Concat1(s).PSTdata.p_confidence) std(Concat2(s).PSTdata.p_confidence);std(Concat1(s).DTdata.p_confidence) std(Concat2(s).DTdata.p_confidence)]';

end

f = figure(1); set(f,'Position',[0 0 700 700])
s=1;
for sub = 1:2:length(Files)*2
    subplot(length(Files),2,sub)
    set(gca, 'FontSize',16)
    barwitherr(SDcentral_conf(:,:,s),central_conf(:,:,s),.8)
    if sub == 1
        title(['Central']);
    end
    set(gca,'XTickLabel',{'Exp1','Exp2'})
    ylim([0.5 4.5]);
    set(gca,'YTick',[1 2 3 4 ])
    if sub == 5
        ylabel('Confidence')
    end
    
    subplot(length(Files),2,sub+1)
    set(gca, 'FontSize',16)
    barwitherr(SDperiph_conf(:,:,s),periph_conf(:,:,s),.8)
    if sub == 1
        title(['Peripheral']);
        legend('Single','Dual');
    end
    set(gca,'XTickLabel',{'Exp1','Exp2'})
    ylim([0.5 4.5]);
    set(gca,'YTick',[1 2 3 4 ])
    
    s = s+1;
    
end


% Save figure
if SAVEIT
    saveas(gcf,[FigurePath 'Individual_Confidence'],'fig');
end


%% Peripheral Central Response Correlation --> Arousal or Attention?

exp = [49 21 21 09];

for s = 1:length(Concat2)
    obs1(s,:) = [sum(Concat1(s).DTdata.c_response == 1 & Concat1(s).DTdata.p_response == 1) / length(Concat1(s).DTdata.c_response)...
                sum(Concat1(s).DTdata.c_response == 1 & Concat1(s).DTdata.p_response == 0) / length(Concat1(s).DTdata.c_response)...
                sum(Concat1(s).DTdata.c_response == 0 & Concat1(s).DTdata.p_response == 1) / length(Concat1(s).DTdata.c_response)...
                sum(Concat1(s).DTdata.c_response == 0 & Concat1(s).DTdata.p_response == 0) / length(Concat1(s).DTdata.c_response)];
            
    obs2(s,:) = [sum(Concat2(s).DTdata.c_response == 1 & Concat2(s).DTdata.p_response == 1) / length(Concat2(s).DTdata.c_response)...
                sum(Concat2(s).DTdata.c_response == 1 & Concat2(s).DTdata.p_response == 0) / length(Concat2(s).DTdata.c_response)...
                sum(Concat2(s).DTdata.c_response == 0 & Concat2(s).DTdata.p_response == 1) / length(Concat2(s).DTdata.c_response)...
                sum(Concat2(s).DTdata.c_response == 0 & Concat2(s).DTdata.p_response == 0) / length(Concat2(s).DTdata.c_response)];
end

obs1 = obs1 * 100;
obs2 = obs2 * 100;

subplot = @(m,n,p) subtightplot (m, n, p, [0 0], [0.15 0.1], [0.1 0.05]);

f = figure(2); set(f,'Position',[0 0 750 700])

subplot(2,2,1)
set(gca, 'FontSize', 16)
barwitherr([std(obs1(:,1))/sqrt(length(Files1)) std(obs2(:,1))/sqrt(length(Files1))], [mean(obs1(:,1)) mean(obs2(:,1))],.8);
line([0 3],[exp(1) exp(1)],'LineStyle','--','LineWidth',2,'Color','k');
ylim([0 60]); 
set(gca,'YTick',[0 10 20 30 40 50 60])
set(gca,'XTickLabel',{'Exp1','Exp2'})
ylabel('Centre correct (%)');

subplot(2,2,2)
set(gca, 'FontSize', 16)
barwitherr([std(obs1(:,2))/sqrt(length(Files1)) std(obs2(:,2))/sqrt(length(Files1))], [mean(obs1(:,2)) mean(obs2(:,2))],.8);
line([0 3],[exp(2) exp(2)],'LineStyle','--','LineWidth',2,'Color','k');
ylim([0 60]); 
set(gca,'YTick',[])
%set(gca,'XTickLabel',{'expected','observed'})

subplot(2,2,3)
set(gca, 'FontSize', 16)
barwitherr([std(obs1(:,3))/sqrt(length(Files1)) std(obs2(:,3))/sqrt(length(Files1))], [mean(obs1(:,3)) mean(obs2(:,3))],.8);
line([0 3],[exp(3) exp(3)],'LineStyle','--','LineWidth',2,'Color','k');
ylim([0 60]); 
set(gca,'YTick',[0 10 20 30 40 50 60])
set(gca,'XTickLabel',{'Exp1','Exp2'})
ylabel('Centre incorrect (%)');
xlabel('Periphery correct (%)');

subplot(2,2,4)
set(gca, 'FontSize', 16)
barwitherr([std(obs1(:,4))/sqrt(length(Files1)) std(obs2(:,4))/sqrt(length(Files1))], [mean(obs1(:,4)) mean(obs2(:,4))],.8);
line([0 3],[exp(4) exp(4)],'LineStyle','--','LineWidth',2,'Color','k');
ylim([0 60]); 
set(gca,'YTick',[])
set(gca,'XTickLabel',{'Exp1','Exp2'})
xlabel('Periphery incorrect (%)');
%set(gca,'YTick',[1 2 3 4])
%set(gca,'Position',[0.5 0 0.3 .3])
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');

text(0.5, 1,['Association between central and peripheral responses (n = ' num2str(length(Files1)) ')'],'HorizontalAlignment','center','VerticalAlignment', 'top','FontSize',18)

axis square


% Save figure
if SAVEIT
    saveas(gcf,[FigurePath 'Response_Corr_CP'],'fig');
    saveas(gcf,[FigurePath 'Response_Corr_CP'],'jpg');
end
