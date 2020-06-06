function out = polyPulse(controlPoints)

out = @(t) pulseFunc(t, controlPoints);

end

function result = pulseFunc(t, controlPoints)
  result = zeros(1,length(t));
  currentPoint = 0;

  tPoints = controlPoints(:,1);
  amp =  controlPoints(:,2);
  for n=1:length(t)
    if (t(n) < tPoints(1))
        result(n) = amp(1);
    elseif (t(n) > tPoints(length(tPoints)))
        result(n) = amp(length(amp));
    else
        for k = 1:length(tPoints)-1
            if (t(n) >= tPoints(k) && t(n) <= tPoints(k+1))
                currentPoint = k;
                break;
            end
        end
        angle = (amp(currentPoint+1) - amp(currentPoint)) / (tPoints(currentPoint+1) - tPoints(currentPoint));
        result(n) = amp(currentPoint) + angle*(t(n) - tPoints(currentPoint));
    end
  end
end