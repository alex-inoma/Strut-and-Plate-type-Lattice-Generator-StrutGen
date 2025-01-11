function dcc_imp_func(dim,cell_len,gridpoints,thickness,curve_control,ang_len,hybrid_prop,graded_prop)

%Example 1: dcc_imp_func([20 20 20],[20 20 20],50,2,1.5,20,[],[])
%Example 2: dcc_imp_func([20 20 20],[10 10 10],50,2,1.5,20,[],[])
tic

%name of imported file 
imported_mesh = 'Yes'; inp = 'Stanford_Bunny.stl';

%period = [dim(1)/cell_len(1),dim(2)/cell_len(2),dim(3)/cell_len(3)];
isovalue = (2/min(cell_len))*thickness/2; sc = (2/min(cell_len))*curve_control;
x = linspace(-1, 1, gridpoints); 
y = linspace(-1, 1, gridpoints); 
z = linspace(-1, 1, gridpoints); 
[x1,y1,z1] = meshgrid(x,y,z); 

%% Hybridization

hybrid = hybrid_prop.hybrid;

if strcmp(hybrid,'Yes')
    equation_type = hybrid_prop.equation_type;
    m1 = hybrid_prop.coeff(1); m2 = hybrid_prop.coeff(2); m3 = hybrid_prop.coeff(3);
    lattice2 = hybrid_prop.lattice2;
    strut_type = 'curved';
    [f,xx,yy,zz] = strut_hybrid(equation_type,m1,m2,m3,'curved','DCC',lattice2,dim,cell_len,x1,y1,z1,gridpoints,ang_len,sc);

else
if strcmp(imported_mesh,'No')       
    period = [dim(1)/cell_len(1),dim(2)/cell_len(2),dim(3)/cell_len(3)];
    
    if all(period == 1)
        f = getCurvedFunction(x1,y1,z1,gridpoints,ang_len,sc,'DCC');
        xx = x1; yy = y1; zz = z1;
    else
        f1 = getCurvedFunction(x1,y1,z1,gridpoints,ang_len,sc,'DCC');
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
        X = linspace(0, period(1), round(period(1)*gridpoints));
        Y = linspace(0, period(2), round(period(2)*gridpoints));
        Z = linspace(0, period(3), round(period(3)*gridpoints));
        [X1,Y1,Z1] = meshgrid(X,Y,Z);
        xx = X1; yy = Y1; zz = Z1;
    end 
elseif strcmp(imported_mesh,'Yes')
    f1 = getCurvedFunction(x1,y1,z1,gridpoints,ang_len,sc,'DCC');
    [f,x1,y1,z1,stp,out_p] = custom(f1,inp,cell_len);
    tic
    xx = x1; yy = y1; zz = z1;
else
    
end
    toc
end
%% Grading
% fnx = load('fnx1.mat').fnx; fnx = (fnx/max(fnx(:)))*dim(1); 
% fny = load('fny1.mat').fny; fny = (fny/max(fny(:)))*dim(2);
% fnz = load('fnz1.mat').fnz; fnz = (fnz/max(fnz(:)))*dim(3); xg = load('xg1.mat').xg;
% isf = interp3(fnx,fny,fnz,xg,xx,yy,zz,'linear');
% isovalue = 0.1+isf*(0.4-0.1); 
% tic
grading = graded_prop.grade;

if strcmp(grading,'Yes') && strcmp(imported_mesh,'No')
    equation_type = graded_prop.equation_type;
    m1 = graded_prop.coeff(1); m2 = graded_prop.coeff(2); m3 = graded_prop.coeff(3);
    thickness2 = thickness + graded_prop.thickness_diff;
    
    [isovalue] = strut_grading(equation_type,m1,m2,m3,thickness,thickness2,dim,cell_len,xx,yy,zz);   

elseif strcmp(grading,'Yes')
    print("Please turn off arbitrary domain")
else
end
%% Testing Union
% union = false;
% if union
%     [f1] = bcc_imp_func_2([20 20 20],[20 20 20],50,2);
%     f(:,end+1:end+round(size(f1,2)),:) = f1(:,1:round(size(f1,2)),:);
%     X = linspace(0, dim(2)*2/cell_len(2), round(dim(2)*2/cell_len(2)*gridpoints));
%     cell_len(2) = cell_len(2)/2;
%     [X1,Y1,Z1] = meshgrid(X,y,z);
%     xx = X1; yy = Y1; zz = Z1;
% end
tic

% h = isovalue-f;
% [face1, vertex1] = isosurface(xx,yy,zz,h,0); 
% [face2, vertex2] = isocaps(xx,yy,zz,h,0);
% F = [face1; length(vertex1(:,1)) + face2]; %concatenates the face arrays which represent the faces of the resulting solid
% V = [vertex1; vertex2]; V = [V(:,1)*cell_len(1) V(:,2)*cell_len(2) V(:,3)*cell_len(3)]; 
% toc
% % toc
% tic
% figure
% trisurf(F,V(:,1),V(:,2),V(:,3), 'Facecolor', '[1, 0.341, 0.200]','Edgecolor','none')
% axis off; lighting('flat'); light('position',[0 -1 0]); camlight('headlight'); 
% axis equal; grid on
% toc

X_flat = stp(1,:);
Y_flat = stp(2,:);
Z_flat = stp(3,:);

% Plot the grid points
figure;
plot3(X_flat, Y_flat, Z_flat, 'ro');

end 



