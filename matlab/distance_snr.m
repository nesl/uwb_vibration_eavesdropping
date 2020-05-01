close all; clear all; clc
distance_range = 50:50:300;
SNR_array_paper = [];
bin_array_paper = [];
SNR_array_short_time_real = [];
SNR_array_short_time_imag = [];
for range = 1:length(distance_range)
    dist = distance_range(range);
    filename = num2str(dist) + ".mat";
    load(filename);
    bb_frames = phase_noise_correction(bb_frames, 1);
    bb_frames = stationary_clutter_suppression(bb_frames);
    Fs = 1000;            % Sampling frequency                    
    T = 1/Fs;             % Sampling period       
    L = size(bb_frames, 1); % Length of signal
    t = (0:L-1)*T;        % Time vector
    f = Fs*(0:(round(L/2)))/L;
    
    SNR_temp = [];
    for j = 1:size(bb_frames, 2)
        data = bb_frames(:,j);
        Y = fft(data);
        P2 = abs(Y);
        P1 = P2(1:round(L/2)+1);
        P1(2:end-1) = 2*P1(2:end-1);

        f_target = 261.63;
        bw_target = 2;
        f_index = find(abs(f - f_target)< bw_target);

        signal_power = sum(abs(P1(f_index)).^2);
        noise_power = sum(abs(P1).^2) - signal_power;
        SNR = 10*log10(signal_power/noise_power);
        SNR_temp = [SNR_temp SNR];
    end
    max_SNR = max(SNR_temp);
    max_bin = find(SNR_temp == max_SNR);
    
    data = real(bb_frames(:,max_bin));
    num_frames = floor(length(data)/1000);
    short_time_snr = -realmax * ones(1, num_frames);
    for frame_cnt = 1:num_frames
        short_time_frame = data((frame_cnt-1)*1000+1:frame_cnt*1000);
        short_time_snr(frame_cnt) = snr(short_time_frame);
    end
    SNR_array_short_time_real = [SNR_array_short_time_real; short_time_snr];
    
    data = imag(bb_frames(:,max_bin));
    num_frames = floor(length(data)/1000);
    short_time_snr = -realmax * ones(1, num_frames);
    for frame_cnt = 1:num_frames
        short_time_frame = data((frame_cnt-1)*1000+1:frame_cnt*1000);
        short_time_snr(frame_cnt) = snr(short_time_frame);
    end
    SNR_array_short_time_imag = [SNR_array_short_time_imag; short_time_snr];
    
    SNR_array_paper = [SNR_array_paper max_SNR];
    bin_array_paper = [bin_array_paper max_bin];
    fprintf("%d", range);
end

figure()
hold on
plot(1:6, mean(SNR_array_short_time_real,2), "-.", "linewidth", 2)
plot(1:6, mean(SNR_array_short_time_imag,2), "-.", "linewidth", 2)
legend("Using Real", "Using Imag")
boxplot(SNR_array_short_time_real')
boxplot(SNR_array_short_time_imag')
ylabel("SNR/dB")
xlabel("Speaker Distance/cm")
xticklabels(50:50:300)
title("SNR vs Speaker Distance in Free Space")

snr_array_max = max(SNR_array_short_time_real', SNR_array_short_time_imag');
figure()
hold on
plot(1:6, mean(snr_array_max), "-.", "linewidth", 2)
boxplot(snr_array_max)
ylabel("SNR/dB")
xlabel("Speaker Distance/cm")
xticklabels(50:50:300)
title("SNR vs Speaker Distance in Free Space")


clear;
distance_range = 80:30:170;
SNR_array_paper = [];
bin_array_paper = [];
SNR_array_short_time_real = [];
SNR_array_short_time_imag = [];
for range = 1:length(distance_range)
    dist = distance_range(range);
    filename = num2str(dist) + ".mat";
    load(filename);
    bb_frames = phase_noise_correction(bb_frames, 1);
    bb_frames = stationary_clutter_suppression(bb_frames);
    Fs = 1000;            % Sampling frequency                    
    T = 1/Fs;             % Sampling period       
    L = size(bb_frames, 1); % Length of signal
    t = (0:L-1)*T;        % Time vector
    f = Fs*(0:(round(L/2)))/L;
    
    SNR_temp = [];
    for j = 1:size(bb_frames, 2)
        data = bb_frames(:,j);
        Y = fft(data);
        P2 = abs(Y);
        P1 = P2(1:round(L/2)+1);
        P1(2:end-1) = 2*P1(2:end-1);

        f_target = 261.63;
        bw_target = 2;
        f_index = find(abs(f - f_target)< bw_target);

        signal_power = sum(abs(P1(f_index)).^2);
        noise_power = sum(abs(P1).^2) - signal_power;
        SNR = 10*log10(signal_power/noise_power);
        SNR_temp = [SNR_temp SNR];
    end
    max_SNR = max(SNR_temp);
    max_bin = find(SNR_temp == max_SNR);
    
    data = real(bb_frames(:,max_bin));
    num_frames = floor(length(data)/1000);
    short_time_snr = -realmax * ones(1, num_frames);
    for frame_cnt = 1:num_frames
        short_time_frame = data((frame_cnt-1)*1000+1:frame_cnt*1000);
        short_time_snr(frame_cnt) = snr(short_time_frame);
    end
    SNR_array_short_time_real = [SNR_array_short_time_real; short_time_snr];
    
    data = imag(bb_frames(:,max_bin));
    num_frames = floor(length(data)/1000);
    short_time_snr = -realmax * ones(1, num_frames);
    for frame_cnt = 1:num_frames
        short_time_frame = data((frame_cnt-1)*1000+1:frame_cnt*1000);
        short_time_snr(frame_cnt) = snr(short_time_frame);
    end
    SNR_array_short_time_imag = [SNR_array_short_time_imag; short_time_snr];
    
    SNR_array_paper = [SNR_array_paper max_SNR];
    bin_array_paper = [bin_array_paper max_bin];
    fprintf("%d", range);
end

figure()
hold on
plot(1:4, mean(SNR_array_short_time_real,2), "-.", "linewidth", 2)
plot(1:4, mean(SNR_array_short_time_imag,2), "-.", "linewidth", 2)
legend("Using Real", "Using Imag")
boxplot(SNR_array_short_time_real')
boxplot(SNR_array_short_time_imag')
ylabel("SNR/dB")
xlabel("Speaker Distance/cm")
xticklabels(80:30:170)
title("SNR vs Speaker Distance Through Wall")

snr_array_max = max(SNR_array_short_time_real', SNR_array_short_time_imag');
figure()
hold on
plot(1:4, mean(snr_array_max), "-.", "linewidth", 2)
boxplot(snr_array_max)
ylabel("SNR/dB")
xlabel("Speaker Distance/cm")
xticklabels(80:30:170)
title("SNR vs Speaker Distance Through Wall")

% distance_range = 30:10:140;
% diaphragm_type = "f";
% SNR_array_foil = [];
% bin_array_foil = [];
% for range = 1:length(distance_range)
%     dist = distance_range(range);
%     filename = "/home/ziqi/Desktop/cached_data_20191124/dist_220_00_"...
%                + int2str(dist) + "_" + diaphragm_type + ".mat";
%     load(filename);
%     bb_frames = phase_noise_correction(bb_frames, 1);
%     bb_frames = stationary_clutter_suppression(bb_frames, 0.97);
%     Fs = 1000;            % Sampling frequency                    
%     T = 1/Fs;             % Sampling period       
%     L = size(bb_frames, 1); % Length of signal
%     t = (0:L-1)*T;        % Time vector
%     f = Fs*(0:(round(L/2)))/L;
%     
%     SNR_temp = [];
%     for j = 1:size(bb_frames, 2)
%         data = bb_frames(:,j);
%         Y = fft(data);
%         P2 = abs(Y);
%         P1 = P2(1:round(L/2)+1);
%         P1(2:end-1) = 2*P1(2:end-1);
% 
%         f_target = 220.6;
%         bw_target = 2;
%         f_index = find(abs(f - f_target)< bw_target);
% 
%         signal_power = sum(abs(P1(f_index)).^2);
%         noise_power = sum(abs(P1).^2) - signal_power;
%         SNR = 10*log10(signal_power/noise_power);
%         SNR_temp = [SNR_temp SNR];
%     end
%     max_SNR = max(SNR_temp);
%     max_bin = find(SNR_temp == max(SNR));
%     SNR_array_foil = [SNR_array_foil max_SNR];
%     bin_array_foil = [bin_array_foil max_bin];
%     fprintf("%d", range);
% end
% figure()
% hold on
% plot(30:10:100, SNR_array_paper, "-.*", "linewidth", 2, "markersize", 5)
% plot(30:10:140, SNR_array_foil, "--o", "linewidth", 2, "markersize", 5)
% ylabel("SNR/dB")
% xlabel("Speaker Distance/cm")
% legend("Speaker w/o tin foil", "Speaker w/ tin foil")



% filepath = "/home/ziqi/Desktop/collected_data_20191124/dist_220_00_70_p.txt";
% bb_frames = read_file_into_matrix(filepath);

% load("/home/ziqi/Desktop/cached_data_20191124/dist_220_00_40_p.mat")

% target_bins = findsoundbin(bb_frames); 

%         [value_max,id_max]=max(P1);

% figure()
% plot(f,P1) 


% signal_template = sin(2*pi*f_target*t);

% SNR_phase = snr(phase(data));
% SNR_amp = snr(abs(data));
% soundsc(abs(data),Fs)

% [sound_wave, sound_Fs] = audioread("mary_has_a_little_lamb.wav");

% figure()
% plot(f(1000:end),P1(1000:end)) 
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')

% figure()
% stft(bb_frames(:,14),Fs,'Window',hamming(256),'OverlapLength',192,'FFTLength',256);

% This is for "marry has a little lamb" recovery
% % [S, F, T] = stft(bb_frames(:,4),Fs,'Window',hamming(192),'OverlapLength',160,'FFTLength',192);
% [S, F, T] = stft(bb_frames(:,4),Fs,'Window',hamming(256),'OverlapLength',192,'FFTLength',256);

% % Reserved: pcolor usage
% s = pcolor(abs(bb_frames));
% set(s, 'EdgeColor', 'none');
% s.FaceColor = 'interp';

% plot(abs(bb_frames(2000,:)))
% plot(angle(bb_frames(1:2000,4)))

