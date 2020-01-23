% filepath = "/home/ziqi/Desktop/collected_data_20191122/220_00_0.txt";
% bb_frames = read_file_into_matrix(filepath);
% or
% load("/home/ziqi/Desktop/cached_data_20191124/mary_0.mat");
load("/home/ziqi/Desktop/cached_data_20191204/human_voice_3K_4.mat")

bb_frames = stationary_clutter_suppression(bb_frames);

target_bin = vibrating_target_localization(bb_frames);

candidate_data = bb_frames(:,target_bin);

% fft analysis
Fs = 1250;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = size(bb_frames, 1); % Length of signal
t = (0:L-1).*T;        % Time vector
f = Fs*(0:(round(L/2)))/L;

Y = fft(candidate_data);
P2 = abs(Y);  % P2 = abs(Y/L);
P1 = P2(1:round(L/2)+1);
P1(2:end-1) = 2*P1(2:end-1);
figure()
plot(f(1000:end),P1(1000:end)) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% stft analysis
figure()
stft(candidate_data,Fs,'Window',hamming(256, "periodic"),'OverlapLength',192,'FFTLength',256);



% sound output
output_sound = abs(candidate_data);
output_sound = ((output_sound - min(output_sound)) / (max(output_sound)-min(output_sound)) - 0.5) *2;
% audiowrite("recovered_sound.wav",output_sound,Fs)
soundsc(output_sound, Fs)
