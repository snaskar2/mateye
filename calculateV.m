function vel = calculateV(pos)
% calculate velocity

Fs = 500;
[~, g] = sgolay(2,11);
fvel = -Fs * g(:,2);
vel = conv(pos, fvel, 'same');
Nf = length(fvel);
vel(1:(Nf-1)/2) = 0;
vel(end-(Nf-3)/2:end) = 0;

end

