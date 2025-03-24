% CHASE LOTITO - SIUC EE UNDEGRAD
% ECE428 INDIVIDUAL PROJECT
%
% 80% 120% BANDWIDTH AM MODULATOR

% NUMBER OF SUBPLOTS
nsub = 6;

% DEFINE MODULATION INDEX
mu1 = 0.8;
mu2 = 1.2;

% DEFINE FREQUENCIES & AMPLITUDES OF m(t), c(t)
Am = 1;         % MESSAGE AMPLITUDE
Ac = 1;         % CARRIER AMPLITUDE
fm = 25;        % MESSAGE FREQ.
fc = 500;      % CARRIER FREQ.

%----------------------------------------------------------------------
% FROM fft.m:
%   For length N input vector x, the DFT is a length N vector X,
%   with elements
%                    N
%      X(k) =       sum  x(n)*exp(-j*2*pi*(k-1)*(n-1)/N), 1 <= k <= N.
%                   n=1
%----------------------------------------------------------------------
% DEFINE SAMPLING FREQUENCY (for N-point FFT)
N = 2048;           % N for the N-point FFT
fs = 8192;         % SAMPLING FREQ.
t = (-(N-1):N-1)/fs;

% GENERATE MESSAGE SIGNAL
T = 1/fm;                            % PULSE TRAIN PERIOD
d = min(t):T:max(t);
mt = Am * pulstran(t, d, 'rectpuls', T/2);
subplot(nsub,1,1);
plot(t,mt);
title('Message Signal m(t)');
xlabel('Time (s)');
ylabel('Amplitude (V)');
ylim([-1 2]);

% GENERATE CARRIER SIGNAL
ct = Ac * cos(2*pi*fc*t);
subplot(nsub,1,2);
plot(t,ct, Color='r');
str = compose('Carrier Signal c(t) (f_c = %dHz)', fc);
title(str);
xlabel('Time (s)');
ylabel('Amplitude (V)');
ylim([-2 2]);

% GENERATE 80% AM SIGNAL
st1 = (1 + mu1 * mt) .* ct;
subplot(nsub,1,3);
plot(t,st1, Color="#8512ac");
title('80% AM Modulated Signal s_1(t)');
xlabel('Time (s)');
ylabel('Amplitude (V)');
ylim([-3 3]);

s1max = max(st1);
fprintf('Max of s1(t) = %f\n', s1max);

% GENERATE 120% AM SIGNAL
st2 = (1 + mu2 * mt) .* ct;
subplot(nsub,1,4);
plot(t,st2, Color="#8512ac");
title('120% AM Modulated Signal s_2(t)');
xlabel('Time (s)');
ylabel('Amplitude (V)');
ylim([-3 3]);

s2max = max(st2);
fprintf('Max of s2(t) = %f\n', s2max);

% GENERATE 80% AM AMPLITUDE SPRECTRUM
Sf1 = 2 / N * abs(fft(st1,N));
f = fs * (0: N/2) / N;
subplot(nsub, 1, 5);
plot(f(1:512), Sf1(1:512), Color="#e86412");
title('Amplitude Spectrum of s_1(t)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% GENERATE 120% AM AMPLITUDE SPRECTRUM
Sf2 = 2 / N * abs(fft(st2,N));
f = fs * (0 : N/2) / N;
subplot(nsub, 1, 6);
plot(f(1:512), Sf2(1:512), Color="#e86412");
title('Amplitude Spectrum of s_2(t)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% CALCULATE POWER REQUIREMENTS (THEN TAKE RATIO)
ps1 = sum(Sf1.^2) / N;
ps2 = sum(Sf2.^2) / N;
pratio = ps2/ps1;
fprintf("Power of 80%%: %f\n", ps1);
fprintf("Power of 120%%: %f\n", ps2);
fprintf("120%% Power by 80%% Power: %f\n", pratio);