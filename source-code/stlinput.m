function [out_p,x,y,z] = stlinput(app,inp,gridpoints)
st = stlread(inp);

% get stl vertices
stp = st.Points; stf = st.ConnectivityList;

% get bounding box
stp_xmax = max(stp(:,1)); stp_xmin = min(stp(:,1));
stp_ymax = max(stp(:,2)); stp_ymin = min(stp(:,2));
stp_zmax = max(stp(:,3)); stp_zmin = min(stp(:,3));

%generate gridpoints for x, y, and z
x = linspace(stp_xmin, stp_xmax, gridpoints); 
y = linspace(stp_ymin, stp_ymax, gridpoints); 
z = linspace(stp_zmin, stp_zmax, gridpoints);

%create meshgrid for x, y, and z
[x1,y1,z1] = meshgrid(x,y,z);

out = intriangulation(app,stp,stf,[x1(:),y1(:),z1(:)]); out(out<0) = 0;
out_p0 = reshape(out,gridpoints,gridpoints,gridpoints);
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

out_p21 = zeros(size(out_p0)); out_p21(1:gridpoints-1,:,:) = out_p0(2:gridpoints,:,:); 
out_p22 = zeros(size(out_p0)); out_p22(2:gridpoints,:,:) = out_p0(1:gridpoints-1,:,:);
out_p31 = zeros(size(out_p0)); out_p31(:,1:gridpoints-1,:) = out_p0(:,2:gridpoints,:); 
out_p32 = zeros(size(out_p0)); out_p32(:,2:gridpoints,:) = out_p0(:,1:gridpoints-1,:);
out_p41 = zeros(size(out_p0)); out_p41(:,:,1:gridpoints-1) = out_p0(:,:,2:gridpoints); 
out_p42 = zeros(size(out_p0)); out_p42(:,:,2:gridpoints) = out_p0(:,:,1:gridpoints-1);

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




