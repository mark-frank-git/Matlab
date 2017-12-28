function process_speech(fs, frameSize, speechSignal, title, player)
% **********************************************************************
% function process_speech(fs, frameSize, speechSignal, title, player)
%
% Plays and time domain displays input speech signal
%
% Description:
% -----------
% Speech signal processor
%
% Input variables:
% -----------------------
% fs           = sample rate in Hz
% frameSize    = size in samples
% speechSignal = speech signal to be processed
% title        = speech signal title
% player       = audio player
%
% Output variables:
% -----------------------
% None
%
% Revision History
% ----------------
%  - Dec. 15, 2017 - Started
% *************************************************************************
speechSrc   = dsp.SignalSource('Signal',speechSignal,'SamplesPerFrame',frameSize);
speechScope = dsp.TimeScope('SampleRate', fs, ...
                    'TimeSpan', 35, 'TimeSpanOverrunAction', 'Scroll', ...
                    'YLimits', [-1.5 1.5], ...
                    'BufferLength', length(speechSignal), ...
                    'Title', title, ...
                    'ShowGrid', true);

% Stream processing loop
while(~isDone(speechSrc))
    % Extract the speech samples from the input signal
    speech = speechSrc();
    % Send the speech samples to the output audio device
    player(speech);
    % Plot the signal
    speechScope(speech);
end
release(speechScope);