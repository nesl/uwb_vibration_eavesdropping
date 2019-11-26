path = "..\..\collected_data\collected_data_191109\breathing_c_127_0.txt";
% data_vals = read_file_into_matrix(path);
breath_bin = findbreathbin(data_vals);
disp(breath_bin(1));
plot_values_over_time(data_vals, breath_bin(1));
%127 65, should be bin 8