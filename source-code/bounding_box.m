function [stp_xmax,stp_ymax,stp_zmax,stp_xmin,stp_ymin,stp_zmin] = bounding_box(inp)

%% Function use in lattgen
% Calls:
% a. STLread
% b. Intriangulation
%
% Called by:
% a. Implicit Model
% b. 

st = stlread(inp);

% get stl vertices
stp = st.Points;

% get bounding box
stp_xmax = max(stp(:,1)); stp_xmin = min(stp(:,1));
stp_ymax = max(stp(:,2)); stp_ymin = min(stp(:,2));
stp_zmax = max(stp(:,3)); stp_zmin = min(stp(:,3));





