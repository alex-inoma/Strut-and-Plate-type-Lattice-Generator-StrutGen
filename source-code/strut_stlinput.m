function [out_p,x,y,z,x1,y1,z1] = strut_stlinput(inp,gridpoint1, gridpoint2,gridpoint3)

%% Function use in lattgen
% Calls:
% a. STLread
% b. Intriangulation
%
% Called by:
% a. Implicit Model
% b. 

st = stlread(inp); %div = round(gridpoints/10);

% get stl vertices
stp = st.Points; stf = st.ConnectivityList;

% get bounding box
stp_xmax = max(stp(:,1)); stp_xmin = min(stp(:,1));
stp_ymax = max(stp(:,2)); stp_ymin = min(stp(:,2));
stp_zmax = max(stp(:,3)); stp_zmin = min(stp(:,3));

dx = stp_xmax-stp_xmin;
dy = stp_ymax-stp_ymin;
dz = stp_zmax-stp_zmin;
%gd = floor(([dx dy dz]/max([dx dy dz]))*gridpoints);

gd(2) = gridpoint1;
gd(1) = gridpoint2;
gd(3) = gridpoint3;
%generate gridpoints for x, y, and z
x = linspace(stp_xmin, stp_xmax, gd(1)); 
y = linspace(stp_ymin, stp_ymax, gd(2)); 
z = linspace(stp_zmin, stp_zmax, gd(3));
out = inpolyhedron(stf,stp,x,y,z);
%create meshgrid for x, y, and z
% [x1,y1,z1] = meshgrid(x,y,z);

% gd2 = round(gd/10);
% x1 = imresize3(x1,[gd2(2),gd2(1),gd2(3)]);
% y1 = imresize3(y1,[gd2(2),gd2(1),gd2(3)]);
% z1 = imresize3(z1,[gd2(2),gd2(1),gd2(3)]);
% x2 = x1(:); y2 = y1(:); z2 = z1(:);
% out = zeros(size(x2)); sz = length(x2);
% for i = 1:div
%     x3 = x2(round(((i-1)/div)*sz)+1:round((i/div)*sz));
%     y3 = y2(round(((i-1)/div)*sz)+1:round((i/div)*sz));
%     z3 = z2(round(((i-1)/div)*sz)+1:round((i/div)*sz));
%     out(round(((i-1)/div)*sz)+1:round((i/div)*sz)) = intriangulation(stp,stf,[x3,y3,z3]); out(out<0) = 0;
% end
%out_p = reshape(out,gridpoints,gridpoints,gridpoints);
out_p0 = reshape(out,gd(2),gd(1),gd(3));
% out_p1 = out_p0(2:gridpoints-1,2:gridpoints-1,2:gridpoints-1);
% out_p2_1 = out_p0(1:gridpoints-2,2:gridpoints-1,2:gridpoints-1); out_p2_2 = out_p0(3:gridpoints,2:gridpoints-1,2:gridpoints-1);
% out_p3_1 = out_p0(2:gridpoints-1,1:gridpoints-2,2:gridpoints-1); out_p3_2 = out_p0(2:gridpoints-1,3:gridpoints,2:gridpoints-1);
% out_p4_1 = out_p0(2:gridpoints-1,2:gridpoints-1,1:gridpoints-2); out_p4_2 = out_p0(2:gridpoints-1,2:gridpoints-1,3:gridpoints);
% 
% out_p5 = (out_p1+out_p2_1+out_p2_2+out_p3_1+out_p3_2+out_p4_1+out_p4_2)/7;
% out_p6 = zeros(size(out_p0));
% out_p6(1,:,:) = out_p0(1,:,:)+out_p0(2,:,:); out_p6(end,:,:) = out_p0(end,:,:)+out_p0(end-1,:,:);
% out_p6(:,1,:) = out_p0(:,1,:)+out_p0(:,2,:); out_p6(:,end,:) = out_p0(:,end,:)+out_p0(:,end-1,:);
% out_p6(:,:,1) = out_p0(:,:,1)+out_p0(:,:,2); out_p6(:,:,end) = out_p0(:,:,end)+out_p0(:,:,end-1);
% out_p6 = out_p6/2;
% out_p6(2:gridpoints-1,2:gridpoints-1,2:gridpoints-1) = out_p5;
out_p21 = zeros(size(out_p0)); out_p21(1:gd(2)-1,:,:) = out_p0(2:gd(2),:,:); 
out_p22 = zeros(size(out_p0)); out_p22(2:gd(2),:,:) = out_p0(1:gd(2)-1,:,:);
out_p31 = zeros(size(out_p0)); out_p31(:,1:gd(1)-1,:) = out_p0(:,2:gd(1),:); 
out_p32 = zeros(size(out_p0)); out_p32(:,2:gd(1),:) = out_p0(:,1:gd(1)-1,:);
out_p41 = zeros(size(out_p0)); out_p41(:,:,1:gd(3)-1) = out_p0(:,:,2:gd(3)); 
out_p42 = zeros(size(out_p0)); out_p42(:,:,2:gd(3)) = out_p0(:,:,1:gd(3)-1);
out_p5 = (out_p0+out_p21+out_p22+out_p31+out_p32+out_p41+out_p42)/7;
out_p5(:,1,1) = (out_p5(:,2,1)+out_p5(:,1,2))/2;
out_p5(:,end,1) = (out_p5(:,end-1,1)+out_p5(:,end,2))/2;
out_p5(:,1,end) = (out_p5(:,1,end-1)+out_p5(:,2,end))/2;
out_p5(:,end,end) = (out_p5(:,end-1,end)+out_p5(:,end,end-1))/2;
out_p5(1,:,1) = (out_p5(2,:,1)+out_p5(1,:,2))/2;
out_p5(end,:,1) = (out_p5(end-1,:,1)+out_p5(end,:,2))/2;
out_p5(1,:,end) = (out_p5(1,:,end-1)+out_p5(2,:,end))/2;
out_p5(end,:,end) = (out_p5(end-1,:,end)+out_p5(end,:,end-1))/2;
out_p5(1,1,:) = (out_p5(2,1,:)+out_p5(1,2,:))/2;
out_p5(end,1,:) = (out_p5(end-1,1,:)+out_p5(end,2,:))/2;
out_p5(1,end,:) = (out_p5(1,end-1,:)+out_p5(2,end,:))/2;
out_p5(end,end,:) = (out_p5(end-1,end,:)+out_p5(end,end-1,:))/2;
out_p = out_p5; out_p(out_p>0) = 1;
%out_p = imresize3(out_p,[gd(2),gd(1),gd(3)]);
[x1,y1,z1] = meshgrid(x,y,z);



