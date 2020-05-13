addpath("~/Desktop/uwb_sound_data/collected_data_20200511/");
listing = dir("~/Desktop/uwb_sound_data/collected_data_20200511");
for i = 3:length(listing)
    filename = listing(i).name;
    new_name = erase(filename, ".txt");
%     distance = split(filename,"_");
%     distance = distance{4};
    bb_frames = read_file_into_matrix(filename);
    save(new_name + ".mat", "bb_frames");
end