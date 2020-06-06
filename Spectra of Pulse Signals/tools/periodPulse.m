function out = periodPulse(pulseFunc, pulsePeriod)

out = @(t) periodFunc(t, pulseFunc, pulsePeriod);

end

function result = periodFunc(t, pulseFunc, pulsePeriod)
  result = zeros(1,length(t));
  for n=1:length(t)
    shiftedT = mod(t(n),pulsePeriod);
    result(n) = pulseFunc(shiftedT);
  end
end