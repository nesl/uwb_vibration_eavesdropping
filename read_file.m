
function read_mat = read_file_into_matrix(filepath)
% Takes as input a filename, outputs a matrix of values
    fid = fopen(filepath);
    tline = fgetl(fid);
    while ischar(tline)
        disp(tline)
        tline = fgetl(fid);
    end
end
% 			for data_line in text_content:
% 				if ("{" not in data_line) and ("}" not in data_line):
% 					continue
% 				else:
% 					data_points = re.split(",|{|}", data_line.strip())[2:-2]
% 					data_points = [float(data_points[i]) for i in range(0, len(data_points))]
% 					real = [data_points[i] for i in range(0, len(data_points)) if i % 2 == 0]
% 					imag = [data_points[i] for i in range(0, len(data_points)) if i % 2 == 1]
% 					complex_tuples = list(zip(real, imag))
% 					data_points = [complex(each[0], each[1]) for each in complex_tuples]
% 					data_frames.append(data_points)
%                     
