%   Program process user file and stores data in appropriate matrix
%   ECE19.1

% Ask User For Data Typ AC/DC/Transient
dataParameter = questdlg('What Data Parameter?', ...
                'Data Format', ...
                'AC', 'DC', 'Transient', 'Transient');

% Handle Response
switch dataParameter
    case 'AC'
        signalType = 0; % AC
    case 'DC'
        signalType = 1; % DC

% Select the file
     case 'Transient'
         signalType = 2; % Transient
end
[fileName, pathName] = uigetfile('*.*','Pick Data File');
dataFile = [pathName, fileName];

Fs = 100000;
%import data
allData = importdata(dataFile);

if(dataParameter == 'AC')
    prompt = 'Enter fundamental frequency: ';
    ffreq = input(prompt);
end
period = 1/ffreq;
%Maps matrix dimensions to m & n
[m,n] = size(allData.data);

%Plot allData
% figure()
% a = plot(allData.data(1:300,1),allData.data(1:300,2));
% figure()
% b = plot(allData.data(1:300,1),allData.data(1:300,5));


% [up,lo] = envelope(allData.data(1:600:end,2));
% hold on
% plot(allData.data(1:600:end,1),up,allData.data(1:600:end,1),lo,'linewidth',1.5)
% legend('voltage','up','lo')
% hold off
rmsv = rms(allData.data(:,2));
rmsi = rms(allData.data(:,5));
% Stot = rmsv * rmsi;
% fun = allData.data(:,2) .* allData.data(:,5);


figure()
thd(allData.data(:,2), Fs)

%Zero Crossing Data
x = allData.data(1:300,1);               % Create Data
y1 = allData.data(1:300,2);              % Create Data
y2 = allData.data(1:300,5);              % Create Data
ZC1 = ZeroX(x,y1);
ZC2 = ZeroX(x,y2);

%finding phase angle from zero crossing data
x_difference = ZC1(1) - ZC2(1);
percent_diff = x_difference/period;
phase_angle = percent_diff * 2* pi;

%power calculations
power_factor = cos(phase_angle);
real_power = rmsv * rmsi * cos(phase_angle);
reactive_power = rmsv * rmsi * sin(phase_angle);

%Plot Channel 2 zero crossings
figure()
plot(x, y1, '-r')
hold on
plot(ZC1, zeros(size(ZC1)), 'pg')
hold off
grid

%plot channel 5 zero crossings
figure()
plot(x, y2, '-r')
hold on
plot(ZC2, zeros(size(ZC2)), 'pg')
hold off
grid



%Calculate Max, Min, Mean
maximum = max(allData.data(:,2));

minimum = min(allData.data(:,2));

% Parse Parameter names
%Time	C1 TRU OUTPUT V	C1 TRU OUTPUT I Pos	R TRU OUTPUT V	R TRU OUTPUT I
% function output = multiply(allData.data(:,2),allData.data(:,5))
% output = allData.data(:,2) .* allData.data(:,5);
% end
