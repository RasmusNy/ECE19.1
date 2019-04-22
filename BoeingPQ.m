% Test for Power Functions
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

% Hard code sample frequency
fs = 100000;

% Import data
allData = importdata(dataFile);

% Length of data in file
n = length(allData.data(:,1));

% FFT of voltage and current shifted
% so there is both positive and negative components.
% Shifted for graphing
vfft = fftshift(fft(allData.data(:,2),n));
ifft = fftshift(fft(allData.data(:,5),n));

% Absolute value to grab magnitude of fft without
% the complex part of the values
vabs = abs(vfft);
iabs = abs(ifft);

% Divide by number of data points over 2 for proper magnitude scaling
vabs = vabs/(n/2);
iabs = iabs/(n/2);

 dF = fs/n;                      % Hertz
 fvector = -fs/2:dF:fs/2-dF;     % Frequency vactor for plotting

% Creating a new vector only containing the first half of
% the original 'abs' vector (to remove the negative half)
iabs_modified = iabs(1:n/2);
vabs_modified = vabs(1:n/2);

%Graphing the fft of current and voltage
% figure(1)
% stem(fvector,iabs);
% xlabel('f(Hz)'); ylabel('|I|'); title('|FFT| of i'); grid;
% figure(2)
% stem(fvector,vabs);
% xlabel('f(Hz)'); ylabel('|V|'); title('|FFT| of v'); grid;

% Transposed for find calculation
iabs_modified = iabs_modified';
vabs_modified = vabs_modified';

magnitude_threshold = 0.02;

pkv = [];
locv = [];
phv = [];
vrms = 0;

% Finding all values with magnitudes at or greater than the magnitude
% threshold. It stores their index locations in a vector locv.
[~, val] = find(vabs_modified >= magnitude_threshold);
locv = [locv ; val];

% Vector of phase angles for voltage
phv = [phv ; angle(vfft(locv))];

% Vector of magnitude values for voltage
pkv = [pkv ; vabs_modified(locv)];


pki = [];
loci = [];
phi = [];
irms = 0;

% Finding all values with magnitudes at or greater than the magnitude
% threshold. It stores their index locations in a vector loci.
[~, val] = find(iabs_modified >= magnitude_threshold);
loci = [loci ; val];

% Vector of phase angles for current
phi = [phi ; angle(ifft(loci))];

% Vector of magnitude values for current
pki = [pki ; iabs_modified(loci)];

Pavg = 0;
Preact = 0;
PF = 0;
RMSv = zeros(1,length(locv));
RMSi = zeros(1,length(loci));

% Voltage rms fourier series calculation
for k = 1:length(locv)
    vrms = vrms + (pkv(k)^2)/2;
    RMSv(k) = (pkv(k)^2)/2;
end
vrms = sqrt(vrms);
RMSv = sqrt(RMSv);

% Current rms fourier series calculation
for k = 1:length(loci)
    irms = irms + (pki(k)^2)/2;
    RMSi(k) = (pki(k)^2)/2;
end
irms = sqrt(irms);
RMSi = sqrt(RMSi);

% Real Power 'Pavg' and reactive power 'Preact'
counter = 1;
if(length(locv) >= length(loci))
    while counter ~= length(locv)+1
        for k = 1:length(loci)
            if locv(counter) == loci(k)
                Pavg = Pavg + RMSv(counter)*RMSi(k)*(cos(phv(counter)-phi(k)));
                Preact = Preact + RMSv(counter)*RMSi(k)*(sin(phv(counter)-phi(k)));
            end
        end
        counter = counter + 1;
    end
elseif(length(locv) < length(loci))
    while counter ~= length(loci)+1
        for k = 1:length(locv)
            if loci(counter) == locv(k)
               Pavg = Pavg + RMSv(k)*RMSi(counter)*(cos(phv(k)-phi(counter)));
               Preact = Preact + RMSv(k)*RMSi(counter)*(sin(phv(k)-phi(counter)));
            end
        end
        counter = counter + 1;
    end
end

%Power Factor
if(length(locv) >= length(loci))
    for k = 1:length(loci)
       PF = (Pavg/(vrms*irms));
    end
elseif(length(locv) < length(loci))
    for k = 1:length(locv)
       PF = (Pavg/(vrms*irms));
    end
end