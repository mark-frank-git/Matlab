fs = 16000;
M = fs/2 + 1;
frameSize = 2048;

[B,A] = cheby2(4,20,[0.1 0.7]);
impulseResponseGenerator = dsp.IIRFilter('Numerator', [zeros(1,6) B], ...
    'Denominator', A);

FVT = fvtool(impulseResponseGenerator);  % Analyze the filter
FVT.Color = [1 1 1];

roomImpulseResponse = impulseResponseGenerator( ...
        (log(0.99*rand(1,M)+0.01).*sign(randn(1,M)).*exp(-0.002*(1:M)))');
roomImpulseResponse = roomImpulseResponse/norm(roomImpulseResponse)*4;
room = dsp.FIRFilter('Numerator', roomImpulseResponse');

fig = figure;
plot(0:1/fs:0.5, roomImpulseResponse);
xlabel('Time (s)');
ylabel('Amplitude');
title('Room Impulse Response');
fig.Color = [1 1 1];

load nearspeech

player          = audioDeviceWriter('SupportVariableSizeInput', true, ...
                                    'BufferSize', 512, 'SampleRate', fs);
nearSpeechSrc   = dsp.SignalSource('Signal',v,'SamplesPerFrame',frameSize);
nearSpeechScope = dsp.TimeScope('SampleRate', fs, ...
                    'TimeSpan', 35, 'TimeSpanOverrunAction', 'Scroll', ...
                    'YLimits', [-1.5 1.5], ...
                    'BufferLength', length(v), ...
                    'Title', 'Near-End Speech Signal', ...
                    'ShowGrid', true);

% Stream processing loop
while(~isDone(nearSpeechSrc))
    % Extract the speech samples from the input signal
    nearSpeech = nearSpeechSrc();
    % Send the speech samples to the output audio device
    player(nearSpeech);
    % Plot the signal
    nearSpeechScope(nearSpeech);
end
release(nearSpeechScope);


load farspeech
farSpeechSrc    = dsp.SignalSource('Signal',x,'SamplesPerFrame',frameSize);
farSpeechSink   = dsp.SignalSink;
farSpeechScope  = dsp.TimeScope('SampleRate', fs, ...
                    'TimeSpan', 35, 'TimeSpanOverrunAction', 'Scroll', ...
                    'YLimits', [-0.5 0.5], ...
                    'BufferLength', length(x), ...
                    'Title', 'Far-End Speech Signal', ...
                    'ShowGrid', true);

% Stream processing loop
while(~isDone(farSpeechSrc))
    % Extract the speech samples from the input signal
    farSpeech = farSpeechSrc();
    % Add the room effect to the far-end speech signal
    farSpeechEcho = room(farSpeech);
    % Send the speech samples to the output audio device
    player(farSpeechEcho);
    % Plot the signal
    farSpeechScope(farSpeech);
    % Log the signal for further processing
    farSpeechSink(farSpeechEcho);
end
release(farSpeechScope);


reset(nearSpeechSrc);
farSpeechEchoSrc = dsp.SignalSource('Signal', farSpeechSink.Buffer, ...
                    'SamplesPerFrame', frameSize);
micSink         = dsp.SignalSink;
micScope        = dsp.TimeScope('SampleRate', fs,...
                    'TimeSpan', 35, 'TimeSpanOverrunAction', 'Scroll',...
                    'YLimits', [-1 1], ...
                    'BufferLength', length(x), ...
                    'Title', 'Microphone Signal', ...
                    'ShowGrid', true);

% Stream processing loop
while(~isDone(farSpeechEchoSrc))
    % Microphone signal = echoed far-end + near-end + noise
    micSignal = farSpeechEchoSrc() + nearSpeechSrc() + ...
                0.001*randn(frameSize,1);
    % Send the speech samples to the output audio device
    player(micSignal);
    % Plot the signal
    micScope(micSignal);
    % Log the signal
    micSink(micSignal);
end
release(micScope);

