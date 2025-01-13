function f = sdfFillet(sdf1,sdf2,k)

% Author: Alex Inoma, Osezua Ibhadode
% e-mail: inoma@ualberta.ca
% Release: 1.0
% Release date: 13/01/2025

h = max(0, 1 - abs(sdf1 - sdf2) / k);
f = min(sdf1, sdf2) - k * h.^3 / 6;
end 