function [f1,xx,yy,zz] = homoDefault(app,lattice_prop)

% Author: Alex Inoma, Osezua Ibhadode
% e-mail: inoma@ualberta.ca
% Release: 1.0
% Release date: 13/01/2025

drawnow;
if app.stopFlag
    return
end

dim = lattice_prop.dim;
cell_len = lattice_prop.cell_len;
gridpoints = lattice_prop.gridpoints;
lattice_type = lattice_prop.lattice_type;

period = [dim(1)/cell_len(1),dim(2)/cell_len(2),dim(3)/cell_len(3)];
X = linspace(0, period(1), round(period(1)*gridpoints));
Y = linspace(0, period(2), round(period(2)*gridpoints));
Z = linspace(0, period(3), round(period(3)*gridpoints));

%% Curved Strut
%--------------------------------------------------------------------------------------------------
if strcmp(lattice_type,'Curved Strut') %Curved Strut    
        f1 = getCurvedFunction(lattice_prop); 

%% Straight Strut
%--------------------------------------------------------------------------------------------------
elseif strcmp(lattice_type,'Straight Strut') %Straight Strut
    f1 = getStraightFunction(lattice_prop); 

%% Plate
%--------------------------------------------------------------------------------------------------
elseif strcmp(lattice_type,'Plate') %Plate
    f1 = getPlateFunction(lattice_prop);

else
    f1 = solidDomain(lattice_prop);
end
[xx,yy,zz] = meshgrid(X,Y,Z);

end