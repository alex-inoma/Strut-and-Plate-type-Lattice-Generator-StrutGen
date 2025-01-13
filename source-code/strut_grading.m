function [isovalue,isovalue_ext,isovalue_int] = strut_grading(app,equation_type,m1,m2,m3,m4,radius,thickness,thickness2,cell_len,xx,yy,zz,posX,posY,posZ,Inner,Outer,Inner2,Outer2)

% Author: Alex Inoma, Osezua Ibhadode
% e-mail: inoma@ualberta.ca
% Release: 1.0
% Release date: 13/01/2025

drawnow;
if app.stopFlag
    return
end
%positionX = dim(1)/2; positionY = dim(2)/2; positionZ = dim(3)/2; %reference position 
%positionX = dim(1); positionY = dim(2); positionZ = dim(3); %reference position 
positionX = posX; positionY = posY; positionZ = posZ; %reference position 
rr = radius;
       
    xx = xx-positionX/cell_len(1); yy = yy-positionY/cell_len(2); zz = zz-positionZ/cell_len(3);     %define the reference frame
    xyz_max = max([max(xx(:)) max(yy(:)) max(zz(:))]);                          %obtain the maximum dimension
    xx = xx/xyz_max; yy = yy/xyz_max; zz = zz/xyz_max;  %xx1,yy1,zz1            %normalize with the maximum dimension
    
    if strcmp(equation_type,'Linear')                                           %for linear grading
        is_f = abs(m1*xx+m2*yy+m3*zz+m4);
    elseif strcmp(equation_type,'Quadratic')                                    %quadratic grading
        is_f = abs(m1*xx.^2+m2*yy.^2+m3*zz.^2+m4);
    elseif strcmp(equation_type,'Cubic')                                        %cubic grading
        is_f = abs(m1*xx.^3+m2*yy.^3+m3*zz.^3+m4);
    elseif strcmp(equation_type,'Circular')                                     %for circular grading patterns
        rr = rr/max(max([cell_len(1) cell_len(2) cell_len(3)]).*xyz_max);
        is_f = abs(sqrt(m1.*xx.^2+m2.*yy.^2+m3.*zz.^2)-rr);
    elseif strcmp(equation_type,'Exponential')
        is_f = abs(exp(m1*xx)+exp(m2*yy)+exp(m3*zz));
    elseif strcmp(equation_type, 'Trigonometric - Sin')
        is_f = sin(m1*xx)+sin(m2*yy)+sin(m3*zz)+1;
    elseif strcmp(equation_type, 'Trigonometric - Cosine')
        is_f = cos(m1*xx)+cos(m2*yy)+cos(m3*zz)+1;  
    end

    is_f = is_f/max(abs(is_f(:)));
    isovalue = (thickness+is_f*(thickness2-thickness))/2;                       %interpolation function to obtain new and unique isovalues
   
    %% Hollow
    isovalue_ext = (Outer+is_f*(Outer2-Outer))/2;                           
    isovalue_int = (Inner+is_f*(Inner2-Inner))/2;
    