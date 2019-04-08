% Test for Power Functions
clear;
clc;
w=pi;
t=[0:.001:2];
%v=1*cos(w*t) + .1*cos(10*w*t);%voltage

i=.8*cos(w*t + 10*pi/180) + 0.25*cos(2*w*t + 15*pi/180) + 0.5*cos(3*w*t + 19*pi/180) + .125*cos(6*w*t+35*pi/180);%current
v=1*cos(w*t);%voltage

f = w/(2*pi);
fs = 1/0.001;

vfft = fft(v);
ifft = fft(i);
n = length(i);

vabs = abs(vfft);
iabs = abs(ifft);

vabs_modified = vabs/1000;
iabs_modified = iabs/1000;

% fvector=[0:0.5:fs/2];
fvector = (t .* (fs/n));
fvector((n/2)+1:end) = [];
fvector = fvector .* fs;
%fvector(fvector/2:end) = [];

phv = unwrap(angle(vfft));
phi = unwrap(angle(ifft));

iabs_modified(fs+2:end) = [];
vabs_modified(fs+2:end) = [];

%Graphing the fft of current and voltage
figure(1)
stem(fvector,iabs_modified);
xlabel('f(Hz)'); ylabel('|I|'); title('|FFT| of i'); grid;
figure(2)
stem(fvector,vabs_modified);
xlabel('f(Hz)'); ylabel('|V|'); title('|FFT| of v'); grid;
figure(3)
plot(t,v);
figure(4)
plot(t,i);

pkv = [];
locv = [];
phv = [];
vt = 0;
vrms = 0;
[temp, val] = find(vabs_modified >= 0.1);
locv = [locv ; val];
phv = [phv ; angle(vfft(locv))];
pkv = [pkv ; vabs_modified(locv)];
locv = (locv - 1) ./ 2;

pki = [];
loci = [];
phi = [];
it = 0;
irms = 0;
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

% Voltage as a function of time
for k = 1:length(phv)
    temp = pkv(k)*sin(k*w*t+phv(k));
    vt = (vt + temp);
end

% Current as a function of time
for k = 1:length(phi)
    temp = pki(k)*sin(k*w*t+phi(k));
    it = (it + temp);
end

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
    for k = 1:length(phi)
        while k ~= length(loci)
            if loci(counter) == locv(k)
                temp = RMSv(k)*RMSi(k)*(cos(phv(k)-phi(k)));
                Pavg = Pavg + temp;
            end
        end
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
% icount = 1;
% vcount = 1;
counter = 1;
% Reactive power
if(length(phv) >= length(phi))
    for k = 1:length(phi)
       temp = RMSv(k)*RMSi(k)*(sin(phv(k)-phi(k)));
       Preact = Preact + temp;
    end
elseif(length(phv) < length(phi))
    %TRIED THIS MORE EFFICIENT WAY BUT CAN'T QUITE GET IT TO WORK.
    
%     while icount ~= length(loci) && vcount ~= length(locv)
%        if icount == length(loci) && loci(icount) < locv(vcount)
%            vcount = length(vcount);
%        elseif vcount == length(locv) && loci(icount) > locv(vcount)
%            icount = length(icount);
%        end
%         
%        if loci(icount) > locv(vcount)
%            vcount = vcount + 1;
%        elseif loci(icount) < locv(vcount)
%            icount = icount + 1;
%        else
%            temp = RMSv(vcount)*RMSi(icount)*(sin(phv(vcount)-phi(icount)));
%            Preact = Preact + temp;
%            icount = icount + 1;
%            vcount = vcount + 1;
%        end
%     end
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
       temp = (Pavg/(RMSv*RMSi));
       PF = PF + temp;
    end
elseif(length(phv) < length(phi))
    for k = 1:length(phv)
       PF = (Pavg/(irms*vrms));
%      temp = (Pavg/(vrms(1)*irms(1)))*(1/((sqrt(1+(THDv/100)^2))*(sqrt(1+(THDi/100)^2))));
%        PF = PF + temp;
    end
end
