function plate_coeff = define_plates(plate_type)

% Author: Alex Inoma, Osezua Ibhadode
% e-mail: inoma@ualberta.ca
% Release: 1.0
% Release date: 13/01/2025

switch plate_type
    case "Box-PlateZ"
        plate_coeff = [1, 0, 0, 1;
                        1, 0, 0, -1;
                        0, 1, 0, 1;
                        0, 1, 0,-1];
    case "Cross-Plate"
        plate_coeff = [1, 0, 0, 0;
                        0, 1, 0, 0];
    case "Diamond-Plate"
        plate_coeff = [1, 1, 1, 0;
                        1, 1, -1, 0;
                        1, -1, 1, 0;
                        -1, 1, 1, 0];
    case "X-Plate"
        plate_coeff = [1, 1, 0, 0;
                        -1, 1, 0, 0];
    case "Box-PlateX"
        plate_coeff = [0, 0, 1, 1;
                        0, 0, 1, -1;
                        0, 1, 0, 1;
                        0, 1, 0,-1];
    case "Box-PlateY"
        plate_coeff = [0, 0, 1, 1;
                        0, 0, 1, -1;
                        1, 0, 0, 1;
                        1, 0, 0,-1];

    case "Octet-Plate"
        plate_coeff = [1,1,-1,0.6;
            -1,1,1,0.6;
            1,1,1,0.6;
            1,-1,1,0.6;
            1,-1,-1,0.6;
            -1,1,-1,0.6;
            -1,-1,1,0.6;
            -1,-1,-1,0.6];
end 

