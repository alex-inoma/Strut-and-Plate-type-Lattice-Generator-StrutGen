function [stp_xmax,stp_ymax,stp_zmax,stp_xmin,stp_ymin,stp_zmin] = bounding_box(inp)

% Author: Alex Inoma, Osezua Ibhadode
% e-mail: inoma@ualberta.ca
% Release: 1.0
% Release date: 13/01/2025

st = stlread(inp);

% get stl vertices
stp = st.Points;

% get bounding box
stp_xmax = max(stp(:,1)); stp_xmin = min(stp(:,1));
stp_ymax = max(stp(:,2)); stp_ymin = min(stp(:,2));
stp_zmax = max(stp(:,3)); stp_zmin = min(stp(:,3));





