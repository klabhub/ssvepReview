% This script generates the topoplot of the paper that summarizes the findings
% across published studies.
%
% Companion code for:
%
% Steady state visual evoked potentials in schizophrenia: A review
% Alexander Schielke & Bart Krekelberg
% Center for Molecular and Behavioral Neuroscience
% Rutgers University - Newark 


setupElectrodes;            % Define electrodes
ssvepTable = reviewData;    % Get the table with the data.
resultMain= analyzeData(ssvepTable);   % Analyze/summarize across studies


%% Plot topoplots
frequencyBands = fieldnames(ssvepTable.results);

% plot the proportions template
t = linspace(0, 2*pi,1000);
r = 15;
x = r*cos(t);
y = r*sin(t);

% plot ttest proportions template
r = 20;
xP = r*cos(t);
yP = r*sin(t);

% head template
r = 180;
xC = r*cos(t);
yC = r*sin(t);

%plot ttest proportions for each frequency band template
r = 190;
xHP = r*cos(t);
yHP = r*sin(t);

% plot ttest proportions for each frequency band template
r = 195;
xLHP = r*cos(t);
yLHP = r*sin(t);

% plot the proportions template
r = 60;
xLEL = r*cos(t);
yLEL = r*sin(t);

% plot ttest proportions template
r = 75;
xPEL = r*cos(t);
yPEL = r*sin(t);


fig = figure;
set(fig,'color','w');
fig.PaperUnits = 'centimeters';
fig.Units = 'centimeters';
fig.PaperPosition = [.5 0 18 12.5];
fig.PaperSize = [18 12.5];
fig.Position = [.5 0 18 12.5];



electrodeCntr = length(keepElectrodes);
for frequencyBandCntr = 1:5
    clearvars propOfFreqIdx

    sp{frequencyBandCntr} = subplot(2,3,frequencyBandCntr); %#ok<SAGROW> 

    % plot freqProportion (How frequently is this band investigated)
    ttestPropOfFreq = resultMain.(frequencyBands{frequencyBandCntr}).propTTestOfTotal;
    ttestPropOfFreqCoordinates = [750-(ttestPropOfFreq/2)*1000 750+(ttestPropOfFreq/2)*1000];
    propOfFreqIdx.patchX{1} = [0 xHP(floor(ttestPropOfFreqCoordinates(1)):ceil(ttestPropOfFreqCoordinates(2)))];
    propOfFreqIdx.patchY{1} = [0 yHP(floor(ttestPropOfFreqCoordinates(1)):ceil(ttestPropOfFreqCoordinates(2)))];
    patch(propOfFreqIdx.patchX{1}, propOfFreqIdx.patchY{1}, 'k'); hold on;
    %plot head
    patch(xC, yC, 'w'); hold on;
    centerForNoseIdx = knnsearch(xC',0);
    line([xC(centerForNoseIdx-25) 0], [yC(centerForNoseIdx-25) 205],'color','k');
    line([xC(centerForNoseIdx+25) 0], [yC(centerForNoseIdx+25) 205],'color','k');


    clearvars ringIdx ttestPropAll ttestPropPerFreq
    electrodeFieldNames = fieldnames(resultMain.(frequencyBands{frequencyBandCntr}));
    for electrodeCntr = 1:length(electrodeFieldNames)-1
        tempProportions = resultMain.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).proportions;
        tempCoordinates = ten20Coordinates.(keepElectrodes{electrodeCntr});
        ttestPropAll(electrodeCntr) = resultMain.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).propTTestOfTotal;
        ttestPropPerFreq(electrodeCntr) = resultMain.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).propTTestWithinFreqBand;
        startProp = 1;
       for propCntr = 1:numel(tempProportions)
            ringIdx(electrodeCntr).start(propCntr) = startProp;
            ringIdx(electrodeCntr).stop(propCntr) = round(ringIdx(electrodeCntr).start(propCntr)+tempProportions(propCntr)*1000);
            startProp = ringIdx(electrodeCntr).stop(propCntr);
            if ringIdx(electrodeCntr).stop(propCntr) >1000
                ringIdx(electrodeCntr).stop(propCntr) = 1000;
            end
        end
        if sum(tempProportions)==0
            ringIdx(electrodeCntr).start = [1 1 1];
            ringIdx(electrodeCntr).stop = [1 1 1];
        end
        ringIdx(electrodeCntr).coordinates = tempCoordinates;
    end

    patchColors = {'b'; 'r'; 'w'};

    %prepare all electrode patches
    for electrodeCntr = 1:length(ringIdx)
        
        ttestPropAllTemp = [250-ceil(ttestPropAll(electrodeCntr)/2*1000) 250+ceil(ttestPropAll(electrodeCntr)/2*1000)];
        tempXpPropAll = circshift(xP,-ttestPropAllTemp(1));
        tempXpPropAll = tempXpPropAll(1:numel(ttestPropAllTemp(1):ttestPropAllTemp(2)));
        tempYpPropAll = circshift(yP,-ttestPropAllTemp(1));
        tempYpPropAll = tempYpPropAll(1:numel(ttestPropAllTemp(1):ttestPropAllTemp(2)));

        ttestPropPerFreqTemp = [750-ceil(ttestPropPerFreq(electrodeCntr)/2*1000) 750+ceil(ttestPropPerFreq(electrodeCntr)/2*1000)];
        tempXpPropPerFreq = circshift(xP,-ttestPropPerFreqTemp(1));
        tempXpPropPerFreq = tempXpPropPerFreq(1:numel(ttestPropPerFreqTemp(1):ttestPropPerFreqTemp(2)));
        tempYpPropPerFreq = circshift(yP,-ttestPropPerFreqTemp(1));
        tempYpPropPerFreq = tempYpPropPerFreq(1:numel(ttestPropPerFreqTemp(1):ttestPropPerFreqTemp(2)));

        propAllIdx(electrodeCntr).patchX = [0 tempXpPropAll];
        propAllIdx(electrodeCntr).patchY = [0 tempYpPropAll];
        propPerFreqIdx(electrodeCntr).patchX = [0 tempXpPropPerFreq];
        propPerFreqIdx(electrodeCntr).patchY = [0 tempYpPropPerFreq];

        if ~isequal(ttestPropAll(electrodeCntr),0)
            patch(propAllIdx(electrodeCntr).patchX+ringIdx(electrodeCntr).coordinates(1), propAllIdx(electrodeCntr).patchY+ringIdx(electrodeCntr).coordinates(2), 'k'); hold on;
        end
        if ~isequal(ttestPropPerFreq(electrodeCntr),0)
            patch(propPerFreqIdx(electrodeCntr).patchX+ringIdx(electrodeCntr).coordinates(1), propPerFreqIdx(electrodeCntr).patchY+ringIdx(electrodeCntr).coordinates(2), 'k'); hold on;
        end
            patch(x +ringIdx(electrodeCntr).coordinates(1), y+ringIdx(electrodeCntr).coordinates(2), 'w')
        for patchCntr = 1:numel(ringIdx(electrodeCntr).start)
            if patchCntr == 1
                if numel(ringIdx(electrodeCntr).start(1):ringIdx(electrodeCntr).stop(1))>1
                    shiftFactor = 250-round(numel(ringIdx(electrodeCntr).start(1):ringIdx(electrodeCntr).stop(1))/2);
                else
                    shiftFactor = 0;
                end
            end
            xShifted = circshift(x,-shiftFactor);
            yShifted = circshift(y,-shiftFactor);

            if sum(ringIdx(electrodeCntr).start)==3 && sum(ringIdx(electrodeCntr).stop)==3

            elseif sum(ringIdx(electrodeCntr).start)==3 && any(ringIdx(electrodeCntr).stop>1)
                ringIdx(electrodeCntr).patchX{patchCntr} = xShifted(ringIdx(electrodeCntr).start(patchCntr):ringIdx(electrodeCntr).stop(patchCntr));
                ringIdx(electrodeCntr).patchY{patchCntr} = yShifted(ringIdx(electrodeCntr).start(patchCntr):ringIdx(electrodeCntr).stop(patchCntr));

                ringIdx(electrodeCntr).patchX{patchCntr} = ringIdx(electrodeCntr).patchX{patchCntr}+ringIdx(electrodeCntr).coordinates(1);
                ringIdx(electrodeCntr).patchY{patchCntr} = ringIdx(electrodeCntr).patchY{patchCntr}+ringIdx(electrodeCntr).coordinates(2);
                plot(ringIdx(electrodeCntr).patchX{patchCntr}, ringIdx(electrodeCntr).patchY{patchCntr}, 'k'); hold on;
            else
                ringIdx(electrodeCntr).patchX{patchCntr} = [0 xShifted(ringIdx(electrodeCntr).start(patchCntr):ringIdx(electrodeCntr).stop(patchCntr))];
                ringIdx(electrodeCntr).patchY{patchCntr} = [0 yShifted(ringIdx(electrodeCntr).start(patchCntr):ringIdx(electrodeCntr).stop(patchCntr))];

                ringIdx(electrodeCntr).patchX{patchCntr} = ringIdx(electrodeCntr).patchX{patchCntr}+ringIdx(electrodeCntr).coordinates(1);
                ringIdx(electrodeCntr).patchY{patchCntr} = ringIdx(electrodeCntr).patchY{patchCntr}+ringIdx(electrodeCntr).coordinates(2);

                patch(ringIdx(electrodeCntr).patchX{patchCntr}, ringIdx(electrodeCntr).patchY{patchCntr}, patchColors{patchCntr}); hold on;
            end
        end
    end
    axis off
    axis equal
end

sp{6} = subplot(2,3,6);
axis off
axis equal
sp{1}.Position = [0.03 0.5 0.3 0.5];
sp{2}.Position = [0.35 0.5 0.3 0.5];
sp{3}.Position = [0.67 0.5 0.3 0.5];

sp{4}.Position = [0.03 0 0.3 0.5];
sp{5}.Position = [0.35 0 0.3 0.5];
sp{6}.Position = [0.67 0 0.3 0.5];


% add a legend
ttestPropOfFreq = 0.3;
ttestPropOfFreqCoordinates = [750-(ttestPropOfFreq/2)*1000 750+(ttestPropOfFreq/2)*1000];
propOfFreqIdxLegend.patchX{patchCntr} = [0 xLHP(floor(ttestPropOfFreqCoordinates(1)):ceil(ttestPropOfFreqCoordinates(2)))];
propOfFreqIdxLegend.patchY{patchCntr} = [0 yLHP(floor(ttestPropOfFreqCoordinates(1)):ceil(ttestPropOfFreqCoordinates(2)))];
patch(propOfFreqIdxLegend.patchX{patchCntr}, propOfFreqIdxLegend.patchY{patchCntr}, 'k'); hold on;

%plot head
patch(xC, yC, 'w'); hold on;
centerForNoseIdx = knnsearch(xC',0);
line([xC(centerForNoseIdx-25) 0], [yC(centerForNoseIdx-25) 205],'color','k');
line([xC(centerForNoseIdx+25) 0], [yC(centerForNoseIdx+25) 205],'color','k');

%plot legend proportion ttest donuts
ttestPropAllTemp = [250-ceil(0.15/2*1000) 250+ceil(0.15/2*1000)];
tempXpPropAll = circshift(xPEL,-ttestPropAllTemp(1));
tempXpPropAll = tempXpPropAll(1:numel(ttestPropAllTemp(1):ttestPropAllTemp(2)));
tempYpPropAll = circshift(yPEL,-ttestPropAllTemp(1));
tempYpPropAll = tempYpPropAll(1:numel(ttestPropAllTemp(1):ttestPropAllTemp(2)));

ttestPropPerFreqTemp = [750-ceil(0.3/2*1000) 750+ceil(0.3/2*1000)];
tempXpPropPerFreq = circshift(xPEL,-ttestPropPerFreqTemp(1));
tempXpPropPerFreq = tempXpPropPerFreq(1:numel(ttestPropPerFreqTemp(1):ttestPropPerFreqTemp(2)));
tempYpPropPerFreq = circshift(yPEL,-ttestPropPerFreqTemp(1));
tempYpPropPerFreq = tempYpPropPerFreq(1:numel(ttestPropPerFreqTemp(1):ttestPropPerFreqTemp(2)));

propAllIdxLegend.patchX = [0 tempXpPropAll];
propAllIdxLegend.patchY = [0 tempYpPropAll];
propPerFreqIdxLegend.patchX = [0 tempXpPropPerFreq];
propPerFreqIdxLegend.patchY = [0 tempYpPropPerFreq];

patch(xC, yC, 'w'); hold on;

patch(propAllIdxLegend.patchX,propAllIdxLegend.patchY,'k');
patch(propPerFreqIdxLegend.patchX,propPerFreqIdxLegend.patchY,'k');
patch(xLEL,yLEL,'w');

%add proportion indicators
shiftFactor = 250-round(333/2);

xShifted = circshift(xLEL,-shiftFactor);
yShifted = circshift(yLEL,-shiftFactor);

ringIdxLegend.patchX{1} = [0 xShifted(1:334)];
ringIdxLegend.patchX{2} = [0 xShifted(334:667)];
ringIdxLegend.patchX{3} = [0 xShifted(667:1000)];

ringIdxLegend.patchY{1} = [0 yShifted(1:334)];
ringIdxLegend.patchY{2} = [0 yShifted(334:667)];
ringIdxLegend.patchY{3} = [0 yShifted(667:1000)];

for patchCntr = 1:3
    patch(ringIdxLegend.patchX{patchCntr}, ringIdxLegend.patchY{patchCntr}, patchColors{patchCntr}); hold on;
end

sp{6}.XLim = [-180  180.0000*4];
yCoordinates = [410 235 105 -25 -215 -420];

ll1 = line([0 185],[80 yCoordinates(1)],'color','k','LineWidth',2); %prop all
ll2 = line([181 220],[yCoordinates(1) yCoordinates(1)],'color','k','LineWidth',2); %prop all - line
l21 = line([20 185],[30 yCoordinates(2)],'color','k','LineWidth',2); %blue prop
l22 = line([182 220],[yCoordinates(2) yCoordinates(2)],'color','k','LineWidth',2); %blue prop - line
l31 = line([-30 185],[-30 yCoordinates(3)],'color','k','LineWidth',2);%prop red
l32= line([182 220],[yCoordinates(3) yCoordinates(3)],'color','k','LineWidth',2); %prop red - line
l41 = line([20 185],[-30 yCoordinates(4)],'color','k','LineWidth',2);%prop white
l42 = line([182 220],[yCoordinates(4) yCoordinates(4)],'color','k','LineWidth',2); %prop white - line
l51 = line([0 185],[-80 yCoordinates(5)],'color','k','LineWidth',2);%prop within freq
l52 = line([182 220],[yCoordinates(5) yCoordinates(5)],'color','k','LineWidth',2); %prop within freq - line
l61 = line([0 185],[-200 yCoordinates(6)],'color','k','LineWidth',2);%prop of freq
l62 = line([181 220],[yCoordinates(6) yCoordinates(6)],'color','k','LineWidth',2); %within freq compared to all


tt1 = text(230,yCoordinates(1),{'tests at this electrode'; '          all tests     '},'HorizontalAlignment','left','FontSize',8);
tt2 = text(230,yCoordinates(2),{'proportion tests SZ < C'},'HorizontalAlignment','left','FontSize',8,'BackgroundColor',[0.7 0.7 0.7]);
tt3 = text(230,yCoordinates(3),{'proportion tests SZ > C'},'HorizontalAlignment','left','FontSize',8);
tt4 = text(230,yCoordinates(4),{'proportion tests p > .05'},'HorizontalAlignment','left','FontSize',8,'BackgroundColor',[0.7 0.7 0.7]);
tt5 = text(230,yCoordinates(5),{'tests at this electrode'; 'tests within freq. band'},'HorizontalAlignment','left','FontSize',8);
tt6 = text(230,yCoordinates(6),{'tests within freq. band'; '           all tests     '},'HorizontalAlignment','left','FontSize',8,'BackgroundColor',[0.7 0.7 0.7]);


l13 = line([250 665],[yCoordinates(1) yCoordinates(1)],'color','k','LineWidth',2); %prop all - division
l53 = line([250 665],[yCoordinates(5) yCoordinates(5)],'color','k','LineWidth',2); %prop within freq - line
l63 = line([250 665],[yCoordinates(6) yCoordinates(6)],'color','k','LineWidth',2); %within freq compared to all



ttt1 =text(-2, 2, '\delta','Units','normalized','FontSize',20,'FontWeight','bold');
ttt2 =text(-1, 2, '\theta','Units','normalized','FontSize',20,'FontWeight','bold');
ttt3 =text(0, 2, '\alpha','Units','normalized','FontSize',20,'FontWeight','bold');
ttt4 =text(-2, 1, '\beta','Units','normalized','FontSize',20,'FontWeight','bold');
ttt5 =text(-1, 1, '\gamma','Units','normalized','FontSize',20,'FontWeight','bold');




% Save for printing/including in paper.
	saveFolder ='';
 	plotName = 'ssvepTopo';

	savePath = [saveFolder plotName];
 	exportgraphics(fig,[savePath '.pdf'],'Resolution',1000)
    close(fig)
  
  
  
