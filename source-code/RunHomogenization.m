function [x,y,z,c] = RunHomogenization(app,cellX,cellY,cellZ,grid,topology,topology2,E,NU,curve,curve_control,curve_control_2,startpoints,endpoints,thickness,thickness2, ...
    hybrid,hollow,Outer,Inner,Outer2,Inner2,DensityType,GradingEquation,radius,coefficientA,coefficientB,coefficientC,coefficientD,refPosX,refPosY,refPosZ)

% Author: Alex Inoma, Osezua Ibhadode
% e-mail: inoma@ualberta.ca
% Release: 1.0
% Release date: 13/01/2025

%% Initializing Parameters and Geometry
                
                lattice_prop.dim = [cellX,cellY,cellZ];
                lattice_prop.cell_len = [cellX,cellY,cellZ];
                lattice_prop.gridpoints = grid;
                lattice_prop.structure = topology;
                lattice_prop.curvepoints = curve;
                lattice_prop.curvecontrol = curve_control;
                lattice_prop.customStart = startpoints; %custom
                lattice_prop.customEnd = endpoints; %custom
                if strcmp(hollow,"Hollow")
                    isovalue_ext = (2/min(lattice_prop.cell_len))*Outer/2; isovalue_int = (2/min(lattice_prop.cell_len))*(Inner)/2;
                else
                    isovalue = (2/min(lattice_prop.cell_len))*thickness/2;
                end
                if contains(topology,"Curved")
                    lattice_prop.lattice_type = 'Curved Strut';
                elseif contains(topology,"Plate") 
                    lattice_prop.lattice_type = "Plate";
                else
                    lattice_prop.lattice_type = 'Straight Strut';
                end


                %% Cell Union
                if strcmp(hybrid,"Combined")
                    lattice_prop.union = true; 
                elseif strcmp(hybrid,"Single")
                    lattice_prop.union = false;
                end
                
                structure2 = topology2;
                if contains(topology2,"Curved")
                    lattice_type2 = 'Curved Strut';
                elseif contains(topology2,"Plate")
                    lattice_type2 = "Plate";
                else
                    lattice_type2 = 'Straight Strut';
                end
                
                lattice_prop.lattice_prop2.lattice_type = lattice_type2;
                lattice_prop.lattice_prop2.union = lattice_prop.union;
                lattice_prop.lattice_prop2.structure = structure2;
                lattice_prop.lattice_prop2.cell_len = lattice_prop.cell_len;
                lattice_prop.lattice_prop2.gridpoints = lattice_prop.gridpoints;
                lattice_prop.lattice_prop2.customStart = startpoints; %custom
                lattice_prop.lattice_prop2.customEnd = endpoints; %custom
                lattice_prop.lattice_prop2.curvecontrol = curve_control_2;
                lattice_prop.lattice_prop2.curvepoints = curve;
                lattice_prop.i = 0;
                lattice_prop.lattice_prop2.union = false;
                lattice_prop.lattice_prop2.i = 0;
                
                %% Custom Domain
                

                %% Default Domain
                drawnow;
                if app.stopFlag == 0
                    [ff,xx,yy,zz] = homoDefault(app,lattice_prop);
                end

                %% Grading

                drawnow;
                if app.stopFlag == 0
                    if strcmp(DensityType,"Graded")
                        equation_type = GradingEquation; 
                        m1 = coefficientA; m2 = coefficientB; m3 = coefficientC; m4 = coefficientD;
                        posX = refPosX; posY = refPosY; posZ = refPosZ; 
                        [isovalue,isovalue_ext,isovalue_int] = strut_grading(app,equation_type,m1,m2,m3,m4,radius,thickness,thickness2,lattice_prop.cell_len,xx,yy,zz,posX,posY,posZ,Inner,Outer,Inner2,Outer2);
                        isovalue = (2/min(lattice_prop.cell_len))*isovalue;
                        isovalue_ext = (2/min(lattice_prop.cell_len))*isovalue_ext;
                        isovalue_int = (2/min(lattice_prop.cell_len))*isovalue_int;
                    end
                end

                %% Generate Iso-surfaces
                drawnow;
                if strcmp(hollow,"Hollow") 
                    ff = (ff-isovalue_ext).*-(ff-isovalue_int);
                    ff(ff>0) = 1; ff(ff~=1) = 0;
                else
                    ff = isovalue-ff; ff(ff>0) = 1; ff(ff~=1) = 0;
                end

                
lx = cellX; ly = cellY; lz = cellZ; voxel = ff;
lambda = (E*NU)/((1+NU)*(1-2*NU)); mu = E/(2*(1+NU)); % Lame's parameters
CH = homo3D(lx,ly,lz,lambda,mu,voxel);
[x,y,z,c] = visual(CH);              
end