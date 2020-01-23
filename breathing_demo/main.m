% path = "/home/ziqi/Desktop/collected_data_20191124/breath_65_ziqi_2.txt";
% path = "/home/ziqi/Desktop/mary_demo/through_door.txt";
% data_vals = read_file_into_matrix(path);
% load("/home/ziqi/Desktop/cached_data_20191124/breath_65_ziqi_2.mat");
% load("/home/ziqi/Desktop/cached_data_20191109/breathing_b_127_0.mat");
% load("/home/ziqi/Desktop/cached_data_20191124/dist_220_00_140_f.mat")
% load("/home/ziqi/Desktop/cached_data_20191124/mary_1.mat")
% load("/home/ziqi/Desktop/cached_data_20191204/through_wall_concrete_2.mat")
load("/home/ziqi/Desktop/cached_data_20191204/human_voice_3K_3.mat")
data_vals = bb_frames;
% breath_bin = findbreathbin(data_vals);
[breath_bin, data_vals] = findvibrationbin(data_vals);
disp(breath_bin(1));
% plot_values_over_time(data_vals, breath_bin(1));
%127 65, should be bin 8