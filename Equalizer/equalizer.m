function [numd dend] = equalizer(zeros, poles, fs, startExp, endExp, fp)
%function [numd dendd] = equalizer(zeros, poles, fs, startExp, endExp, fp)
%
%
% Description:
% ------------
%  Calculates and plots the frequency response of the equalizer filter (actually, any filter).
%  It can be used for checking the SToZ.h/cpp class
%
% Input variables:
% ----------------
%  zeros        : column vector of equalizer zeros in Hertz
%  poles 		: column vector of equalizer poles in Hertz
%  fs           : Sampling frequency in Hertz
%  startExp		: Exponent of start frequency to plot, for example to start at 10^8 Hz, set startExp=8
%  endExp       : Exponent of end frequency to plot, for example to end at 10^11 Hz, set endExp=11
%  fp           : Pre-warp frequency to match (NOTE: NO PRE-WARPING IS CURRENTLY PERFORMED IN C++ CODE)
%
% Output variables:
% -----------------
%  numd         : z domain numerator coefficients
%  dend         : z domain denominator coefficients
%
% Revision History
% ----------------
%  - May 22, 2014 - Started.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% convert poles and zeros to omega
poles			= 2.*pi*poles;
zeros			= 2.*pi*zeros;
% Convert to transfer function
gain			= 1.;
[b,a]			= zp2tf(zeros,poles,gain);
% Plot frequency response
figure(1)
w				= 2.*pi*logspace(startExp,endExp);
h				= freqs(b,a,w);
magDb			= 20.*log10(abs(h));
x				= w/2/pi;
semilogx(x,magDb);
xlabel 'Frequency in Hz', ylabel 'Magnitude in dB'
title 'Analog Filter'
grid on
% Convert to z domain
figure(2)
points			= 4096;
[bd, ad]		= bilinear(b, a, fs, fp);
[hd, wd]		= freqz(bd, ad, points);
xd				= wd*fs/2/pi;
plot(xd, 20.*log10(abs(hd)));
ax				= findall(gcf, 'Type', 'axes');
set(ax, 'XScale', 'log');
title 'Digital Filter'
MIN_X			= 1.e8;
MAX_X			= 1.e11;
MIN_Y			= min(20.*log10(abs(hd)));
MAX_Y			= max(20.*log10(abs(hd)));
MIN_Y           = -240.;
MAX_Y           = -210.;
axis([MIN_X MAX_X MIN_Y MAX_Y]);
grid on;
% Flip and normalize to make compatible with IPP
numd            = fliplr(bd);
numd            = numd ./ numd(1);
dend            = fliplr(ad);
dend            = dend ./ dend(1);




