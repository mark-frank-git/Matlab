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
ITERATIONS		= 100;
PLOT			= 0;
%
% Get the codes from disk:
%
codes			= dlmread('barker_codes_22.dat', ' ');
codes			= codes(:,1:code_length);

%
% Get the reference code, its mismatched filter, and the response, b
%
ref_index		= 1;
s_ref			= exp(i*codes(ref_index,:));
[filterFn islDB snrLoss codA] = optimalSidelobe(s_ref, code_length, weighting_type, filter_length, 0);
b							  = xcorr(filterFn, s_ref);
b							  = b(filter_length-code_length+1:length(b))';
%
% Loop over the iterations
%
index			= 2;
for iter	    = 1:ITERATIONS
  s_in				= exp(i*codes(index,:));
  code_length		= length(s_in);
%
% Find the filter to match sidelobes
%
  [filterFn relRes] = optimalSidelobeSuppressionLS(s_in, filter_length, b, filterFn.', 0);
  fprintf(1, 'i = %d, residual = %g\n', iter, relRes);
  residual(iter)	= relRes;
%
% Plot the reference b:
%
  if(PLOT)
    figure(1)
    plot(10.*log10(abs(b)), 'LineWidth', LINE_WIDTH);
    title('Reference Pulse Compression Output');
    xlabel('delay');
    ylabel('Magnitude in dB');
    grid on;
  end
%
% Get the new reference and its response:
%
  temp				= index;
  index				= ref_index;
  ref_index			= temp;
  lambda			= generateLambdaLS(s_in, code_length, filter_length);
  b_calc			= lambda * filterFn.';
  b					= b_calc;
%
% Plot it:
%
  if(PLOT)
    figure(2)
    plot(10.*log10(abs(b)), 'LineWidth', LINE_WIDTH)
    title('Matched Pulse Compression Output');
    xlabel('delay');
    ylabel('Magnitude in dB');
    grid on;
  keyboard
  end
  
end
%
% Plot results
%
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
plot(residual, 'LineWidth', LINE_WIDTH);
title('LS Residual Levels');
xlabel('Iteration Number');
ylabel('Relative Residual Level');
grid on;
