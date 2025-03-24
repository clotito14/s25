% CHASE LOTITO - SIUC EE UNDEGRAD
% ECE428 INDIVIDUAL PROJECT
%
% 80% 120% POWER ANALYSIS

% NUMBER OF SUBPLOTS
nsub = 6;

% DEFINE MODULATION INDEX
mu1 = 0.8;
mu2 = 1.2;

psratio = [];
psratio1 = [];

for Ac=1:1:500
    % DEFINE FREQUENCIES & AMPLITUDES OF m(t), c(t)
    Am = 1;         % MESSAGE AMPLITUDE
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
    
    % GENERATE CARRIER SIGNAL
    ct = Ac * cos(2*pi*fc*t);
    
    % GENERATE 80% AM SIGNAL
    st1 = (1 + mu1 * mt) .* ct;
    
    % GENERATE 120% AM SIGNAL
    st2 = (1 + mu2 * mt) .* ct;
    
    % GENERATE 80% AM AMPLITUDE SPRECTRUM
    Sf1 = 2 / N * abs(fft(st1,N));
    
    % GENERATE 120% AM AMPLITUDE SPRECTRUM
    Sf2 = 2 / N * abs(fft(st2,N));
    
    % CALCULATE POWER REQUIREMENTS (THEN TAKE RATIO)
    ps1 = sum(Sf1.^2) / N;
    ps2 = sum(Sf2.^2) / N;
    pratio = ps2/ps1;
    psratio = [psratio, pratio];
end

for Ac=1:1:500
    % DEFINE FREQUENCIES & AMPLITUDES OF m(t), c(t)
    Am = 1;         % MESSAGE AMPLITUDE
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
    mt = Ac * pulstran(t, d, 'rectpuls', T/2);
    
    % GENERATE CARRIER SIGNAL
    ct = Ac * cos(2*pi*fc*t);
    
    % GENERATE 80% AM SIGNAL
    st1 = (1 + mu1 * mt) .* ct;
    
    % GENERATE 120% AM SIGNAL
    st2 = (1 + mu2 * mt) .* ct;
    
    % GENERATE 80% AM AMPLITUDE SPRECTRUM
    Sf1 = 2 / N * abs(fft(st1,N));
    
    % GENERATE 120% AM AMPLITUDE SPRECTRUM
    Sf2 = 2 / N * abs(fft(st2,N));
    
    % CALCULATE POWER REQUIREMENTS (THEN TAKE RATIO)
    ps1 = sum(Sf1.^2) / N;
    ps2 = sum(Sf2.^2) / N;
    pratio = ps2/ps1;
    psratio1 = [psratio1, pratio];
end

Ac = 1:1:500;
plot(Ac, psratio);
hold on;
plot(Ac, psratio1);
ylim([0,2.5]);
title('{P_{s_2(t)}}/{P_{s_1(t)}} for Varying A_c & Varying A_c, A_m');
xlabel('Message and/or Carrier Amplitude (V)');
ylabel('Power Ratio');