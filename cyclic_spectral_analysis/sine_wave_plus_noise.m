function  signal = sine_wave_plus_noise(SNR, frequency, fs, numberPoints)
%
% function  signal = sine_wave_plus_noise(SNR, frequency, fs, numberPoints)
%
% sine_wave_plus_noise returns a sine wave plus noise as a complex row vector
%
% Description:
% ------------
%  Returns a sine wave plus noise.  The sine wave has amplitude = 1, the
%  noise is scaled to get the SNR.
%
% Input variables:
% ----------------
%  SNR				: signal-to-noise ratio in dB
%  frequency		: sine wave frequency in Hz
%  fs				: sampling frequency in Hz
%  numberPoints		: number of points to generate
%
% Output variables:
% -----------------
%  signal			: sine wave plus noise as a row vector
%
% Notations:
% ----------
%
% Known Bugs:
% -----------
%
% References:
% -----------
%
% Revision History
% ----------------
%  - April 23, 2005 - Started.
% *****************************************************************************
SINE_AMPLITUDE		= 1.;
%
% First calculate noise scaling:
%
signal_to_noise		= 10.^(SNR/10.);
noise_variance		= SINE_AMPLITUDE/2./signal_to_noise;
noise_scale			= sqrt(noise_variance);
%
% Now get theta as a function of time:
%
delta_time			= 1./fs;
time				= delta_time*[0:numberPoints-1];
theta				= i*2.*pi*frequency*time;
%
%  Get sine wave plus noise
%
signal				= exp(theta) + noise_scale*(randn(1, numberPoints)+i*randn(1, numberPoints));
