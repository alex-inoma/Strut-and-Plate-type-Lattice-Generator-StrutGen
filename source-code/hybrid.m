function f = hybrid(f,lattice_prop)

% Author: Alex Inoma, Osezua Ibhadode
% e-mail: inoma@ualberta.ca
% Release: 1.0
% Release date: 13/01/2025

    if lattice_prop.i == 0
        lattice_prop.i = lattice_prop.i+1;
        
        if strcmp(lattice_prop.lattice_type,"Straight Strut")
            f2 = getStraightFunction(lattice_prop); 
        elseif strcmp(lattice_prop.lattice_type,"Curved Strut")
            f2 = getCurvedFunction(lattice_prop);
        elseif strcmp(lattice_prop.lattice_type,"Plate")
            f2 = getPlateFunction(lattice_prop);
        end
        
        f = sdfFillet(f,f2,0.2);
    end

end

