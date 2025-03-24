%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FM signal simulator - Design-1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('==============================================================');
disp('FM modulation: Design-1');

%% parameters
Pt = 105000; % transmit power (watts)
fc = 103.3*10^6; % carrier frequency (FM range is 88 MHz - 108 MHz)
Ac = sqrt(2*Pt); % amplitude of carrier signal (volts)
Fs = 2^30; % sampling rate
fm = 38000; % modulating frequency (50Hz to 15kHz) (pilot carrier 19kHz)
Ts = 1/Fs; % sampling period
t = 0:Ts:10^(-6); % observation period
L = length(t);
beta = 1; % modulation index (set it to 1 to make the bandwidth less than 200kHz (max = 5))
Am = 1; % amplitude of the modulating signal (volts)
Deltaf = beta*fm; % frequency deviation
kf = Deltaf/Am; % modulator sensitivity
FFTsize = 4096;

%% generate modulating signals (message signals)
m_t = Am*cos(2*pi*fm*t);

%% generating integrate signal
theta = 2*pi*fc*t + 2*pi*beta*cumsum(m_t)*Ts;

%% generating FM Modulated signal
s_t = Ac*cos(theta);

%% generating spectrum of FM wave
n = 2^nextpow2(L);
dim = 2;
Y = fft(s_t,n,dim);
Freq = 0:(Fs/n):(Fs/2-Fs/n);

P2 = abs(Y/L);
P1 = P2(:,1:n/2+1);
P1(:,2:end-1) = 2*P1(:,2:end-1);

bw = 2*Deltaf*(1+1/beta);
fprintf('Transmission bandwidth = %d Hz \n',bw);
fprintf('Transmit power = %d W \n',Pt);

%% plot the results
% plotting message signal
figure(3)
plot(t, s_t);
grid on;
title ('FM Signal');
xlabel ('time (ms)');
ylabel ('Amplitude');

% plotting carrier signal
figure(4)
stem(Freq,P1(:,1:n/2))
grid on;
title ('spectrum of FM wave ');
xlabel ('frequency');
ylabel ('Amplitude spectrum');

%% Path-loss calculation
c = 3*10^8; % speed of light
lambda = c/fc; % wavelength
d0 = 1; % reference distance in meters
eta = 3; % path-loss exponent
d = 100*10^3; % distance in meters
PL = ((4*pi*d0/lambda)^2)*(d/d0)^eta;
Pr_min = -110; % dBm receiver sensitivity
Prm = 10^(Pr_min/10); % mW receiver sensitivity
Pr = Prm*10^(-3); % W receiver sensitivity

d_cov = ((Pt/Pr)^(1/eta))*d0*((lambda/(4*pi*d0))^2);

fprintf('Coverage = %.2f km (with receiver sensitivity = %.1f dBm and path-loss exponent = %.1f) \n',d_cov/1000,Pr_min,eta);