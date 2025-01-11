function f = sdfFillet(sdf1,sdf2,k)
h = max(0, 1 - abs(sdf1 - sdf2) / k);
f = min(sdf1, sdf2) - k * h.^3 / 6;
end 