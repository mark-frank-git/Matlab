function  [S f alfa] = dfsm_pace(data, fs, N, L)
%
% function  S = dfsm_pace(data, fs, N, L)
%
% dfsm_pace computes the spectral correlation density using the direct
% frequency smoothing method from Pace.
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
%
% Output variables:
% ----------------
%  S			: Spectral correlation density function
%  f			: Temporal frequency points for plotting SCD
%  alfa			: cycle frequency points for plotting SCD
%
% Notations:
% ----------
%
% Calls:
% -----------
% fft()
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
df		= N/L;				% Frequency Resolution
M		= L;				% df/dalpha = M >> 1 (reliability condition)

%N		= (M*fs)/df;
%N		= pow2 (nextpow2(N));	% windowing record for FFT
X		= fft(data,N);		% fft of the truncated (or zero padded) time series
X		= fftshift(X);		% shift components of fft
Xc		= conj(X);			% precompute the complex conjugate vector

S		= zeros (N,N);		% size of the Spectral Correlation Density matrix
f		= zeros (N,N);		% size of the frequency matrix;
alfa	= zeros (N,N);		% size of the cycle frequency matrix
F		= fs/(N+N);			% precompute constants -  F = Fs/(2*N);     
G		= fs/N;				% precompute constants -  G = Fs/N;
m		= -M/2+1:M/2;		% set frequency smoothing window index

for k = 1:N					% fix k
% computes vectors of f and alfa,
% store frequency and cycle frequency data for given k.
	k1			= 1:N;
    f(k,k1)		= F*(k+k1-1) - fs/2;	% Computes f values and shift them to
										% center in zero (f = (K+L)/2N) [1]
    alfa(k,k1)	= G*(k-k1 + N-1) - fs;	% Computes alfa values and shift them
										% to center in zero (alfa = (K-L)/N) [1]
    
    for k1 = 1:N						% fix k1 = J
% calculate X(K+m) & conj (X(J+m)) for arguments of X(1:N) only
        B = max(1-k, 1-k1);				% Largest min of 1 <= (K+m)| (J+m) <= N
        A = min (N-k, N-k1);			% Smallest max of 1 <= (K+m)| (J+m) <= N
        n = m((m<=A) & (m>=B));			% fix the index out of range problem by
										% truncating the window
        if isempty(n)
            S(k,k1) = 0;
        else
            p = k+n; q = k1+n;
            Y = X(p).*Xc(q);
            S(k,k1) = sum(Y);
        end
    end
end
