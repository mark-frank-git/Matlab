%
% Script program to test LS algorithm for sidelobes
%
% *****************************************************************************
%
%
%
addpath('..\poly_phase_codes');
SAMPLES_PER_BIT	= 1;
weighting_type	= 1;
code_length		= 16;
filter_length	= 71;
code_type_ref	= 3;		% Barker polyphase
code_type_in	= 4;
%
% Get the code:
%
s_in			= exp(i*polyphase_code(code_type_in, code_length, SAMPLES_PER_BIT));
code_length		= length(s_in);
lambda			= generateLambdaLS(s_in, code_length, filter_length);

%
% Find the optimal ISL filter
%
s_ref						  = exp(i*polyphase_code(code_type_ref, code_length, SAMPLES_PER_BIT));
[filterFn islDB snrLoss codA] = optimalSidelobe(s_ref, code_length, weighting_type, filter_length, 0);
b							  = xcorr(filterFn, s_ref);
b							  = b(filter_length-code_length+1:length(b))';
islDB
%
% Find the filter to match sidelobes
%
[filterFn islDB snrLoss condA lambda] = optimalSidelobeSuppressionLS(s_in, filter_length, b, filterFn.', 0);
%
% Plot results
%
figure(1)
plot(abs(b));

b_calc	= lambda * filterFn.';
figure(2)
plot(abs(b_calc))