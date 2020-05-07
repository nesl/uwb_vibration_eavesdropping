function [Hd, b ,a ] = comb_1200fs_60x_bw8
%COMB_1200FS_60X_BW8 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.7 and DSP System Toolbox 9.9.
% Generated on: 06-May-2020 11:24:36

% IIR Comb Notching filter designed using the IIRCOMB function.

% All frequency values are in Hz.
Fs = 1200;  % Sampling Frequency

N     = 20;  % Order
BW    = 8;   % Bandwidth
Apass = 1;   % Bandwidth Attenuation

[b, a] = iircomb(N, BW/(Fs/2), Apass);
Hd = dsp.IIRFilter( ...
    'Structure', 'Direct form II', ...
    'Numerator', b, ...
    'Denominator', a);

% [EOF]
