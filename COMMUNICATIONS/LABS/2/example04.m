Fs = 200; % Sampling Frequency
t = -0.5:1/Fs:0.5; % Time vector of 1 second
T0 = .1; % Width of rectangle
fc = 80; % Carrier Frequency
A = 1; % Amplitude
x = A*cos(2*pi*fc*t).*rectpuls(t, T0); % Generate RF Pulse

nfft = 1024; % Length of FFT
X = fft(x, nfft); % Take fft, padding with zeros so that length(X) is equal to nfft
X = X(1:nfft/2); % FFT is symmetric, hence taking the positive half
mx = abs(X/nfft); % Magnitude of fft of x
f = (0:nfft/2-1)*Fs/nfft; % Frequency vector

% Generate the plots
figure(1);
plot(t, x);
title('RF pulse');
xlabel('Time (s)');
ylabel('Amplitude');

figure(2);
plot(f, mx);
title('Power Spectrum of a RF Pulse');
xlabel('Frequency (Hz)');
ylabel('Spectrum');