function out = cugPulse(signalFunc, startDelay, pulseDuration )

out = @(t) pulseFunc(t, signalFunc, startDelay, pulseDuration);

end

function result = pulseFunc(t, signalFunc, startDelay, pulseDuration)
  result = zeros(1,length(t));
  for n=1:length(t)
    if (t(n) >= startDelay && t(n) <= startDelay+pulseDuration)
      result(n) = signalFunc(t(n));
    end
  end
end
