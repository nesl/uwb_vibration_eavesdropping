rootpath = "/home/ziqi/Desktop/collected_data_20191204/";
filelist = dir(rootpath);
for i = 3:length(filelist)
    filepath = rootpath + filelist(i).name;
    bb_frames = read_file_into_matrix(filepath);
    temp = split(filelist(i).name,".");
    save(temp(1) +".mat")
end