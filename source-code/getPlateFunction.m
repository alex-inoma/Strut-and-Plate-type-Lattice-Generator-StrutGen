function f = getPlateFunction(lattice_prop)

gridpoints = lattice_prop.gridpoints;
plate_type = lattice_prop.structure;

x = linspace(-1, 1, gridpoints); 
y = linspace(-1, 1, gridpoints); 
z = linspace(-1, 1, gridpoints); 
[x1,y1,z1] = meshgrid(x,y,z); 

plate_coeff = define_plates(plate_type);

% Extract plate coefficients
a = plate_coeff(:,1);
b = plate_coeff(:,2);
c = plate_coeff(:,3);
d = plate_coeff(:,4);

% Normalize the plane's normal vector to ensure accurate distances
normal_vector = [a, b, c];
normal_vector = normal_vector ./ vecnorm(normal_vector',2)';
a = normal_vector(:,1);
b = normal_vector(:,2);
c = normal_vector(:,3);

% Compute the Signed Distance Function (SDF)
% SDF = (a*x + b*y + c*z + d) / ||[a, b, c]||


for i = 1:size(plate_coeff,1)
    f1 = abs(x1(:) * a(i) + y1(:) * b(i) + z1(:) * c(i) + d(i));
    if i == 1
        f = f1;
    else
        f = min(f,f1);
    end 
end
f = reshape(f,gridpoints,gridpoints,gridpoints);

if lattice_prop.union
    f = hybrid(f,lattice_prop.lattice_prop2);
end

end 