function times = generate_sample_times(number_points, number_segments, max_skip, max_rate_change, range)
% **********************************************************************
% function generate_sample_times(number_points, number_segments, max_skip, max_rate_change, range)
%
% Generates random sample times, given number points and random range
%
% Description:
% -----------
% Generate random sample times
%
% Input variables:
% -----------------------
%  number_points    : Number of points per segment to generate
%  number_segments  : Number of segments with different sample rates
%  max_skip         : Max number of missing (skipped samples) between segments
%  max_rate_change  : Max rate change for each segment.  rate = 1 + [-max_rate_change/2, max_rate_change/2]
%  range            : random range in [0, 1]
%
% Output variables:
% -----------------------
%  times            : Random sample times
%
% Notes:
% ----------
% The first and last points are pegged at 0 and number_points-1
%
% Calls:
% -----------
%  None
%
% References:
% -----------
% None
%
% Revision History
% ----------------
%  - April 6, 2013 - Started
% *************************************************************************
%
%
start_time              = 0;
times                   = [];
for i=1:number_segments
  rate                  = max_rate_change*(rand()+0.5);
  segment_times         = get_segment(number_points, start_time, rate, range);
  if(i==1)
    times               = segment_times';
  else
    times               = [times;segment_times'];
  end
  skip                  = max_skip*rand();
  start_time            = segment_times(number_points) + skip;
end
return

function times = get_segment(number_points, start_time, rate, range)
% **********************************************************************
% function get_segment(number_points, start_time, rate, range)
%
% Generates a segment of random sample times, given number points and random range
%
% Description:
% -----------
% Generate random sample times
%
% Input variables:
% -----------------------
%  number_points    : Number of points per segment to generate
%  start_time       : Segment start time
%  rate             : rate for this segment
%  range            : random range in [0, 1]
%
% Output variables:
% -----------------------
%  times            : Random sample times
%
% Notes:
% ----------
% None
%
% Calls:
% -----------
%  None
%
% References:
% -----------
% None
%
% Revision History
% ----------------
%  - April 6, 2013 - Started
% *************************************************************************
%
%
times                   = 0:number_points-1;
delta_times             = range*(rand(1, number_points) - 0.5);
times                   = start_time + rate*(times + delta_times);
return;
