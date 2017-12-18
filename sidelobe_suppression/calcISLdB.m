function  islDB = calcISLdB(corrFn)
%
% function  islDB = calcISLdB(corrFn)
%
% islDB calculates integrated side lobe level in dB relative the peak.
%
% Description:
%  Calculates mismatched filter
%
% Input variables:
% ----------------
%  corrFn:			(auto/cross) correlation array
%
% Output variables:
% ----------------
%  islDB:			The integrated sidelobe level in dB relative to the peak.
%
% Notations:
% ----------
%
% Known Bugs:
% ----------
%
% References:
% ----------
%  [LEV04]: Levanon, N. and Mozeson, E. Radar Signals, John Wiley & Sons, 2004.
%  [GRI95]: Griep, K.R., Ritcey, J.A., Burlingame, J.J., "Polyphase codes
%  and optimal filters for multiple user ranging," IEEE Trans Aero, April
%  1995.
%
% Revision History
% ----------------
%  - April 11, 2005 - Started.
% *************************************************************************
%
% Calculate isl, and normalize to peak value
%
[peak peak_index]	= max(abs(corrFn));
peak				= corrFn(peak_index);
corrFn(peak_index)	= 0.;
isl_level			= corrFn*corrFn';
peak_level			= peak*conj(peak);
if(peak_level > 0.)
	islDB			= 10.*log10(isl_level/peak_level);
else
	islDB			= 0.;
end