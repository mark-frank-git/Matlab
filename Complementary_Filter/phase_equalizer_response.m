function  [h, w] = phase_equalizer_response(osf, numberPoints)
%
% function  [h, w] = phase_equalizer_response(osf, numberPoints)
%
% Returns the frequency response of the phase equalizer filter from
% IS-95/cdma2000
%
% Description:
% ------------
%  Returns the phase equalizer response
%
% Input variables:
% ----------------
%  osf			: oversampling factor with respect to 1x chip rate (1.2288 MHz)
%  numberPoints		: number of points to calculate frequency response
%
% Output variables:
% -----------------
%  h			: filter complex magnitudes
%  w			: array of frequency points
%
% Calls:
% -----------------
%  TBD	: generates the code
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
THETA		= 1.36;
OMEGA_0		= 2*pi*3.15e5;
CHIP_RATE	= 1.2288e6;
%
% Get the frequency spacing:
%
omega		= linspace(0, pi*CHIP_RATE*osf, numberPoints)';
%
numerator	= omega .^2 + i*THETA*OMEGA_0*omega - OMEGA_0^2;
denominator	= omega .^2 - i*THETA*OMEGA_0*omega - OMEGA_0^2;
h		= numerator ./ denominator;
w		= omega;

return;