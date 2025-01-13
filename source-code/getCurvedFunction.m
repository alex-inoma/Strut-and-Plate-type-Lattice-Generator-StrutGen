function f = getCurvedFunction(lattice_prop)
% tic

% Author: Alex Inoma, Osezua Ibhadode
% e-mail: inoma@ualberta.ca
% Release: 1.0
% Release date: 13/01/2025

gridpoints = lattice_prop.gridpoints;
strutType = lattice_prop.structure;
cell_len = lattice_prop.cell_len;
customStart = lattice_prop.customStart;
customEnd = lattice_prop.customEnd;
sc = (2/min(cell_len))*lattice_prop.curvecontrol;
ang_len = lattice_prop.curvepoints;

x = linspace(-1, 1, gridpoints); 
y = linspace(-1, 1, gridpoints); 
z = linspace(-1, 1, gridpoints); 
[x1,y1,z1] = meshgrid(x,y,z); 

%% Define end points of curved strut frames (p1, q1) and end points of a line orthogonal to center of arc (p2, q2)
[p,q] = define_struts(strutType,customStart,customEnd);

p1 = p(1:size(p,1)/2,:);
p2 = p((size(p,1)/2)+1:size(p,1),:);
q1 = q(1:size(q,1)/2,:);
q2 = q((size(q,1)/2)+1:size(q,1),:);

%% Obtain line segments that join p1, q1 and p2, q2
pp_1 = [p1(:,1)-q1(:,1) p1(:,2)-q1(:,2) p1(:,3)-q1(:,3)]; 
pp_2 = [p2(:,1)-q2(:,1) p2(:,2)-q2(:,2) p2(:,3)-q2(:,3)]; 

%% Obtain a line perpendicular to both lines above --> pp_1 and pp_2
pp_3 = cross(pp_1,pp_2);
pp = pp_3/norm(pp_3);

%% Obtain the mid point of line pp_1 or between p1 and q1
mid = [(p1(:,1)+q1(:,1))/2 (p1(:,2)+q1(:,2))/2 (p1(:,3)+q1(:,3))/2];

%% Obtain the center of the arc using a scale factor sc
if strcmp(lattice_prop.structure,"DCC-Curved") || strcmp(lattice_prop.structure,"Butterfly-Curved") %|| 
    cx = [mid(:,1)-sc*pp(:,1) mid(:,1)+sc*pp(:,1)]; 
    cy = [mid(:,2)-sc*pp(:,2) mid(:,2)+sc*pp(:,2)]; 
    cz = [mid(:,3)-sc*pp(:,3) mid(:,3)+sc*pp(:,3)];
elseif strcmp(lattice_prop.structure,"BCC-Curved") 
    cx = [mid(1:4,1)-sc*pp(1:4,1);mid(5:8,1)+sc*pp(5:8,1)]; 
    cy = [mid(1:4,2)-sc*pp(1:4,2);mid(5:8,2)+sc*pp(5:8,2)]; 
    cz = [mid(1:4,3)-sc*pp(1:4,3);mid(5:8,3)+sc*pp(5:8,3)];
elseif strcmp(lattice_prop.structure,"FCC-Curved")
    cx = [mid(1:4,1)-sc*pp(1:4,1);mid(5:8,1)+sc*pp(5:8,1)]; 
    cy = [mid(1:4,2)-sc*pp(1:4,2);mid(5:8,2)+sc*pp(5:8,2)]; 
    cz = [mid(1:4,3)-sc*pp(1:4,3);mid(5:8,3)+sc*pp(5:8,3)];
end

%% Obtain lines that join p1 and q1 to the center of arc
v_1 = p1(1,:) - [cx(1,1),cy(1,1),cz(1,1)];
v_2 = q1(1,:) - [cx(1,1),cy(1,1),cz(1,1)];

%% Obtain the angle (theta) between the two lines obtained in the previous step
theta = atan2(norm(cross(v_1, v_2)), dot(v_1, v_2));

if strcmp(lattice_prop.structure,"FCC-Curved") 
    theta_i = linspace(0,2*theta,ang_len);
else
    theta_i = linspace(0,theta,ang_len);
end
%% Obtain the equation of the arc defined by getting points on the arc --> center+cos(theta)*(p1-center)+sin(theta)*(q1-center)
xp1 = cx(:,1)+cos(theta_i).*(p1(:,1)-cx(:,1))+sin(theta_i).*(q1(:,1)-cx(:,1));
yp1 = cy(:,1)+cos(theta_i).*(p1(:,2)-cy(:,1))+sin(theta_i).*(q1(:,2)-cy(:,1));
zp1 = cz(:,1)+cos(theta_i).*(p1(:,3)-cz(:,1))+sin(theta_i).*(q1(:,3)-cz(:,1));

if strcmp(lattice_prop.structure,"DCC-Curved") || strcmp(lattice_prop.structure,"Butterfly-Curved") 
    xp2 = cx(:,2)+cos(theta_i).*(p1(:,1)-cx(:,2))+sin(theta_i).*(q1(:,1)-cx(:,2));
    yp2 = cy(:,2)+cos(theta_i).*(p1(:,2)-cy(:,2))+sin(theta_i).*(q1(:,2)-cy(:,2));
    zp2 = cz(:,2)+cos(theta_i).*(p1(:,3)-cz(:,2))+sin(theta_i).*(q1(:,3)-cz(:,2)); 
end
% toc
%tic
%% Obtain the shortest distance of points in the field to the arc
for i = 1:size(p1,1)
    [~,f1,~] = distance2curve([xp1(i,:)' yp1(i,:)' zp1(i,:)'],[x1(:) y1(:) z1(:)],'linear');
    % [f1] = distance2curve_v2([xp1(i,:)' yp1(i,:)' zp1(i,:)'],[x1(:) y1(:) z1(:)]);
    
    if strcmp(lattice_prop.structure,"DCC-Curved") || strcmp(lattice_prop.structure,"Butterfly-Curved") 
        [~,f2,~] = distance2curve([xp2(i,:)' yp2(i,:)' zp2(i,:)'],[x1(:) y1(:) z1(:)],'linear');
        % [f2] = distance2curve_v2([xp2(i,:)' yp2(i,:)' zp2(i,:)'],[x1(:) y1(:) z1(:)]);

        f3 = sdfFillet(f1,f2,0.1);
        f1 = f3;
    end
    if i == 1
        f = f1;
    else
        f = sdfFillet(f,f1,0.1);
    end 

end

f = reshape(f,gridpoints,gridpoints,gridpoints); %toc

if lattice_prop.union
f = hybrid(f,lattice_prop.lattice_prop2);
end

end 