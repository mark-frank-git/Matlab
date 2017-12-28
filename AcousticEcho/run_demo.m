function run_demo
% **********************************************************************
% function run_demo
%
% Runs the Matlab demo, which is a modification of the demonstration from:
% http://www.mathworks.com/help/audio/examples/acoustic-echo-cancellation-aec.html?s_tid=gn_loc_drop
% to run all of Matlab's adaptive filters, and compare the timings and results
%
% Description:
% -----------
% Runs the Matlab demo
%
%
% Revision History
% ----------------
%  - Dec. 15, 2017 - Started
% *************************************************************************
% Initialize
fsImpulse       = 16000;
frameSize       = 2048;

%% Get the room impulse response
impulseResponse = room_impulse_response(fsImpulse, frameSize);

%% Get near end speech (load into v), also loads in fs
load nearspeech;

%%Set up audio player
player          = audioDeviceWriter('SupportVariableSizeInput', true, ...
                                    'BufferSize', 512, 'SampleRate', fs);
playNearEnd     = 0;
if(playNearEnd)
  process_speech(fs, frameSize, v, 'Near-end Speech', player);
end

%% Get far end speech (load into x)
load farspeech;
playFarEnd      = 0;
if(playFarEnd)
  process_speech(fs, frameSize, x, 'Far-end Speech', player);
end

%% Get the echoed speech
room            = dsp.FIRFilter('Numerator', impulseResponse');
farSpeechEcho   = room(x);

%% Add near, far end speech, noise
noise           = 0.001*randn(length(v),1);
micSignal       = v + farSpeechEcho + noise;
playMicSpeech   = 0;
if(playMicSpeech)
  process_speech(fs, frameSize, micSignal, 'Near + far-end speech', player);
end

%Loop over the different algorithms, cancel the echo with each, and then display the results
%in a time scope.  Record the amount of time for each algorithm, and also display this
speechLength    = length(x);
functions       = {@freqDomainAdaptiveFilter, @lmsAdaptiveFilter, @affineProjectionFilter, @filteredXLmsFilter, @latticeAdaptiveFilter};
numberFunctions = length(functions);
numberFrames    = floor(speechLength/frameSize);
truncatedSize   = numberFrames*frameSize;
speech          = zeros(truncatedSize, numberFunctions);
t               = zeros(1,numberFunctions);
titles          = ["Frequency Domain", "LMS", "Affine", "XLMS", "Lattice"];
% Run the algorithms
for i=1:numberFunctions
  tic;
  speech(:,i) = functions{i}(frameSize, x, micSignal);
  t(i)        = toc;
  titles(i)   = titles(i) + ', time = ' + string(t(i));
end
% Insert the algorithm results into a time scope
persistent timeScope
timeScope     = setupTimeScope(fs, speechLength, titles);
timeScope(speech(:,1), speech(:,2), speech(:,3), speech(:,4), speech(:,5));
return;
