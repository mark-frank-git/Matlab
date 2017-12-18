function run_demo
% **********************************************************************
% function run_demo
%
% Runs the Matlab demo
%
% Description:
% -----------
% Runs the Matlab demo
%
% Input variables:
% -----------------------
% None
%
% Output variables:
% -----------------------
% None
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
%% Get near end speech, also loads in fs
load nearspeech;
%%Set up audio player
player          = audioDeviceWriter('SupportVariableSizeInput', true, ...
                                    'BufferSize', 512, 'SampleRate', fs);
%process_speech(fs, frameSize, v, 'Near-end Speech', player);
%% Get far end speech
load farspeech;
%process_speech(fs, frameSize, x, 'Far-end Speech', player);
%% Get the echoed speech
room            = dsp.FIRFilter('Numerator', impulseResponse');
farSpeechEcho   = room(x);
%% Add near, far end speech, noise
noise           = 0.001*randn(length(v),1);
total           = v + farSpeechEcho + noise;
process_speech(fs, frameSize, total, 'Near + far-end speech', player);