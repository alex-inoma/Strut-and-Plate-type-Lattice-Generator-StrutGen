function [f,xx,yy,zz] = GenerateStructure(app,dimX,dimY,dimZ,cellX,cellY,cellZ,grid,topology,topology2,curve,curve_control,curve_control_2,startpoints,endpoints,thickness,thickness2, ...
    hybrid,hollow,Outer,Inner,Outer2,Inner2,importedMesh,fileName,CompressiveSample,height,DensityType,GradingEquation,radius,coefficientA,coefficientB,coefficientC,coefficientD,refPosX,refPosY,refPosZ)

% Author: Alex Inoma, Osezua Ibhadode
% e-mail: inoma@ualberta.ca
% Release: 1.0
% Release date: 13/01/2025

   %% Initializing Parameters and Geometry
                

                lattice_prop.dim = [dimX,dimY,dimZ]; 
                lattice_prop.cell_len = [cellX,cellY,cellZ];
                lattice_prop.gridpoints = grid;
                lattice_prop.structure = topology;
                lattice_prop.curvepoints = curve;           %Controls the accuracy of the curvature approximation
                lattice_prop.curvecontrol = curve_control;  %Controls the angle of curvature
                lattice_prop.customStart = startpoints;     %custom
                lattice_prop.customEnd = endpoints;         %custom
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
                %Hybridizing cells
                lattice_prop.lattice_prop2.lattice_type = lattice_type2;
                lattice_prop.lattice_prop2.union = lattice_prop.union;
                lattice_prop.lattice_prop2.structure = structure2;
                lattice_prop.lattice_prop2.cell_len = lattice_prop.cell_len;
                lattice_prop.lattice_prop2.gridpoints = lattice_prop.gridpoints;
                lattice_prop.lattice_prop2.customStart = startpoints;           %custom
                lattice_prop.lattice_prop2.customEnd = endpoints;               %custom
                lattice_prop.lattice_prop2.curvecontrol = curve_control_2;
                lattice_prop.lattice_prop2.curvepoints = curve;
                lattice_prop.i = 0;
                lattice_prop.lattice_prop2.union = false;
                lattice_prop.lattice_prop2.i = 0;
                
                %% Custom Domain
                if strcmpi(importedMesh,"Yes")

                drawnow;
                if app.stopFlag == 0
                    if contains(fileName,'.stl') || contains(fileName,'.STL')
                    inp = fileName;
                    else
                    inp= strcat(fileName, '.stl');
                    end
                    [f,xx,yy,zz] = custom(app,lattice_prop,inp);
                end
                
                else

                %% Default Domain
                drawnow;
                if app.stopFlag == 0
                    [f,xx,yy,zz] = default(app,lattice_prop);
                end
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
                if app.stopFlag == 0
                    if strcmpi(lattice_prop.lattice_type,'Solid') && strcmpi(imported_mesh,'Yes')
                        isovalue = 1;
                    elseif strcmpi(lattice_prop.lattice_type,'Solid') 
                        isovalue = 2*f;
                    end
                end
                if strcmp(hollow,"Hollow") 
                    f = (f-isovalue_ext).*-(f-isovalue_int);
                else
                    f = isovalue-f;
                end
                if strcmpi(CompressiveSample,"Yes") % Sandwich Structure
                    f1 = ones([size(f,1),size(f,2),grid]); %Establish the solid sections
                    f2 = f1;
                    fstartz = f(:,:,1:round(size(f,3))); f1(:,:,end+1:end+round(size(f,3))) = fstartz; %Bottom layer
                    fendz = f2(:,:,1:round(size(f2,3))); f1(:,:,end+1:end+round(size(f2,3))) = fendz;  %Top layer
                    f = f1;
    
                    %% 3D Grid for sandwich structure
                    X = linspace(0, dimX/cellX, size(f,2));
                    Y = linspace(0, dimY/cellY, size(f,1));
                    Z1 = linspace(0,height/cellZ,round(grid)); % Plate 1
                    Z2 = linspace(height/cellZ, (dimZ+height)/(cellZ), (size(f,3)-(2*round(grid)))); % Lattice (enforcing conditions for plate-type)
                    Z3 = linspace(((dimZ+height)/cellZ),(dimZ+(2*height))/cellZ,round(grid)); % Plate 2
                    Z = [Z1 Z2 Z3];
                    [xx,yy,zz] = meshgrid(X,Y,Z);
                end
                
              
end