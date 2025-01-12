function [f,xx,yy,zz] = default(app,lattice_prop)

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
    if all(period == 1)
        f = getCurvedFunction(lattice_prop);
    else
        f1 = getCurvedFunction(lattice_prop);
        px = mod(period(1),1); py = mod(period(2),1); pz = mod(period(3),1);
        f = repmat(f1,period(2)-py,period(1)-px,period(3)-pz);
        if px ~= 0
            fendx = f(:,1:round(px*size(f1,1)),:); f(:,end+1:end+round(px*size(f1,1)),:) = fendx;
        end
        if py ~= 0
            fendy = f(1:round(py*size(f1,2)),:,:); f(end+1:end+round(py*size(f1,2)),:,:) = fendy;
        end 
        if pz ~= 0
            fendz = f(:,:,1:round(pz*size(f1,3))); f(:,:,end+1:end+round(pz*size(f1,3))) = fendz;
        end
    
    end

%% Straight Strut
%--------------------------------------------------------------------------------------------------
elseif strcmp(lattice_type,'Straight Strut') %Straight Strut
    if all(period == 1)
        f = getStraightFunction(lattice_prop);
    else
        f1 = getStraightFunction(lattice_prop);
        px = mod(period(1),1); py = mod(period(2),1); pz = mod(period(3),1);
        f = repmat(f1,period(2)-py,period(1)-px,period(3)-pz);
        if px ~= 0
            fendx = f(:,1:round(px*size(f1,1)),:); f(:,end+1:end+round(px*size(f1,1)),:) = fendx;
        end
        if py ~= 0
            fendy = f(1:round(py*size(f1,2)),:,:); f(end+1:end+round(py*size(f1,2)),:,:) = fendy;
        end 
        if pz ~= 0
            fendz = f(:,:,1:round(pz*size(f1,3))); f(:,:,end+1:end+round(pz*size(f1,3))) = fendz;
        end
    end 

%% Plate
%--------------------------------------------------------------------------------------------------
elseif strcmp(lattice_type,'Plate') %Plate
    if all(period == 1)
    f = getPlateFunction(lattice_prop);
    %xx = x1; yy = y1; zz = z1;
    else
        f1 = getPlateFunction(lattice_prop);
        px = mod(period(1),1); py = mod(period(2),1); pz = mod(period(3),1);
        f = repmat(f1,period(2)-py,period(1)-px,period(3)-pz);
        if px ~= 0
            fendx = f(:,1:round(px*size(f1,1)),:); f(:,end+1:end+round(px*size(f1,1)),:) = fendx;
        end
        if py ~= 0
            fendy = f(1:round(py*size(f1,2)),:,:); f(end+1:end+round(py*size(f1,2)),:,:) = fendy;
        end 
        if pz ~= 0
            fendz = f(:,:,1:round(pz*size(f1,3))); f(:,:,end+1:end+round(pz*size(f1,3))) = fendz;
        end
    end
    if period(1) == 1
        X = linspace(-period(1)/2, period(1)/2, round(period(1)*gridpoints));
    else
        X = linspace(-period(1)/2, period(1)/2, round(period(1)*gridpoints)-period(1)+1);
        f(:,gridpoints:gridpoints:end-1,:) = [];
    end
    if period(2) == 1
        Y = linspace(-period(2)/2, period(2)/2, round(period(2)*gridpoints));
    else
        Y = linspace(-period(2)/2, period(2)/2, round(period(2)*gridpoints)-period(2)+1);
        f(gridpoints:gridpoints:end-1,:,:) = [];
    end
    if period(3) == 1
        Z = linspace(-period(3)/2, period(3)/2, round(period(3)*gridpoints));
    else
        Z = linspace(-period(3)/2, period(3)/2, round(period(3)*gridpoints)-period(3)+1);
        f(:,:,gridpoints:gridpoints:end-1) = [];
    end
else
    if all(period == 1)
        f = solidDomain(lattice_prop);
    else
        f1 = solidDomain(lattice_prop);
        px = mod(period(1),1); py = mod(period(2),1); pz = mod(period(3),1);
        f = repmat(f1,period(2)-py,period(1)-px,period(3)-pz);
        if px ~= 0
            fendx = f(:,1:round(px*size(f1,1)),:); f(:,end+1:end+round(px*size(f1,1)),:) = fendx;
        end
        if py ~= 0
            fendy = f(1:round(py*size(f1,2)),:,:); f(end+1:end+round(py*size(f1,2)),:,:) = fendy;
        end 
        if pz ~= 0
            fendz = f(:,:,1:round(pz*size(f1,3))); f(:,:,end+1:end+round(pz*size(f1,3))) = fendz;
        end
    end 
end

% X = linspace(0, period(1), round(period(1)*gridpoints));
% Y = linspace(0, period(2), round(period(2)*gridpoints));
% Z = linspace(0, period(3), round(period(3)*gridpoints));
[xx,yy,zz] = meshgrid(X,Y,Z);

end