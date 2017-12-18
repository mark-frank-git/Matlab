%
% Script program to test LS algorithm for sidelobes
%
% *****************************************************************************
%
%
%
weighting_type	= 1;
code_length		= 22;
filter_length	= 64;
LINE_WIDTH		= 2.0;
%
% Get the codes from disk:
%
codes			= dlmread('barker_codes_22.dat', ' ');
codes			= codes(:,1:code_length);

%
% Find the optimal ISL filter
%
k				= 1;
min_res			= 100;
for ref_index=1:5
  s_ref						  = exp(i*codes(ref_index,:));
  [filterFn islDB snrLoss codA] = optimalSidelobe(s_ref, code_length, weighting_type, filter_length, 0);
  b							  = xcorr(filterFn, s_ref);
  b							  = b(filter_length-code_length+1:length(b))';
%
% Try to match to the input code
%
  for index=ref_index+1:100
    s_in		    = exp(i*codes(index,:));
    code_length		= length(s_in);
    lambda			= generateLambdaLS(s_in, code_length, filter_length);
%
% Find the filter to match sidelobes
%
    [filterFn relRes] = optimalSidelobeSuppressionLS(s_in, filter_length, b, filterFn.', 0);
    rel_res(k)			= relRes;
    k					= k+1;
    if(relRes < min_res)
      min_ref			= ref_index;
      min_in			= index;
      min_res			= relRes;
    end
  end
end
%
% Plot results
%
s_ref						  = exp(i*codes(min_ref,:));
[filterFn islDB snrLoss codA] = optimalSidelobe(s_ref, code_length, weighting_type, filter_length, 0);
b							  = xcorr(filterFn, s_ref);
b							  = b(filter_length-code_length+1:length(b))';

s_in			= exp(i*codes(min_in,:));
code_length		= length(s_in);
lambda			= generateLambdaLS(s_in, code_length, filter_length);
%
% Find the filter to match sidelobes
%
[filterFn relRes] = optimalSidelobeSuppressionLS(s_in, filter_length, b, filterFn.', 0);


figure(1)
plot(10.*log10(abs(b)), 'LineWidth', LINE_WIDTH);

title('Reference Pulse Compression Output');
xlabel('delay');
ylabel('Magnitude in dB');
grid on;

figure(2)
b_calc	= lambda * filterFn.';
plot(10.*log10(abs(b_calc)), 'LineWidth', LINE_WIDTH)
title('Matched Pulse Compression Output');
xlabel('delay');
ylabel('Magnitude in dB');
grid on;

figure(3)
plot(rel_res, 'LineWidth', LINE_WIDTH);
title('LS Residual Levels');
xlabel('Index of code pairs');
ylabel('Relative Residual Level');
grid on;
