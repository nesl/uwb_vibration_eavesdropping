% filepath = "~/Desktop/uwb_sound_data/collected_data_20200511/";
% filepath = "~/Desktop/uwb_sound_data/temp";
filepath = "~/hdd/code-archive/UWB-Sound-Extraction-Project/uwb_sound_data/temp";
addpath(filepath);
listing = dir(filepath);
for i = 3:length(listing)
    filename = listing(i).name;
    new_name = erase(filename, ".txt");
%     distance = split(filename,"_");
%     distance = distance{4};
    bb_frames = read_file_into_matrix(filename);
    save(new_name + ".mat", "bb_frames");
end