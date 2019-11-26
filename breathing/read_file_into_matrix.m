

function [data_frames] = read_file_into_matrix(filepath)
% Takes as input a filename, outputs a matrix of values
    %disp(filepath);
    fid = fopen(filepath);
    tline = fgetl(fid);
    data_frames = [];
    while ischar(tline)
        if (~contains(tline,"{") && ~contains(tline,"}")) || isempty(tline)
            tline = fgetl(fid);
            continue
        else
            data_points = split(strtrim(tline), [",","|","{","|","}"]);
            data_points = data_points(3:length(data_points)-2);
            data_points = str2double(data_points);
            data_bins = [];
            for idx = 1:2:length(data_points)
                complex_val = complex(data_points(idx), data_points(idx+1)) %real + imag
                data_bins = [data_bins, complex_val]
            end
            % Append data bins to data frame
            data_frames = [data_frames; data_bins];
        end
        tline = fgetl(fid);
    end
    %disp(tline);
    %disp(szdim(data_frames));
end 
