function  filter_coeffs = comp_filter_design(osf, numberTaps)
%
% function  output = comp_filter_design(osf, numberTaps)
%
% Returns a cdma-2000 complementary filter, given the oversampling factor, and the number of taps
%
% Description:
% ------------
%  Returns the cdma2000 complementary filter
%
% Input variables:
% ----------------
%  osf				: oversampling factor with respect to 1x chip rate (1.2288 MHz)
%  numberTaps			: number of taps in the output filter
%
% Output variables:
% -----------------
%  filter_coeffs		: FIR filter coeffs
%
% Calls:
% -----------------
%  transmit_filter_response	: Finds the cdma2000 transmit filter response
%
% Notations:
% ----------
%
% Known Bugs:
% -----------
%
% References:
% -----------
%  [HOU99]:, Hou W. & Kwon H.M., "Complementary filter design for testing of IS-95
%            code division multiple access wireless communication systems," IEEE Trans.
%            Instr. & Meas., Feb. 1999.
%
% Revision History
% ----------------
%  - August 7, 2009 - Started.
% *****************************************************************************
%
% CONSTANTS:
%
RAISED_COS_ALPHA		= 0.2;
KAISER_BETA			= 6.65;
XMIT_FILTER_MIN_TAP		= -60;			% 40 dB down
FREQ_POINTS_PLOT		= 100;
%
% find the transmit filter response:
%
[h_transmit mag_transmit]	= transmit_filter_response(osf, numberTaps);
plot_freq_response(mag_transmit, 21, 'Transmit Filter Response');
%
% Extract the relevant part of the transmit filter
%
h_relevant			= extract_filter_left(h_transmit, XMIT_FILTER_MIN_TAP);
figure(14)
plot(h_relevant);
mag_relevant			= freqz(h_relevant, [1], FREQ_POINTS_PLOT);
plot_freq_response(mag_relevant, 24, 'Idealized Relevant Filter Response');
%
% Save the transmit filter
%
save('is95_transmit_filter.dat', 'h_relevant', '-ascii');
%
% Create the filter matrix from the relevant part of the impulse response
%
filter_matrix			= calculate_filter_matrix(h_relevant);
size(filter_matrix)
%
% Find the idealized composite response (transmit + receive) = raised_cosine
%
length_relevant			= length(h_relevant);
length_raised_cosine		= 2*length_relevant-1;
[h_ideal mag_ideal]		= raised_cosine_response(osf, RAISED_COS_ALPHA, length_raised_cosine);
plot_freq_response(mag_ideal, 22, 'Idealized Filter Response');
%
% Window the ideal response
%
h_windowed			= kaiser(length_raised_cosine, KAISER_BETA) .* h_ideal';
size(h_windowed)
figure(13);
plot(h_windowed);
grid on;
mag_windowed			= freqz(h_windowed, [1], FREQ_POINTS_PLOT);
plot_freq_response(mag_windowed, 23, 'Idealized Windowed Filter Response');
%
% De-convolve by using LSQR
%
h_complementary			= lsqr(filter_matrix, h_windowed);
figure(15)
plot(h_complementary)
return;