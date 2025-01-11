function [f,x1,y1,z1] = custom(app,lattice_prop,inp)

drawnow;
if app.stopFlag
    return
end

cell_len = lattice_prop.cell_len;

if strcmp(lattice_prop.lattice_type,'Straight Strut')
    f1 = getStraightFunction(lattice_prop);
elseif strcmp(lattice_prop.lattice_type,'Curved Strut')
    f1 = getCurvedFunction(lattice_prop);
elseif strcmp(lattice_prop.lattice_type,'Plate')
    f1 = getPlateFunction(lattice_prop);
else
    f1 = solidDomain(lattice_prop);
end
    [x_max,y_max,z_max,x_min,y_min,z_min] = bounding_box(inp);
    period = [(x_max-x_min)/cell_len(1),(y_max-y_min)/cell_len(2),(z_max-z_min)/cell_len(3)];
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


    %[out_p,~,~,~,x1,y1,z1] = strut_stlinput(inp,max(size(f))); 
    [out_p,~,~,~,x1,y1,z1] = strut_stlinput(inp,size(f,1),size(f,2),size(f,3)); 
    f(out_p == 0) = 1e10;
end