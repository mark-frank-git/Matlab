function  [filter_coeffs freq_response] = transmit_filter_response(osf, numberTaps)
%
% function  [filter_coeffs freq_response] = transmit_filter_response(osf, numberTaps)
%
% Returns the cdma2000 transmit filter coefficients and frequency response
%
% Description:
% ------------
%  Returns the cdma2000 transmit filter
%
% Input variables:
% ----------------
%  osf				: oversampling factor with respect to 1x chip rate (1.2288 MHz)
%  numberTaps			: number of taps in the transmit filter
%
% Output variables:
% -----------------
%  filter_coeffs		: FIR filter coeffs
%  freq_response		: Frequency response of filter
%
% Calls:
% -----------------
%  bb_filter_response		: calculates the response of the BB transmit filter
%  phase_equalizer_response	: calculates the response of the phase equalizer filter
%
% Notations:
% ----------
%
% Known Bugs:
% -----------
%
% References:
% -----------
%  [IS-98]: IS-98 BTS specification
%
% Revision History
% ----------------
%  - August 7, 2009 - Started.
% *****************************************************************************
%
% CONSTANTS:
%
TRANSMIT_TAPS		= 257;			% Should be power of 2 + 1
TRANSMIT_OSF		= 16;
TRANSMIT_FREQ_POINTS	= 256;
%
% Get the IS-95 BB filter response
%
[h_bb w_bb]		= bb_filter_response(TRANSMIT_OSF, TRANSMIT_TAPS);
%
% Get the phase equalizer filter response
%
[h_pe w_pe]		= phase_equalizer_response(TRANSMIT_OSF, TRANSMIT_TAPS);
%
% Get the total response:
%
h_total			= h_bb .* h_pe;
%
% duplicate for fft
%
index			= linspace(TRANSMIT_TAPS-1,2,TRANSMIT_TAPS-2);
h_fft			= [h_total' h_total(index)'];
%
% 
figure(1);
plot(abs(h_fft))
%
% find the impulse response
%
h_imp			= ifft(h_total, 2*TRANSMIT_TAPS-1, 'symmetric');
%
% Interpolate to the desired oversampling factor
%
t			= 1:1:length(h_imp);
t2			= 1:TRANSMIT_OSF/osf:length(h_imp);
h_imp_interp		= interp1(t, real(h_imp), t2, 'pchip');
%
% return the outputs:
%
output_size		= min(numberTaps, length(h_imp_interp));
filter_coeffs		= h_imp_interp(1:output_size);
%
% plot the impulse response:
%
figure(2)
plot(filter_coeffs, '-o');

[freq_response w]	= freqz(filter_coeffs, [1], TRANSMIT_FREQ_POINTS);
return;