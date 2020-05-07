filepath = "/home/ziqi/Desktop/uwb_sound_data/collected_data_20200429/1m_driver_test.txt";
bb_frames = read_file_into_matrix(filepath);
% or
% load("/home/ziqi/Desktop/cached_data_20191124/mary_0.mat");

bb_frames = phase_noise_correction(bb_frames, 1);

bb_frames = stationary_clutter_suppression(bb_frames);
% Warning: if Fs changed , filters need to be adjusted

bb_frames = [real(bb_frames), imag(bb_frames)];
[object_inx, target_bin] = vibrating_target_localization(bb_frames);

candidate_data = bb_frames(:,target_bin);

% fft analysis
Fs = 1000;            % Sampling frequency 
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

%distance_estimation
range_min = 0.3;
range_max = 4.3;
if target_bin > 80
    distance = range_min + 0.0514*(target_bin-81);
else
    distance = range_min + 0.0514*(target_bin-1);
end
fprintf("The estimated vibration target distance is %f m.\n", distance);
% sound output
output_sound = self_centralize(candidate_data, 1);
% audiowrite("recovered_sound.wav",output_sound,Fs)
soundsc(output_sound, Fs)
