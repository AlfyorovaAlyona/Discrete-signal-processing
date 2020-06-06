function out = rectPulse(startDelay, pulseDuration, pulseAmp)

out = @(t) pulseFunc(t, startDelay, pulseDuration, pulseAmp);

end

function result = pulseFunc(t, startDelay, pulseDuration, pulseAmp)
  result = zeros(1,length(t));
  for n=1:length(t)
    if (t(n) >= startDelay && t(n) <= startDelay+pulseDuration)
      result(n) = pulseAmp;
    end
  end
end