function  [filter_coeffs freq_response] = raised_cosine_response(osf, alpha, numberTaps)
%
% function  [filter_coeffs freq_response] = raised_cosine_response(osf, numberTaps)
%
% Returns the impulse and frequency response of a raised cosine filter
%
% Description:
% ------------
%  Returns the raised cosine response
%
% Input variables:
% ----------------
%  osf			: oversampling factor (d)
%  alpha		: Transition parameter alpha in (0, 1)
%  numberTaps		: number of taps for filter (should be odd)
%
% Output variables:
% -----------------
%  filter_coeffs		: FIR filter coeffs
%  freq_response		: Frequency response of filter
%
% Calls:
% -----------------
%  None
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
FREQ_POINTS			= 256;
%
m				= (numberTaps-1)/2;
n				= linspace(0,numberTaps-1, numberTaps);
sin_fn				= sin(pi*(n-m)/osf);
cos_fn				= cos(alpha*pi*(n-m)/osf);
den1				= pi*(n-m)/osf;
den2				= 1-(2*alpha*(n-m)/osf).^2;
filter_coeffs			= sin_fn .* cos_fn ./ den1 ./ den2;
%
% Find where denominators == 0, and then substitute in limit values:
%
index_zero			= find(den1 == 0);
filter_coeffs(index_zero)	= 1;
index_zero			= find(den2 == 0);
if(length(index_zero) > 0)
  filter_coeffs(index_zero)	= alpha*sin(pi/2/alpha)/2;
end
%
% Plot the impulse response:
%
figure(10)
plot(filter_coeffs);
%
% Get the frequency response:
%
[freq_response w]	= freqz(filter_coeffs', [1], FREQ_POINTS);
plot_freq_response(freq_response, 5, 'Raised Cosine Freq Response');

return;