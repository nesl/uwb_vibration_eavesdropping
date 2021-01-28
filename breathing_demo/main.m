path = "~/Desktop/uwb_sound_data/collected_data_20191124/breath_65_akash_2.txt";
data_vals = read_file_into_matrix(path);

% load("~/Desktop/uwb_sound_data/cached_data_20191124/breath_65_ziqi_1.mat");
% data_vals = bb_frames;

data_vals = [real(data_vals) imag(data_vals)];
breath_bin = findbreathbin(data_vals);
disp(breath_bin(1));
plot_values_over_time(data_vals, breath_bin(1));