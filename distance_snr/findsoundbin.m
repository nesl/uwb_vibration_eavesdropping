function [object_inx] = findsoundbin(iqmat)

%iqmat: (fs*30, bincnt)
sig_bg_remove = iqmat;

% % 30 seconds dec bg
% breath_win = 30;
% breath_win_samples = breath_win * fps;
% sig_baseband_dec_bg = sig_baseband_dec - mean(sig_baseband_dec);
% cfar_param.guard_cells = [1 1];
% cfar_param.training_cells = [2 2];
% cfar_param.alg = 'OS-CFAR';
% cfar_out = detector_CFAR(sig_baseband_dec_bg, cfar_param); 
% scale_max = 100;



% standard deviation  detection
sig_sd =  std(sig_bg_remove);


if 0
% width of person is less 50cm
cfar_param.guard_cells = [0 3];
cfar_param.training_cells = [0 4];
cfar_param.alg = 'CA-CFAR';

% subplot(211);
% plot(sig_sd);
cfar_out = detector_CFAR(sig_sd, cfar_param);
end

param.guard_cells = [0 5];
param.training_cells = [0 10];
param.threshold = 1;
param.alg = 'CA-CFAR';
% param.alg = 'OS-CFAR';

cfar_out = detector_CFAR_v26(sig_sd, param);


% subplot(212);
% plot(cfar_out);
[~,object_inx] = findpeaks(cfar_out,'SortStr','descend');
if length(object_inx) < 1
    fprintf('[no object]');
    return;
end

end
