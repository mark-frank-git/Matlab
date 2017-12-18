function  [h, w] = bb_filter_response(osf, numberPoints)
%
% function  [h, w] = bb_filter_response (osf, numberPoints)
%
% Returns the frequency response of the baseband filter from
% IS-95/cdma2000
%
% Description:
% ------------
%  Returns the bb filter response
%
% Input variables:
% ----------------
%  osf			: oversampling factor with respect to 1x chip rate (1.2288 MHz)
%                       : this is assumed to be greater than or equal to 4 (no error checking)
%  numberPoints		: number of points to calculate frequency response
%
% Output variables:
% -----------------
%  h			: filter complex magnitudes
%  w			: array of frequency points
%
% Calls:
% -----------------
%  freqz
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
%  - Aug 7, 2009 - Started.
% *****************************************************************************
%
% Constants:
%
NOMINAL_OSF	= 4;
%
% Load the filter coefficients.  These are at 4 x chip rate
%
load is95_bb_filter.dat;
%
% Interpolate up to OSF
%
t		= 1:1:length(is95_bb_filter);
t2		= 1:NOMINAL_OSF/osf:length(is95_bb_filter);
is95_bb_interp	= interp1(t, is95_bb_filter, t2, 'pchip');
%
% Find the response
%
[h, w]		= freqz(is95_bb_interp, [1], numberPoints);

return;