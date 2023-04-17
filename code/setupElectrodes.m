% This script defines electrode positions and the mapping
% from clusters to electrodes.
%
% Steady state visual evoked potentials in schizophrenia: A review
% Schielke & Krekelberg.




% Coordinates for common electrode locations

electrodeLocations.LPA = [-86.0761 -19.9897 -47.9860];
electrodeLocations.RPA = [85.7939 -20.0093 -48.0310];
electrodeLocations.Nz = [0.0083 86.8110 -39.9830];
electrodeLocations.Fp1 = [-29.4367 83.9171 -6.9900];
electrodeLocations.Fpz = [0.1123 88.2470 -1.7130];
electrodeLocations.Fp2 = [29.8723 84.8959 -7.0800];
electrodeLocations.AF9 = [-48.9708 64.0872 -47.6830];
electrodeLocations.AF7 = [-54.8397 68.5722 -10.5900];
electrodeLocations.AF5 = [-45.4307 72.8622 5.9780];
electrodeLocations.AF3 = [-33.7007 76.8371 21.2270];
electrodeLocations.AF1 = [-18.4717 79.9041 32.7520];
electrodeLocations.AFz = [0.2313 80.7710 35.4170];
electrodeLocations.AF2 = [19.8203 80.3019 32.7640];
electrodeLocations.AF4 = [35.7123 77.7259 21.9560];
electrodeLocations.AF6 = [46.5843 73.8078 6.0340];
electrodeLocations.AF8 = [55.7433 69.6568 -10.7550];
electrodeLocations.AF10 = [50.4352 63.8698 -48.0050];
electrodeLocations.F9 = [-70.1019 41.6523 -49.9520];
electrodeLocations.F7 = [-70.2629 42.4743 -11.4200];
electrodeLocations.F5 = [-64.4658 48.0353 16.9210];
electrodeLocations.F3 = [-50.2438 53.1112 42.1920];
electrodeLocations.F1 = [-27.4958 56.9311 60.3420];
electrodeLocations.Fz = [0.3122 58.5120 66.4620];
electrodeLocations.F2 = [29.5142 57.6019 59.5400];
electrodeLocations.F4 = [51.8362 54.3048 40.8140];
electrodeLocations.F6 = [67.9142 49.8297 16.3670];
electrodeLocations.F8 = [73.0431 44.4217 -12.0000];
electrodeLocations.F10 = [72.1141 42.0667 -50.4520];
electrodeLocations.FT9 = [-84.0759 14.5673 -50.4290];
electrodeLocations.FT7 = [-80.7750 14.1203 -11.1350];
electrodeLocations.FC5 = [-77.2149 18.6433 24.4600];
electrodeLocations.FC3 = [-60.1819 22.7162 55.5440];
electrodeLocations.FC1 = [-34.0619 26.0111 79.9870];
electrodeLocations.FCz = [0.3761 27.3900 88.6680];
electrodeLocations.FC2 = [34.7841 26.4379 78.8080];
electrodeLocations.FC4 = [62.2931 23.7228 55.6300];
electrodeLocations.FC6 = [79.5341 19.9357 24.4380];
electrodeLocations.FT8 = [81.8151 15.4167 -11.3300];
electrodeLocations.FT10 = [84.1131 14.3647 -50.5380];
electrodeLocations.T9 = [-85.8941 -15.8287 -48.2830];
electrodeLocations.T7 = [-84.1611 -16.0187 -9.3460];
electrodeLocations.C5 = [-80.2801 -13.7597 29.1600];
electrodeLocations.C3 = [-65.3581 -11.6317 64.3580];
electrodeLocations.C1 = [-36.1580 -9.9839 89.7520];
electrodeLocations.Cz = [0.4009 -9.1670 100.2440];
electrodeLocations.C2 = [37.6720 -9.6241 88.4120];
electrodeLocations.C4 = [67.1179 -10.9003 63.5800];
electrodeLocations.C6 = [83.4559 -12.7763 29.2080];
electrodeLocations.T8 = [85.0799 -15.0203 -9.4900];
electrodeLocations.T10 = [85.5599 -16.3613 -48.2710];
electrodeLocations.TP9 = [-85.6192 -46.5147 -45.7070];
electrodeLocations.TP7 = [-84.8302 -46.0217 -7.0560];
electrodeLocations.CP5 = [-79.5922 -46.5507 30.9490];
electrodeLocations.CP3 = [-63.5562 -47.0088 65.6240];
electrodeLocations.CP1 = [-35.5131 -47.2919 91.3150];
electrodeLocations.CPz = [0.3858 -47.3180 99.4320];
electrodeLocations.CP2 = [38.3838 -47.0731 90.6950];
electrodeLocations.CP4 = [66.6118 -46.6372 65.5800];
electrodeLocations.CP6 = [83.3218 -46.1013 31.2060];
electrodeLocations.TP8 = [85.5488 -45.5453 -7.1300];
electrodeLocations.TP10 = [86.1618 -47.0353 -45.8690];
electrodeLocations.P9 = [-73.0093 -73.7657 -40.9980];
electrodeLocations.P7 = [-72.4343 -73.4527 -2.4870];
electrodeLocations.P5 = [-67.2723 -76.2907 28.3820];
electrodeLocations.P3 = [-53.0073 -78.7878 55.9400];
electrodeLocations.P1 = [-28.6203 -80.5249 75.4360];
electrodeLocations.Pz = [0.3247 -81.1150 82.6150];
electrodeLocations.P2 = [31.9197 -80.4871 76.7160];
electrodeLocations.P4 = [55.6667 -78.5602 56.5610];
electrodeLocations.P6 = [67.8877 -75.9043 28.0910];
electrodeLocations.P8 = [73.0557 -73.0683 -2.5400];
electrodeLocations.P10 = [73.8947 -74.3903 -41.2200];
electrodeLocations.PO9 = [-54.9104 -98.0448 -35.4650];
electrodeLocations.PO7 = [-54.8404 -97.5279 2.7920];
electrodeLocations.PO5 = [-48.4244 -99.3408 21.5990];
electrodeLocations.PO3 = [-36.5114 -100.8529 37.1670];
electrodeLocations.PO1 = [-18.9724 -101.7680 46.5360];
electrodeLocations.POz = [0.2156 -102.1780 50.6080];
electrodeLocations.PO2 = [19.8776 -101.7930 46.3930];
electrodeLocations.PO4 = [36.7816 -100.8491 36.3970];
electrodeLocations.PO6 = [49.8196 -99.4461 21.7270];
electrodeLocations.PO8 = [55.6666 -97.6251 2.7300];
electrodeLocations.PO10 = [54.9876 -98.0911 -35.5410];
electrodeLocations.O1 = [-29.4134 -112.4490 8.8390];
electrodeLocations.Oz = [0.1076 -114.8920 14.6570];
electrodeLocations.O2 = [29.8426 -112.1560 8.8000];
electrodeLocations.O9 = [-29.8184 -114.5700 -29.2160];
electrodeLocations.Iz = [0.0045 -118.5650 -23.0780];
electrodeLocations.O10 = [29.7416 -114.2600 -29.2560];
electrodeLocations.T3 = [-84.1611 -16.0187 -9.3460];
electrodeLocations.T5 = [-72.4343 -73.4527 -2.4870];
electrodeLocations.T4 = [85.0799 -15.0203 -9.4900];
electrodeLocations.T6 = [73.0557 -73.0683 -2.5400];
electrodeLocations.M1 = [-86.0761 -44.9897 -67.9860];
electrodeLocations.M2 = [85.7939 -45.0093 -68.0310];
electrodeLocations.A1 = [-86.0761 -24.9897 -67.9860];
electrodeLocations.A2 = [85.7939 -25.0093 -68.0310];


% Which of those electrodes are we keeping to plot
keepElectrodes = {'t5'; 'pz'; 'fz'; 'f8'; 'f7'; 'o2'; 'o1'; 'p4'; 'p3'; 'c4'; 'c3'; 'f4'; 'f3'; 'fp2'; 'fp1'; 'oz'; 'cz'; 't6'; 't3'; 't4';};

% Names of clusters for combinations of electrodes to which results were
% assigned to when papers reported effects at i.e. parietal
% sites/clusters
clusterNames.fc = {'fz'; 'fp1'; 'fp2'; 'f3'; 'f4';};%frontal cluster
clusterNames.ac = {'fz'; 'fp1'; 'fp2'; 'f3'; 'f4'};%anterior cluster
clusterNames.cc = {'fz'; 'cz'; 'pz'; 'c3'; 'c4'};%central cluster
clusterNames.pc = {'pz'; 'oz'; 'p3'; 'p4'; 'o1'; 'o2'};%parietal cluster
clusterNames.oc = {'pz'; 'oz'; 'p3'; 'p4'; 'o1'; 'o2'};%occipital cluster
clusterNames.poc = {'pz'; 'oz'; 'p3'; 'p4'; 'o1'; 'o2'};%occipital-parietal
clusterNames.tc = {'t5'; 'c3'; 't3'; 't6'; 'c4'; 't4'};%temporal cluster
clusterNames.average = {'t5'; 'pz'; 'fz'; 'f8'; 'f7'; 'o2'; 'o1'; 'p4'; 'p3'; 'c4'; 'c3'; 'f4'; 'f3'; 'fp2'; 'fp1'; 'oz'; 'cz'; 't6'; 't3'; 't4'};%average cluster


% Translate 3d electrode locations to 2d locations
electrodeNames = fieldnames(electrodeLocations);
topo = nan(length(electrodeNames),2);
for electrodeCntr = 1:length(electrodeNames)
    distanceXYZ = ((electrodeLocations.(electrodeNames{electrodeCntr})(1) - electrodeLocations.Cz(1))^2 + (electrodeLocations.(electrodeNames{electrodeCntr})(2) - electrodeLocations.Cz(2))^2 + (electrodeLocations.(electrodeNames{electrodeCntr})(3) - electrodeLocations.Cz(3))^2)^(0.5);
    distanceXY = sqrt(((electrodeLocations.(electrodeNames{electrodeCntr})(1) - electrodeLocations.Cz(1))^2 + (electrodeLocations.(electrodeNames{electrodeCntr})(2) - electrodeLocations.Cz(2))^2));
    zScaleFactor = distanceXYZ/distanceXY;

    topoCoordinates.(electrodeNames{electrodeCntr}) = [electrodeLocations.(electrodeNames{electrodeCntr})(1)*zScaleFactor electrodeLocations.(electrodeNames{electrodeCntr})(2)*zScaleFactor];
    if isnan(topoCoordinates.(electrodeNames{electrodeCntr}))
        topoCoordinates.(electrodeNames{electrodeCntr}) = [0 0];
    end
    topo(electrodeCntr,:) = topoCoordinates.(electrodeNames{electrodeCntr});
end

% Keep only the electrodes that we specified above
elIdx = zeros(1,length(keepElectrodes));
for keepElectrodeCntr = 1:length(keepElectrodes)
    elIdx(keepElectrodeCntr) = find(strcmpi(electrodeNames,keepElectrodes(keepElectrodeCntr)));
    ten20Coordinates.(keepElectrodes{keepElectrodeCntr}) = topo(elIdx(keepElectrodeCntr),:);
end
electrodeSelection = electrodeNames(elIdx);

