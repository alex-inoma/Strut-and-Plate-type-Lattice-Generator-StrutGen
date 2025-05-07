clc; clear; close all;

%% 1. Load STL file
% [filename, pathname] = uigetfile('*.stl', 'Select an STL file');
% if filename == 0
%     error('No STL file selected.');
% end
% stlPath = fullfile(pathname, filename);
stp = stlread('3DBenchy.stl'); faces = stp.ConnectivityList; vertices = stp.Points;

% Plot original mesh
figure;
patch('Faces',faces,'Vertices',vertices,'FaceColor',[0.8 0.8 1.0],'EdgeColor','none');
camlight; lighting gouraud; axis equal; title('Imported STL Mesh');

%% 2. Bounding Box and Random Points
N = 2000; % number of seed points
padding = 0.05;

min_bound = min(vertices) - padding;
max_bound = max(vertices) + padding;
[px, py, pz] = ndgrid(...
    linspace(min_bound(1), max_bound(1), round(N^(1/3))), ...
    linspace(min_bound(2), max_bound(2), round(N^(1/3))), ...
    linspace(min_bound(3), max_bound(3), round(N^(1/3))) ...
    );
points = [px(:), py(:), pz(:)];

%% 3. Filter points inside mesh using `inpolyhedron`
inside = inpolyhedron(faces, vertices, points);
seeds = points(inside,:);

%% 4. Compute 3D Voronoi Diagram
[~, c] = voronoin(seeds);

% Collect struts (edges between adjacent cells)
edges = [];
for i = 1:length(c)
    ci = c{i};
    if all(ci > 0) && length(ci) > 1
        for j = 1:length(ci)
            for k = j+1:length(ci)
                edges(end+1,:) = [ci(j), ci(k)];
            end
        end
    end
end

% Remove duplicates
edges = unique(sort(edges,2),'rows');
strut_pts = [];
for i = 1:size(edges,1)
    try
        id1 = edges(i,1);
        id2 = edges(i,2);
        p1 = c{id1};
        p2 = c{id2};

        % Ensure both are 1×3 vectors
        if isvector(p1) && isvector(p2) && numel(p1) == 3 && numel(p2) == 3
            strut_pts(end+1,:) = [p1(:)', p2(:)'];
        end
    catch
        % Skip bad cells or malformed points
        continue;
    end
end

%% 5. Define Grid for Implicit Representation
res = 400;
[xg, yg, zg] = meshgrid(...
    linspace(min_bound(1), max_bound(1), res), ...
    linspace(min_bound(2), max_bound(2), res), ...
    linspace(min_bound(3), max_bound(3), res));
F = zeros(size(xg)) + Inf;
r = 0.5 * norm(max_bound - min_bound)/res; % strut radius

%% 6. Compute Implicit Field (Union of Cylindrical Fields)
fprintf("Generating implicit model...\n");
for i = 1:size(strut_pts,1)
    p1 = strut_pts(i,1:3);
    p2 = strut_pts(i,4:6);
    v = p2 - p1;
    vnorm = norm(v);
    if vnorm < 1e-6, continue; end
    v = v / vnorm;

    % Vectorized distance to line segment
    APx = xg - p1(1); APy = yg - p1(2); APz = zg - p1(3);
    t = APx*v(1) + APy*v(2) + APz*v(3);
    t = min(max(t, 0), vnorm);
    closestX = p1(1) + t*v(1);
    closestY = p1(2) + t*v(2);
    closestZ = p1(3) + t*v(3);

    dist = sqrt((xg - closestX).^2 + (yg - closestY).^2 + (zg - closestZ).^2);
    F = min(F, dist - r);
end

%% 7. Visualize Implicit Surface
figure;
p = patch(isosurface(xg, yg, zg, F, 0));
isonormals(xg, yg, zg, F, p);
p.FaceColor = [0.2 0.6 1.0]; p.EdgeColor = 'none';
camlight; lighting gouraud; axis equal; view(3);
title('Implicit Voronoi Lattice Structure');
