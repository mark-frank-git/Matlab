function testLSReadIterateN()
%
% Script program to test LS algorithm for sidelobes
%
% *****************************************************************************
%
%
%
weighting_type	= 1;
code_length		= 22;
filter_length	= 66;
LINE_WIDTH		= 2.0;
ITERATIONS		= 100;
PLOT			= 0;
NUMBER_CODES	= 8;
MIN_RESID		= 0;
MAX_RESID		= 0.05;
MIN_ISL			= -35;
MAX_ISL			= -5;
code_fp			= fopen('code_file.dat', 'w');
filter_fp		= fopen('filter_file.dat', 'w');
%
% Get the codes from disk:
%
codes			= dlmread('barker_codes_22_sorted.dat', ' ');
codes			= codes(:,1:code_length);

%
% Get the reference code, its mismatched filter, and the response, b
%
ref_index		= NUMBER_CODES;
s_ref			= exp(i*codes(ref_index,:));
[filterFn islDB snrLoss codA] = optimalSidelobe(s_ref, code_length, weighting_type, filter_length, 0);
b							  = xcorr(filterFn, s_ref);
b							  = b(filter_length-code_length+1:length(b))';
%
% Loop over the iterations
%
clear residual;
clear isl;
index			= 2;
for iter	    = 1:ITERATIONS
  max_res		= 0.;
  max_isl		= -100.;
  for iref		= 1:NUMBER_CODES
    ref_index	= NUMBER_CODES-iref+1;
    s_ref		= exp(i*codes(ref_index,:));
    [filterFn relRes] ...
                = optimalSidelobeSuppressionLS(s_ref, filter_length, b, filterFn.', 0);
    lambda		= generateLambdaLS(s_ref, code_length, filter_length);
    old_b		= b;
    b			= lambda * filterFn.';
    islDB		= calcISLdB(b.');
    if(islDB > max_isl)
      max_isl	= islDB;
    end
    if(relRes > max_res)
      max_res	= relRes;
    end
    if(iter == ITERATIONS)
      print_code(s_ref, code_fp);
      print_filter(filterFn, filter_fp);
    end
  end
  residual(iter)	= max_res;
  isl(iter)			= max_isl;
  fprintf(1, 'i = %d, residual = %g, isl = %g\n', iter, max_res, max_isl);
end
%
% Find the SNR loss
%
s_dot		= s_ref*s_ref';
s_ref		= s_ref/sqrt(s_dot);
filterFn	= filterFn/sqrt(filterFn*filterFn');
lambda		= generateLambdaLS(s_ref, code_length, filter_length);
signal		= lambda*filterFn.';
max_mis		= max(abs(signal));
snrLoss		= 10.*log10(1/max_mis/max_mis);
snrLoss
%
% Get the ISL
%
islDB		= calcISLdB(signal.');
islDB
%
% Plot the reference b:
%
figure(1)
b_log		= 10.*log10(abs(b));
b_max		= max(b_log);
b_log		= b_log - b_max;
plot(b_log, 'LineWidth', LINE_WIDTH);

title('Reference Pulse Compression Output');
xlabel('delay');
ylabel('Magnitude in dB');
grid on;

figure(2)
b_log		= 10.*log10(abs(old_b));
b_max		= max(b_log);
b_log		= b_log - b_max;
plot(b_log, 'LineWidth', LINE_WIDTH);

title('Reference Pulse Compression Output');
xlabel('delay');
ylabel('Magnitude in dB');
grid on;


figure(3)
plot(residual, 'LineWidth', LINE_WIDTH);
title('LS Residual Levels');
xlabel('Iteration Number');
ylabel('Relative Residual Level');
axis([0 length(residual) MIN_RESID MAX_RESID]);
grid on;

figure(4)
plot(isl, 'LineWidth', LINE_WIDTH);
title('Peak ISL vs Iteration');
xlabel('Iteration Number');
ylabel('ISL in dB');
axis([0 length(residual) MIN_ISL MAX_ISL]);
grid on;


return;


function  print_code(code, fp)
% ********************************************************************************************
% function  print_code(code, fp)
%
% Prints a code to file
%
% Description:
%  Print code
%
% Input variables:
% ----------------
%  code:			Code vector as a complex number
%  fp:				Open file pointer
%
% Output variables:
% ----------------
%  None
%
%
% Revision History
%  - Aug 22, 2007 - Started
% *****************************************************************************
%
%
% Print out code phase
%
code_phase	= phase(code);
for i=1:length(code)
  fprintf(fp, '%g ', code_phase(i));
end
fprintf(fp, '\n');
return;



function  print_filter(filter, fp)
% ********************************************************************************************
% function  print_filter(filter, fp)
%
% Prints a filter to file
%
% Description:
%  Print filter
%
% Input variables:
% ----------------
%  filter:			filter vector as a complex number
%  fp:				Open file pointer
%
% Output variables:
% ----------------
%  None
%
%
% Revision History
%  - Aug 22, 2007 - Started
% *****************************************************************************
%
%
% Print out filter phase
%
n	= length(filter);
for i=1:n
  fprintf(fp, '%g %g ', real(filter(n-i+1)), imag(filter(n-i+1)));
end
fprintf(fp, '\n');
return;



