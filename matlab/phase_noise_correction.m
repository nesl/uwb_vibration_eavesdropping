function [data_frame_after_pnc] = phase_noise_correction(data_frame, ref_bin)
% Phase Noise Correction Function
% Input: Raw baseband frame matrix with dim time*bins
% Output: frame matrix after 
    referece_phase = mean(phase(data_frame(:,ref_bin)));
    data_frame_after_pnc = zeros(size(data_frame));
    % Note:
    for i = 1:size(data_frame, 1)
        temp = data_frame(i,:);
        phase_difference = referece_phase - phase(temp(1));
        temp = temp .* exp(1j * phase_difference);
        data_frame_after_pnc(i,:) = temp;
    end
end

