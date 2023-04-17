function resultMain= analyzeData(ssvepTable,clusterNames)
% This function summarizes the data across papers 
% 
%  Steady state visual evoked potentials in schizophrenia: A review
%  Schielke & Krekelberg.


setupElectrodes;

%% Combine across papers
frequencyBands = fieldnames(ssvepTable.results);
allElectrodes = {};
for frequencyBandCntr = 1:length(frequencyBands)
    tempElectrodes = fieldnames(ssvepTable.results.(frequencyBands{frequencyBandCntr}));

    allElectrodes = cat(1,allElectrodes,tempElectrodes);
end
allElectrodes = unique(allElectrodes);

allMeasures = {};
tempMeasures = {};
for frequencyBandCntr = 1:length(frequencyBands)
    for electrodeCntr = 1:length(allElectrodes)
        tempMeasures = [];
        try
            tempMeasures = fieldnames(ssvepTable.results.(frequencyBands{frequencyBandCntr}).(allElectrodes{electrodeCntr}));
            allMeasures = cat(1,allMeasures,tempMeasures);
        catch
        end
    end
end
allMeasures = unique(allMeasures);

% Exclude coherence and noise as outcomes
iscMeasures = {'coherence','coherenceReactivity','pliBcPower'};
excludedMeasures = {'noise'};
mainMeasures = setdiff(allMeasures,iscMeasures);
mainMeasures = setdiff(mainMeasures,excludedMeasures);

% Combine main measure results
for frequencyBandCntr = 1:length(frequencyBands)
    for electrodeCntr = 1:length(allElectrodes)
        resultTable.(frequencyBands{frequencyBandCntr}).(allElectrodes{electrodeCntr}).sig = [];
        resultTable.(frequencyBands{frequencyBandCntr}).(allElectrodes{electrodeCntr}).difference = [];
        resultTable.(frequencyBands{frequencyBandCntr}).(allElectrodes{electrodeCntr}).N = [];
        for mainMeasureCntr = 1:length(mainMeasures)            
            try
                tempResults = ssvepTable.results.(frequencyBands{frequencyBandCntr}).(allElectrodes{electrodeCntr}).(mainMeasures{mainMeasureCntr}).sig;
                tempSign = ssvepTable.results.(frequencyBands{frequencyBandCntr}).(allElectrodes{electrodeCntr}).(mainMeasures{mainMeasureCntr}).difference;
                for tempCntr = 1:length(ssvepTable.name)
                    if length(tempResults)<tempCntr
                        tempResultsAll = NaN;
                        tempSignAll = NaN;
                        tempNAll = [NaN NaN];
                    elseif ~isempty(tempResults{tempCntr})
                        tempResultsAll = tempResults{tempCntr};
                        tempSignAll = tempSign{tempCntr};
                        tempNAll = repmat([ssvepTable.participants.control.n{tempCntr} ssvepTable.participants.sz.n{tempCntr}],[size(tempResultsAll,1) 1]);
                    else
                        tempResultsAll = NaN;
                        tempSignAll = NaN;
                        tempNAll = [NaN NaN];
                    end
                    resultTable.(frequencyBands{frequencyBandCntr}).(allElectrodes{electrodeCntr}).sig          = cat(1,resultTable.(frequencyBands{frequencyBandCntr}).(allElectrodes{electrodeCntr}).sig ,tempResultsAll);
                    resultTable.(frequencyBands{frequencyBandCntr}).(allElectrodes{electrodeCntr}).difference   = cat(1,resultTable.(frequencyBands{frequencyBandCntr}).(allElectrodes{electrodeCntr}).difference ,tempSignAll);
                    resultTable.(frequencyBands{frequencyBandCntr}).(allElectrodes{electrodeCntr}).N            = cat(1,resultTable.(frequencyBands{frequencyBandCntr}).(allElectrodes{electrodeCntr}).N,tempNAll);
                end
            catch
                %do nothing
            end
        end
    end
end


% Count how many t-test we have at this point
nrTTestsAll = 0;
for frequencyBandCntr = 1:length(frequencyBands)
    nrTTestsTemp = 0;
    for electrodeCntr = 1:length(allElectrodes)
        resultTable.(frequencyBands{frequencyBandCntr}).(allElectrodes{electrodeCntr}).nrTTestWO = sum(~isnan(resultTable.(frequencyBands{frequencyBandCntr}).(allElectrodes{electrodeCntr}).sig));
        nrTTestsTemp = nrTTestsTemp+sum(~isnan(resultTable.(frequencyBands{frequencyBandCntr}).(allElectrodes{electrodeCntr}).sig));
    end
    nrTTestsAll = nrTTestsAll+nrTTestsTemp;
    resultTable.(frequencyBands{frequencyBandCntr}).nrTTestsWO = nrTTestsTemp;
end
resultTable.nrTTestsWO = nrTTestsAll;



% Add the clusters to the single electrodes
clusterElectrodeNames = fieldnames(clusterNames);
for frequencyBandCntr = 1:length(frequencyBands)
    for electrodeCntr = 1:length(clusterElectrodeNames)      
        try
            tempSig             = resultTable.(frequencyBands{frequencyBandCntr}).(clusterElectrodeNames{electrodeCntr}).sig;
            tempDifference      = resultTable.(frequencyBands{frequencyBandCntr}).(clusterElectrodeNames{electrodeCntr}).difference;
            tempN               = resultTable.(frequencyBands{frequencyBandCntr}).(clusterElectrodeNames{electrodeCntr}).N;
            assert(size(tempN,1)==size(tempSig,1))
            subElFields = clusterNames.(clusterElectrodeNames{electrodeCntr});
            for subElFieldContr = 1:length(subElFields)
                if ~isfield(resultTable.(frequencyBands{frequencyBandCntr}),(subElFields{subElFieldContr}))
                    resultTable.(frequencyBands{frequencyBandCntr}).(subElFields{subElFieldContr}).sig = [];
                    resultTable.(frequencyBands{frequencyBandCntr}).(subElFields{subElFieldContr}).difference = [];
                    resultTable.(frequencyBands{frequencyBandCntr}).(subElFields{subElFieldContr}).N = [];
                end
                resultTable.(frequencyBands{frequencyBandCntr}).(subElFields{subElFieldContr}).sig          = cat(1,resultTable.(frequencyBands{frequencyBandCntr}).(subElFields{subElFieldContr}).sig,tempSig);
                resultTable.(frequencyBands{frequencyBandCntr}).(subElFields{subElFieldContr}).difference   = cat(1,resultTable.(frequencyBands{frequencyBandCntr}).(subElFields{subElFieldContr}).difference,tempDifference);
                resultTable.(frequencyBands{frequencyBandCntr}).(subElFields{subElFieldContr}).N            = cat(1,resultTable.(frequencyBands{frequencyBandCntr}).(subElFields{subElFieldContr}).N,tempN);
                  assert(size(resultTable.(frequencyBands{frequencyBandCntr}).(subElFields{subElFieldContr}).N ,1)==size(resultTable.(frequencyBands{frequencyBandCntr}).(subElFields{subElFieldContr}).sig,1))
            end
        catch
            %do nothing
        end
    end
end


% Remove the electrodes for which we don't have any results
for frequencyBandCntr = 1:length(frequencyBands)
    for electrodeCntr = 1:length(keepElectrodes)
        proportions = [];
        keepEntries = ~isnan(resultTable.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).sig);
        resultMain.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).sig          = resultTable.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).sig(keepEntries);
        resultMain.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).difference   = resultTable.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).difference(keepEntries);
        resultMain.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).N            = resultTable.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).N(keepEntries,:);
        if sum(keepEntries)==0
            proportions(1) = 0;
            proportions(2) = 0;
            proportions(3) = 0;
        else
            proportions(1) = sum(resultMain.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).difference==-1)/sum(keepEntries);
            proportions(2) = sum(resultMain.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).difference==1)/sum(keepEntries);
            proportions(3) = sum(resultMain.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).difference==0)/sum(keepEntries);
        end
        resultMain.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).proportions = proportions;
    end
end


% Repeat the count of t-test
resultMain.nrTTestsWO= resultTable.nrTTestsWO;
for frequencyBandCntr = 1:length(frequencyBands)
    for electrodeCntr = 1:length(keepElectrodes)
        resultMain.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).nrTTest                  = sum(~isnan(resultMain.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).sig));
        resultMain.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).propTTestWithinFreqBand  = resultMain.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).nrTTest/resultTable.(frequencyBands{frequencyBandCntr}).nrTTestsWO;
        resultMain.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).propTTestOfTotal         = resultMain.(frequencyBands{frequencyBandCntr}).(keepElectrodes{electrodeCntr}).nrTTest/resultTable.nrTTestsWO;
    end
    resultMain.(frequencyBands{frequencyBandCntr}).propTTestOfTotal = resultTable.(frequencyBands{frequencyBandCntr}).nrTTestsWO/resultTable.nrTTestsWO;
end
end