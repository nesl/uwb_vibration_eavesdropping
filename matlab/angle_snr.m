close all; clear all; clc
cache_path = "~/Desktop/uwb_sound_data/collected_data_20200511/angle_cache";
addpath(cache_path);
listing = dir(cache_path);

place_angles = [];
SNR_array_paper = [];
bin_array_paper = [];
SNR_array_short_time = [];

for i = 3:length(listing)
    filename = listing(i).name;
    placement_angle = split(filename,"_");
    placement_angle = str2double(placement_angle{2});
    load(filename);
    bb_frames = phase_noise_correction(bb_frames, 1);
    bb_frames = stationary_clutter_suppression(bb_frames);
    bb_frames = [real(bb_frames), imag(bb_frames)];
    
    Fs = 1500;            % Sampling frequency                   
    f_target = 261.63;
    bw_target = 5;
    
    SNR_temp = [];
    for j = 1:size(bb_frames, 2)
        data = bb_frames(:,j);
        SNR = self_snr(data, Fs,f_target, bw_target);
        SNR_temp = [SNR_temp SNR];
    end
    
    max_SNR = max(SNR_temp);
    max_bin = find(SNR_temp == max_SNR);
    
    data = real(bb_frames(2500:end,max_bin)); % The beginning is noise sample
    window_len = 1*1500;
    overlap_len = 0.5*window_len;
    num_frames = floor(length(data)/overlap_len)-1;
    short_time_snr = -realmax * ones(1, num_frames);
    for frame_cnt = 1:num_frames
        short_time_frame = data((frame_cnt-1)*overlap_len+1:(frame_cnt-1)*overlap_len+window_len);
        short_time_snr(frame_cnt) = self_snr(short_time_frame, Fs,f_target, bw_target);
    end
    SNR_array_short_time = [SNR_array_short_time; short_time_snr];
    
    SNR_array_paper = [SNR_array_paper max_SNR];
    bin_array_paper = [bin_array_paper max_bin];
    place_angles = [place_angles; placement_angle];
    fprintf("%d\t", placement_angle);
end


figure()
hold on
plot(1:length(place_angles), mean(SNR_array_short_time,2), "-.", "linewidth",4)
boxplot(SNR_array_short_time')
ylabel("SNR/dB")
xlabel("Speaker Placement Angle/cm")
xticklabels(place_angles)
title("SNR vs Speaker Placement Angle")


% mean(short_time_snr)
% soundsc(data, Fs)
% sig = sin((0:1/1500:10)*2*pi*261.63);
% sig_noise = awgn(sig, 5);
% soundsc(sig_noise, Fs);
