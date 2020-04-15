function [reordered_frames] = reorganize_bb_frames(bb_frames)
    num_of_bins = size(bb_frames, 2);
    reordered_frames = zeros(size(bb_frames));
    if mod(num_of_bins, 2)
        half_frame_size = (num_of_bins-1)/2;
    else
        half_frame_size = num_of_bins/2;
    end
    
    for i = 1: half_frame_size
        reordered_frames(:, 2 * i - 1) = bb_frames(:, half_frame_size + i);
        reordered_frames(:, 2 * i) = bb_frames(:, i);
    end
    if mod(num_of_bins, 2)
        reordered_frames(:, end) = bb_frames(:, end);
    end
end

