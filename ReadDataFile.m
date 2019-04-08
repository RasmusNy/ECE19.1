%   Program process user file and stores data in appropriate matrix
%   ECE19.1
clear;
clc;
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

fs = 100000;
%import data
allData = importdata(dataFile);

% if(dataParameter == 'AC')
%     prompt = 'Enter Sampling frequency: ';
%     fs = input(prompt);
% end
% period = 1/ffreq;
%Maps matrix dimensions to m & n
[m,n] = size(allData.data);

vfft = fft(allData.data(:,2));
ifft = fft(allData.data(:,5));
n = length(allData.data(:,1));

vabs = abs(vfft);
iabs = abs(ifft);

vabs_modified = vabs/1000;
iabs_modified = iabs/1000;

fvector = (allData.data(:,1) .* (fs/n));
fvector((n/2)+2:end) = [];
fvector = fvector .* 100000;

phv = unwrap(angle(vfft));
phi = unwrap(angle(ifft));

iabs_modified((n/2)+2:end) = [];
vabs_modified((n/2)+2:end) = [];

%Graphing the fft of current and voltage
figure(1)
stem(fvector,iabs_modified);
xlabel('f(Hz)'); ylabel('|I|'); title('|FFT| of i'); grid;
figure(2)
stem(fvector,vabs_modified);
xlabel('f(Hz)'); ylabel('|V|'); title('|FFT| of v'); grid;


pkv = [];
locv = [];
phv = [];
vt = 0;
vrms = [];
[temp, val] = find(vabs_modified >= 0.1);
locv = [locv ; val];
phv = [phv ; angle(vfft(locv))];
pkv = [pkv ; vabs_modified(locv)];
locv = (locv - 1) ./ 2;

pki = [];
loci = [];
phi = [];
it = 0;
irms = [];
[temp, val] = find(iabs_modified >= 0.1);
loci = [loci ; val];
phi = [phi ; angle(ifft(loci))];
pki = [pki ; iabs_modified(loci)];
loci = (loci - 1) ./ 2;

Pavg = 0;
Preact = 0;
THDv = 0;
THDi = 0;
PF = 0;
RMSv = [];
RMSi = [];

% % Voltage as a function of time
% for k = 1:length(phv)
%     temp = pkv(k)*sin(k*w*t+phv(k));
%     vt = (vt + temp);
% end
% 
% % Current as a function of time
% for k = 1:length(phi)
%     temp = pki(k)*sin(k*w*t+phi(k));
%     it = (it + temp);
% end

%Voltage rms
for k = 1:length(phv)
    temp = sqrt((pkv(k)^2)/2);
    vrms = vrms + temp;
    RMSv = [RMSv ; temp];
end

% Current rms
for k = 1:length(phi)
    temp = sqrt((pki(k)^2)/2);
    irms = irms + temp;
    RMSi = [RMSi ; temp];
end
counter = 1;
% Real Power
if(length(phv) >= length(phi))
    counter = 1;
    while counter ~= length(loci)
        for k = 1:length(locv)
            if loci(counter) == locv(k)
               temp = RMSv(k)*RMSi(k)*(cos(phv(k)-phi(k)));
               Pavg = Pavg + temp;
            end
        end
        counter = counter + 1;
    end
elseif(length(phv) < length(phi))
    while counter ~= length(loci)
        for k = 1:length(locv)
            if loci(counter) == locv(k)
               temp = RMSv(k)*RMSi(k)*(cos(phv(k)-phi(k)));
               Pavg = Pavg + temp;
            end
        end
        counter = counter + 1;
    end
end
counter = 1;
% Reactive power
if(length(phv) >= length(phi))
    while counter ~= length(loci)
        for k = 1:length(locv)
            if loci(counter) == locv(k)
                temp = RMSv(k)*RMSi(k)*(sin(phv(k)-phi(k)));
                Preact = Preact + temp;
            end
        end
        counter = counter + 1;
    end
elseif(length(phv) < length(phi))
    while counter ~= length(loci)
        for k = 1:length(locv)
            if loci(counter) == locv(k)
                temp = RMSv(k)*RMSi(k)*(sin(phv(k)-phi(k)));
                Preact = Preact + temp;
            end
        end
        counter = counter + 1;
    end
end

% % THD for Voltage
% for k = 2:length(phv)
%    temp = (sqrt(vrms(k)^2)/vrms(1));
%    THDv = THDv + temp;
% end
% THDv = THDv * 100;
% 
% % THD for Current
% for k = 2:length(phi)
%    temp = (sqrt(irms(k)^2)/irms(1));
%    THDi = THDi + temp;
% end
% THDi = THDi * 100;
% 
% RMSv = vrms(1)*(sqrt(1+(THDv/100)^2));
% RMSi = irms(1)*(sqrt(1+(THDi/100)^2));

%Power Factor
if(length(phv) >= length(phi))
    for k = 1:length(phi)
       PF = (Pavg/(irms*vrms));
    end
elseif(length(phv) < length(phi))
    for k = 1:length(phv)
       PF = (Pavg/(irms*vrms));
%      temp = (Pavg/(vrms(1)*irms(1)))*(1/((sqrt(1+(THDv/100)^2))*(sqrt(1+(THDi/100)^2))));
%        PF = PF + temp;
    end
end

