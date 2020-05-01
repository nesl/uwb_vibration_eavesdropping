addpath("~/Desktop/collected_data_20200430/through_wall/");
listing = dir("~/Desktop/collected_data_20200430/through_wall/");
for i = 3:length(listing)
    filename = listing(i).name;
    distance = split(filename,"_");
    distance = distance{4};
    bb_frames = read_file_into_matrix(filename);
    save(distance+".mat", "bb_frames");
end