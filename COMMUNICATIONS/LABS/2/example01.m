% EXAMPLE 01: COSINE WAVE
Fs = 200;               % sampling frequency
t = 0:(1/Fs):1;         % time vector of 1 second
f = 50;                 % freq of 10Hz
x = cos(2*pi*t*f);      % cosine wave x(t)
nfft = 1024;            % length of FFT
X = fft(x, nfft);       % eval FFT

% We only want the positive half of X post FFT
X = X(1:(nfft/2));

mx = abs(X/nfft);       % normalized mag of X
f = (0:nfft/2-1)*Fs/nfft;  % Freq vector
% notice Fs/nfft, this aligns the frequency at f
% as we sampled the function at a frequency different
% than the FFT is long (200/1024 = 0.19 scale)

% Generate plot
figure(1);
plot(t,x);
title('Cosine Wave');
xlabel('Time (s)');
ylabel('Amplitude');
figure(2);
plot(f,mx);
title('Power Spectrum of Cosine Wave');
xlabel('Frequency (Hz)');
ylabel('Spectrum');
