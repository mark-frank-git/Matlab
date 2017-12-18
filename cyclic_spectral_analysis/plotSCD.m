function  S = plotSCD(data, fs, N, L, Np, M, scdType)
%
% function  S = plotSCD(data, fs, N, L, Np, M, scdType)
%
% plotSCD plots and returns the spectral correlation density function for
% an input array.
%
% Description:
% -----------
%  Returns the spectral correlation density function
%
% Input variables:
% ----------------
%  data			: Complex input data array
%  fs			: Sampling frequency in Hertz
%  N			: Size of FFT blocks (should be a power of 2)
%  L			: Decimation factor (N/4 is a good value).
%  Np			: Size of FFT for FAM
%  M			: Reliability condition.
%  scdType		: 1 = use DFSM, 2 = use FAM 
%
% Output variables:
% ----------------
%  S			: Spectral correlation density function
%
% Notations:
% ----------
%
% Calls:
% -----------
% fft_accumulation_method <or> dfsm_pace: calculates the SCD
%
% References:
% -----------
%  [PAC04]:P.E. Pace, Detecting and Classifying Low Probability of
%  Intercept Radar, Artech House, 2004.
%
% Revision History
% ----------------
%  - July 14, 2005 - Started.
% *****************************************************************************
%
%
SCD_PLOT		= 4;
GRAY_VALUES		= 40;
DFSM			= 1;
FAM				= 2;
%
% Find the SCD
%
switch scdType
	case DFSM
		[S freq alpha]	= dfsm_pace(data, fs, Np, L);
		title_string	= 'DFSM ';
	case FAM
		[S freq alpha]	= fam_pace(data, fs, Np, M);
		title_string	= 'FAM ';
end
%
% Use an inverse gray color map
%
colormap(gray(GRAY_VALUES));
cmap	= colormap;
[m n]	= size(cmap);
new_map	= zeros(m,n);
for k=1:m
  new_map(m-k+1,:)	= cmap(k,:);
end
%
% Scale SCD:
%
size(S)
S				= abs(S);
S				= S./max(max(S));
%
% plot it
%
figure(SCD_PLOT), clf, hold off
h = pcolor(alpha, freq, S);
colormap(new_map)
set(h, 'EdgeAlpha', 0);
%colorbar
grid;

xlabel('Cycle frequency (Hz)'); ylabel('Frequency (Hz)');
title ([title_string, ', Np = ', int2str(Np)]);
axis([-4000 4000  -500 2500])

clear title_string;
clear freq;
clear alpha;
clear cmap;
clear new_map;
clear k;

