function f = getStraightFunction(lattice_prop)

% Author: Alex Inoma, Osezua Ibhadode
% e-mail: inoma@ualberta.ca
% Release: 1.0
% Release date: 13/01/2025

gridpoints = lattice_prop.gridpoints;
strutType = lattice_prop.structure;
customStart = lattice_prop.customStart;
customEnd = lattice_prop.customEnd;

x = linspace(-1, 1, gridpoints); 
y = linspace(-1, 1, gridpoints); 
z = linspace(-1, 1, gridpoints); 
[x1,y1,z1] = meshgrid(x,y,z); 

%% Define end points of the struts and get line vectors
[p1,q1] = define_struts(strutType,customStart,customEnd);
pp = [p1(:,1)-q1(:,1) p1(:,2)-q1(:,2) p1(:,3)-q1(:,3)]; 

%% Obtain the projection of points in the field on the lines of the struts ==> a.unit(b)
xyz = [x1(:) y1(:) z1(:)];
for i = 1:size(p1,1)
    proj = ((xyz(:,1)-repmat(p1(i,1),[size(xyz,1),1]))*pp(i,1)...
        +(xyz(:,2)-repmat(p1(i,2),[size(xyz,1),1]))*pp(i,2)...
        +(xyz(:,3)-repmat(p1(i,3),[size(xyz,1),1]))*pp(i,3))/sqrt(sum(pp(i,:).^2));

%% Obtain the components of proj along line pp and add to p1
    comp = proj.*repmat(pp(i,:),[size(xyz,1),1])/sqrt(sum(pp(i,:).^2));
    newp = p1(i,:)+comp;

%% Obtain the Euclidean distance between field points and lines for struts
    f1 = vecnorm((xyz-newp)',2);
    chk_p1 = abs(p1(i,:)); chk_q1 = abs(q1(i,:));
    if length(chk_p1(chk_p1<1))>=1 || length(chk_q1(chk_q1<1))>=1
        lineseg = vecnorm(pp(i,:));
        chk_len1 = vecnorm((newp-repmat(p1(i,:),size(newp,1),1))',2);
        chk_len2 = vecnorm((newp-repmat(q1(i,:),size(newp,1),1))',2);
        chk = max([chk_len1' chk_len2' lineseg*ones(size(newp,1),1)],[],2);
        f1(chk>lineseg) = 2;
    else
    end 
    if i == 1
        f = f1;
    else
        %f = min(f,f1);
        f = sdfFillet(f,f1,0.1);
    end
end 
f = reshape(f,gridpoints,gridpoints,gridpoints);

if lattice_prop.union
f = hybrid(f,lattice_prop.lattice_prop2);
end
end 
