function f = sdfFillet(sdf1,sdf2)

% Author: Alex Inoma, Osezua Ibhadode
% e-mail: inoma@ualberta.ca
% Release: 1.0
% Release date: 13/01/2025

k = 0.15;
h = max(0, 1 - abs(sdf1 - sdf2) / k);
f = min(sdf1, sdf2) - k * h.^3 / 6;
end 