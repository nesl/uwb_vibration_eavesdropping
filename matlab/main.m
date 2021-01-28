% filepath = "/home/ziqi/Desktop/uwb_sound_data/collected_data_20200509/400_75_1500_tune2.txt";
% 
% bb_frames = read_file_into_matrix(filepath);
% or
% load("/home/ziqi/Desktop/cached_data_20191124/mary_0.mat");

bb_frames = phase_noise_correction(bb_frames, 1);

bb_frames = stationary_clutter_suppression(bb_frames);
% Warning: if Fs changed , filters need to be adjusted


bb_frames = [real(bb_frames), imag(bb_frames)];
[object_inx, target_bin] = vibrating_target_localization(bb_frames);

candidate_data = bb_frames(:,target_bin);

% fft analysis
%Fs = 1500;            % Sampling frequency 
Fs = 1000;
T = 1/Fs;             % Sampling period
L = size(bb_frames, 1); % Length of signal
t = (0:L-1).*T;        % Time vector
f = Fs*(0:(round(L/2)))/L;

Y = fft(candidate_data);
P2 = abs(Y);  % P2 = abs(Y/L);
P1 = P2(1:round(L/2)+1);
P1(2:end-1) = 2*P1(2:end-1);
figure()
plot(f,P1)
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% stft analysis
figure()
stft((candidate_data),Fs,'Window',hamming(256, "periodic"),'OverlapLength',192,'FFTLength',256);

%distance_estimation(only calculated for range 0.3 to 4.3m setting)
range_min = 0.3;
range_max = 4.3;
if target_bin > 80
    distance = range_min + 0.0514*(target_bin-81);
else
    distance = range_min + 0.0514*(target_bin-1);
end
fprintf("The estimated vibration target distance is %f m.\n", distance);

% sound output
is_speech = 0;
output_sound = is_speech * preemphasis(candidate_data, 0.95) + (1-is_speech) * candidate_data;
output_sound = self_centralize(output_sound, 1);
% audiowrite("recovered_sound.wav",output_sound,Fs)
soundsc(output_sound, Fs)

% Spectral Substraction need the first 0.5s contain only noise
denoised_output = self_centralize(SSBoll79(output_sound,Fs,0.5),1);
figure()
stft(denoised_output,Fs,'Window',hamming(256, "periodic"),'OverlapLength',192,'FFTLength',256);

bw_target = 5;
signal_power_c4 = inband_power(denoised_output, Fs, 261.63, bw_target)
signal_power_a3 = inband_power(denoised_output, Fs, 220.00, bw_target)

% soundsc(denoised_output, Fs)
% audiowrite("recovered_human_reading_numbers_denoised.wav",denoised_output,Fs)
% 
% denoised_output = SSBerouti79(output_sound,Fs,0.5);
% figure()
% stft(denoised_output,Fs,'Window',hamming(256, "periodic"),'OverlapLength',192,'FFTLength',256);
% soundsc(denoised_output, Fs)