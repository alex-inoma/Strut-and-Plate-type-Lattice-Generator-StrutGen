classdef StrutGen < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                     matlab.ui.Figure
        TabGroup                     matlab.ui.container.TabGroup
        StrutGeneratorTab            matlab.ui.container.Tab
        SummaryLabel                 matlab.ui.control.Label
        Panel_13                     matlab.ui.container.Panel
        exactRelativeDensity         matlab.ui.control.EditField
        ExactRelativeDensityLabel_7  matlab.ui.control.Label
        Runtime                      matlab.ui.control.EditField
        ExactRelativeDensityLabel_6  matlab.ui.control.Label
        Nodes                        matlab.ui.control.EditField
        ExactRelativeDensityLabel_5  matlab.ui.control.Label
        LatticeVolume                matlab.ui.control.EditField
        ExactRelativeDensityLabel_4  matlab.ui.control.Label
        Panel_12                     matlab.ui.container.Panel
        ResolutionControlLabel       matlab.ui.control.Label
        Curvepoints                  matlab.ui.control.Spinner
        CurvepointsLabel             matlab.ui.control.Label
        Gridpoints                   matlab.ui.control.Spinner
        NumberofGridpointsSpinnerLabel_4  matlab.ui.control.Label
        Panel_3                      matlab.ui.container.Panel
        SaveCustom                   matlab.ui.control.Button
        OuterDiameter2               matlab.ui.control.Spinner
        InnerDiameter2               matlab.ui.control.Spinner
        ThicknessLabel_6             matlab.ui.control.Label
        OuterDiameter                matlab.ui.control.Spinner
        InnerDiameter                matlab.ui.control.Spinner
        ThicknessLabel_5             matlab.ui.control.Label
        DensityControl               matlab.ui.control.Switch
        coefficientD_grade           matlab.ui.control.Spinner
        ZLabel_19                    matlab.ui.control.Label
        DensityType                  matlab.ui.control.Switch
        positionZ_grade              matlab.ui.control.Spinner
        ZLabel_18                    matlab.ui.control.Label
        positionY_grade              matlab.ui.control.Spinner
        YLabel_16                    matlab.ui.control.Label
        positionX_grade              matlab.ui.control.Spinner
        ALabel_6                     matlab.ui.control.Label
        coefficientC_grade           matlab.ui.control.Spinner
        ZLabel_17                    matlab.ui.control.Label
        coefficientB_grade           matlab.ui.control.Spinner
        YLabel_15                    matlab.ui.control.Label
        coefficientA_grade           matlab.ui.control.Spinner
        ALabel_5                     matlab.ui.control.Label
        relativeDensity_grade_2      matlab.ui.control.Spinner
        RelativeDensity2Label        matlab.ui.control.Label
        thickness_grade_2            matlab.ui.control.Spinner
        ThicknessLabel_4             matlab.ui.control.Label
        ThicknessLabel_3             matlab.ui.control.Label
        curve_control                matlab.ui.control.Spinner
        RelativePosition_grade       matlab.ui.control.Label
        CoefficientLabel             matlab.ui.control.Label
        GradingFormula               matlab.ui.control.EditField
        GradingEquation              matlab.ui.control.DropDown
        EquationLabel                matlab.ui.control.Label
        Stop                         matlab.ui.control.StateButton
        LampLabel                    matlab.ui.control.Label
        Lamp                         matlab.ui.control.Lamp
        ExportSTL                    matlab.ui.control.Button
        Plot                         matlab.ui.control.StateButton
        relativeDensity              matlab.ui.control.Spinner
        CellRelativeDensityLabel     matlab.ui.control.Label
        thickness                    matlab.ui.control.Spinner
        ThicknessLabel               matlab.ui.control.Label
        DensityControlLabel          matlab.ui.control.Label
        Panel_2                      matlab.ui.container.Panel
        CustomBrowseButton           matlab.ui.control.StateButton
        ImportCustomCell             matlab.ui.control.EditField
        Hollow                       matlab.ui.control.Switch
        RemoveStrut                  matlab.ui.control.StateButton
        NumberOfStruts               matlab.ui.control.EditField
        Topology2                    matlab.ui.control.DropDown
        CellTopology2Label           matlab.ui.control.Label
        HybridStructure              matlab.ui.control.Switch
        AddStrut                     matlab.ui.control.StateButton
        EndPointZ                    matlab.ui.control.Spinner
        ZLabel_16                    matlab.ui.control.Label
        EndPointY                    matlab.ui.control.Spinner
        YLabel_14                    matlab.ui.control.Label
        EndPointX                    matlab.ui.control.Spinner
        XSpinnerLabel_11             matlab.ui.control.Label
        StartPointZ                  matlab.ui.control.Spinner
        ZLabel_15                    matlab.ui.control.Label
        StartPointY                  matlab.ui.control.Spinner
        YLabel_13                    matlab.ui.control.Label
        EndPointmmLabel              matlab.ui.control.Label
        StartPointmmLabel            matlab.ui.control.Label
        StartPointX                  matlab.ui.control.Spinner
        XSpinnerLabel_10             matlab.ui.control.Label
        CustomCellStrutsLabel        matlab.ui.control.Label
        Topology                     matlab.ui.control.DropDown
        FunctionLabel                matlab.ui.control.Label
        UnitCellDesignLabel          matlab.ui.control.Label
        Panel                        matlab.ui.container.Panel
        height                       matlab.ui.control.Spinner
        ZLabel_20                    matlab.ui.control.Label
        CompressiveSample            matlab.ui.control.DropDown
        ImportCustomDomainLabel_2    matlab.ui.control.Label
        cellZ                        matlab.ui.control.Spinner
        ZLabel_2                     matlab.ui.control.Label
        cellY                        matlab.ui.control.Spinner
        YLabel_2                     matlab.ui.control.Label
        cellX                        matlab.ui.control.Spinner
        XSpinnerLabel_5              matlab.ui.control.Label
        cuboidZ                      matlab.ui.control.Spinner
        CellDimmmLabel               matlab.ui.control.Label
        ZLabel                       matlab.ui.control.Label
        cuboidY                      matlab.ui.control.Spinner
        YLabel                       matlab.ui.control.Label
        cuboidX                      matlab.ui.control.Spinner
        XSpinnerLabel_4              matlab.ui.control.Label
        CuboidDimmmLabel             matlab.ui.control.Label
        BrowseButton                 matlab.ui.control.StateButton
        fileName                     matlab.ui.control.EditField
        NameofFileLabel              matlab.ui.control.Label
        ImportedMesh                 matlab.ui.control.DropDown
        ImportCustomDomainLabel      matlab.ui.control.Label
        GeometryInitializationLabel  matlab.ui.control.Label
        UIAxes                       matlab.ui.control.UIAxes
    end


    properties (Access = public)
        stopFlag = 0; %stop button flag
    end
    
    properties (Access = private)
        customStart = []; % Custom Struts Start Point
        customEnd = []; % Custom Struts End Point
        Faces = 0; % Faces
        Vertices = 0; % Vertices
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.UIFigure.Visible = 'off';
            movegui(app.UIFigure,"center")
            app.UIFigure.Visible = 'on';

            set(app.UIAxes.XLabel,'Color','black'); set(app.UIAxes.YLabel,'Color','black'); set(app.UIAxes.ZLabel,'Color','black');
            
            %app.Topology.Items = sort({'DCC','Octet','BCC','FCC','F2BCC'});
            %app.Topology.Items(end) = {'Custom'};
            %app.Topology2.Items = sort({'DCC','Octet','BCC','FCC','F2BCC'});

            % RotationCallback = @(c) camlight(c,headlight)

        end

        % Value changed function: ImportedMesh
        function ImportedMeshValueChanged(app, event)
            if strcmp(app.ImportedMesh.Value, "Yes")
                app.fileName.Editable = 'on';
                app.BrowseButton.Enable = 'on';
                app.cuboidX.Enable = 'off';
                app.cuboidY.Enable = 'off';
                app.cuboidZ.Enable = 'off';
                app.CompressiveSample.Enable = 'off';
                app.CompressiveSample.Value = 'No';
                app.height.Enable = 'off';
            else
                app.fileName.Editable = 'off';
                app.BrowseButton.Enable = 'off';
                app.cuboidX.Enable = 'on';
                app.cuboidY.Enable = 'on';
                app.cuboidZ.Enable = 'on';
                app.CompressiveSample.Enable = 'on';
                app.height.Enable = 'on';
            end
        end

        % Value changed function: BrowseButton
        function BrowseButtonValueChanged(app, event)
            [filename,path] = uigetfile('*.stl');
            file = fullfile(path,filename);
            if ~isequal(filename, 0)  % Check if the user canceled the dialog
                app.fileName.Value = file;
            end
            
            app.stopFlag = 0;
                app.Lamp.Color = [1,1,0];
                app.LampLabel.Text = "Running...";
                drawnow;
            
            if contains(file,'.stl') || contains(file,'.STL')
                inp = file;
            else
                inp= strcat(file, '.stl');
            end
           nd = stlread(inp);                                                              % read the imported mesh domain
           ndv = nd.Points; ndf = nd.ConnectivityList;                                     % get face and vertices of imported mesh domain
           
           %% Plotting Surfaces
            drawnow;
            if app.stopFlag == 0
                trisurf(ndf,ndv(:,1),ndv(:,2),ndv(:,3), 'Facecolor', '[1, 0.341, 0.200]','Edgecolor','none','Parent',app.UIAxes);
                axis(app.UIAxes, "equal");
                c = camlight(app.UIAxes, 'headlight');
                light(app.UIAxes,'position',[0 -1 0]);
                lighting(app.UIAxes,'flat') ;
                pbaspect(app.UIAxes,[1,1,1])
                set(c,'style','infinite');    % Set style
                h = rotate3d(app.UIAxes);                 % Create rotate3d-handle
                h.ActionPostCallback = @(a, b) RotationCallback(c);
                h.Enable = 'on';              % no need to click the UI-button
            end
                
                
            drawnow;
            app.Lamp.Color = [0,1,0];
            app.LampLabel.Text = " ";
        end

        % Value changed function: Topology
        function TopologyValueChanged(app, event)
            app.Curvepoints.Enable = "off";
            app.curve_control.Enable = "off";
            if strcmp(app.Topology.Value, "Custom")
                app.StartPointX.Enable = "on";
                app.StartPointY.Enable = "on";
                app.StartPointZ.Enable = "on";
                app.EndPointX.Enable = "on";
                app.EndPointY.Enable = "on";
                app.EndPointZ.Enable = "on";
                app.AddStrut.Enable = "on";
                app.RemoveStrut.Enable = "on";
                app.NumberOfStruts.Enable = "on";
                app.CustomBrowseButton.Enable = "on";
                app.ImportCustomCell.Enable = "on";
                
                if ~isempty(app.customStart)
                    app.SaveCustom.Enable = "on";
                else
                    app.SaveCustom.Enable = "off";
                end
            
            else
                if strcmp(app.Topology.Value,"DCC") || strcmp(app.Topology.Value,"BCC-Curved") || strcmp(app.Topology.Value,"Butterfly-Curved") || strcmp(app.Topology.Value,"FCC-Curved")
                    app.Curvepoints.Enable = "on";
                    app.curve_control.Enable = "on";
                end
                app.StartPointX.Enable = "off";
                app.StartPointY.Enable = "off";
                app.StartPointZ.Enable = "off";
                app.EndPointX.Enable = "off";
                app.EndPointY.Enable = "off";
                app.EndPointZ.Enable = "off";
                app.AddStrut.Enable = "off";
                app.RemoveStrut.Enable = "off";
                app.NumberOfStruts.Enable = "off";
                app.CustomBrowseButton.Enable = "off";
                app.ImportCustomCell.Enable = "off";
                app.ImportCustomCell.Value = "Import Custom Cell";
                app.SaveCustom.Enable = "off";
            end
            
        end

        % Value changed function: Topology2
        function Topology2ValueChanged(app, event)
        app.Curvepoints.Enable = "off";
        app.curve_control.Enable = "off";
            if strcmp(app.Topology2.Value,"DCC") || strcmp(app.Topology.Value,"BCC-Curved") || strcmp(app.Topology.Value,"Butterfly-Curved")
                    app.Curvepoints.Enable = "on";
                    app.curve_control.Enable = "on";
            end 
        end

        % Value changed function: HybridStructure
        function HybridStructureValueChanged(app, event)
            if strcmp(app.HybridStructure.Value, "Single")
                app.CellTopology2Label.Enable = 'off';
                app.Topology2.Enable = 'off';        
            else
                app.CellTopology2Label.Enable = 'on';
                app.Topology2.Enable = 'on';
            end
        end

        % Value changed function: Hollow
        function HollowValueChanged(app, event)
            if strcmp(app.Hollow.Value,"Hollow")
                app.DensityControl.Enable = "off";
                app.relativeDensity.Enable = "off";
                app.relativeDensity_grade_2.Enable = "off";
            else
                app.DensityControl.Enable = "on";
                app.relativeDensity.Enable = "off";
                app.relativeDensity_grade_2.Enable = "off";
            end

            if strcmp(app.Hollow.Value,"Hollow") && strcmp(app.DensityType.Value,"Uniform") 
                app.InnerDiameter.Enable = "on";
                app.OuterDiameter.Enable = "on"	;
                app.InnerDiameter2.Enable = "off";
                app.OuterDiameter2.Enable = "off";
                app.thickness.Enable = "off";
                app.thickness_grade_2.Enable = "off";
            elseif strcmp(app.Hollow.Value,"Hollow") && strcmp(app.DensityType.Value,"Graded") 
                app.DensityControl.Value = "Thickness";
                app.InnerDiameter.Enable = "on";
                app.OuterDiameter.Enable = "on";
                app.InnerDiameter2.Enable = "on";
                app.OuterDiameter2.Enable = "on";
                app.thickness.Enable = "off";
                app.thickness_grade_2.Enable = "off";
            elseif strcmp(app.Hollow.Value,"Solid") && strcmp(app.DensityType.Value,"Uniform")
                app.InnerDiameter.Enable = "off";
                app.OuterDiameter.Enable = "off"	;
                app.InnerDiameter2.Enable = "off";
                app.OuterDiameter2.Enable = "off";
                app.thickness.Enable = "on";
                app.thickness_grade_2.Enable = "off";
            elseif strcmp(app.Hollow.Value,"Solid") && strcmp(app.DensityType.Value,"Graded")
                app.InnerDiameter.Enable = "off";
                app.OuterDiameter.Enable = "off"	;
                app.InnerDiameter2.Enable = "off";
                app.OuterDiameter2.Enable = "off";
                app.thickness.Enable = "on";
                app.thickness_grade_2.Enable = "on";
            end
        end

        % Value changed function: CustomBrowseButton
        function CustomBrowseButtonValueChanged(app, event)
           data = [];
            [filename,path] = uigetfile('*.txt');
            file = fullfile(path,filename);
            if ~isequal(filename, 0)  % Check if the user canceled the dialog
                app.ImportCustomCell.Value = file;
                data = readmatrix(app.ImportCustomCell.Value);
            end
            
            cla(app.UIAxes)
            hold(app.UIAxes,'on')
            h = app.UIAxes;

            quiver3(0, 0, 0, 0.2, 0, 0, 'Color', 'r', 'LineStyle', '-', 'LineWidth', 2, 'Parent',h, 'MaxHeadSize',8, 'Clipping', 'off');
            text(h,0.25,0,0,'x', 'color', [0,0,0]); view(h, 30, 30)
            quiver3(0, 0, 0, 0, 0.2, 0, 'Color', [0,1,0], 'LineStyle', '-', 'LineWidth', 2, 'Parent',h, 'MaxHeadSize',8, 'Clipping', 'off');
            text(h,0,0.25,0,'y', 'color', [0,0,0]); view(h, 30, 30)
            quiver3(0, 0, 0, 0, 0, 0.2, 'Color', [0,0,1], 'LineStyle', '-', 'LineWidth', 2, 'Parent',h, 'MaxHeadSize',8, 'Clipping', 'off');
            text(h,0,0,0.25,'z', 'color', [0,0,0]); view(h, 30, 30)
            axis(app.UIAxes,"on")
            app.UIAxes.XTickMode = "auto";
            app.UIAxes.YTickMode = "auto";
            app.UIAxes.ZTickMode = "auto";
            xlim(app.UIAxes,[-1 1])
            ylim(app.UIAxes,[-1 1])
            zlim(app.UIAxes,[-1 1])

            count = 1;
            for i = 1:2:size(data,1)
                app.customStart(count,:) = data(i,:);
                app.customEnd(count,:) = data(i+1,:);
                line = [app.customStart(count,:);app.customEnd(count,:)];
                plot3(app.UIAxes,(line(:,1))',(line(:,2))',(line(:,3))',"-b")
                rotate3d(app.UIAxes,'on');
                axis(app.UIAxes, "equal");
                camlight(app.UIAxes, 'headlight');
                light(app.UIAxes,'position',[0 -1 0]);
                lighting(app.UIAxes,'flat') ;
                pbaspect(app.UIAxes,[1,1,1])
                count = count+1;
                
            end
        
                % app.StartPointX.Enable = "off";
                % app.StartPointY.Enable = "off";
                % app.StartPointZ.Enable = "off";
                % app.EndPointX.Enable = "off";
                % app.EndPointY.Enable = "off";
                % app.EndPointZ.Enable = "off";
                % app.AddStrut.Enable = "off";
                % app.RemoveStrut.Enable = "off";
                % app.NumberOfStruts.Enable = "off";
                
            hold(app.UIAxes,'off')
            
        end

        % Value changed function: AddStrut
        function AddStrutValueChanged(app, event)
            startPoints = [app.StartPointX.Value,app.StartPointY.Value,app.StartPointZ.Value];
            app.customStart = [app.customStart;startPoints];

            EndPoints = [app.EndPointX.Value,app.EndPointY.Value,app.EndPointZ.Value];
            app.customEnd = [app.customEnd;EndPoints];
            app.NumberOfStruts.Value = int2str(size(app.customStart,1));
            
            cla(app.UIAxes)
            h = app.UIAxes;
            
            hold(app.UIAxes,'on')

            quiver3(0, 0, 0, 0.2, 0, 0, 'Color', 'r', 'LineStyle', '-', 'LineWidth', 2, 'Parent',h, 'MaxHeadSize',8, 'Clipping', 'off');
            text(h,0.25,0,0,'x', 'color', [0,0,0]); view(h, 30, 30)
            quiver3(0, 0, 0, 0, 0.2, 0, 'Color', [0,1,0], 'LineStyle', '-', 'LineWidth', 2, 'Parent',h, 'MaxHeadSize',8, 'Clipping', 'off');
            text(h,0,0.25,0,'y', 'color', [0,0,0]); view(h, 30, 30)
            quiver3(0, 0, 0, 0, 0, 0.2, 'Color', [0,0,1], 'LineStyle', '-', 'LineWidth', 2, 'Parent',h, 'MaxHeadSize',8, 'Clipping', 'off');
            text(h,0,0,0.25,'z', 'color', [0,0,0]); view(h, 30, 30)
            axis(app.UIAxes,"on")
            app.UIAxes.XTickMode = "auto";
            app.UIAxes.YTickMode = "auto";
            app.UIAxes.ZTickMode = "auto";
            xlim(app.UIAxes,[-1 1])
            ylim(app.UIAxes,[-1 1])
            zlim(app.UIAxes,[-1 1])

            for i = 1:size(app.customStart)
                line = [app.customStart(i,:);app.customEnd(i,:)];
                plot3(app.UIAxes,(line(:,1))',(line(:,2))',(line(:,3))',"-b")
                rotate3d(app.UIAxes,'on');
                axis(app.UIAxes, "equal");
                camlight(app.UIAxes, 'headlight');
                light(app.UIAxes,'position',[0 -1 0]);
                lighting(app.UIAxes,'flat') ;
                pbaspect(app.UIAxes,[1,1,1])
            end
            hold(app.UIAxes,'off')

            if ~isempty(app.customStart)
                app.SaveCustom.Enable = "on";
            else
                app.SaveCustom.Enable = "off";
            end
        end

        % Value changed function: RemoveStrut
        function RemoveStrutValueChanged(app, event)
            app.customStart = app.customStart(1:end-1,:);
            app.customEnd = app.customEnd(1:end-1,:);
            app.NumberOfStruts.Value = int2str(size(app.customStart,1));

            cla(app.UIAxes)
            h = app.UIAxes;
            
            hold(app.UIAxes,'on')

            quiver3(0, 0, 0, 0.2, 0, 0, 'Color', 'r', 'LineStyle', '-', 'LineWidth', 2, 'Parent',h, 'MaxHeadSize',8, 'Clipping', 'off');
            text(h,0.25,0,0,'x', 'color', [0,0,0]); view(h, 30, 30)
            quiver3(0, 0, 0, 0, 0.2, 0, 'Color', [0,1,0], 'LineStyle', '-', 'LineWidth', 2, 'Parent',h, 'MaxHeadSize',8, 'Clipping', 'off');
            text(h,0,0.25,0,'y', 'color', [0,0,0]); view(h, 30, 30)
            quiver3(0, 0, 0, 0, 0, 0.2, 'Color', [0,0,1], 'LineStyle', '-', 'LineWidth', 2, 'Parent',h, 'MaxHeadSize',8, 'Clipping', 'off');
            text(h,0,0,0.25,'z', 'color', [0,0,0]); view(h, 30, 30)
            axis(app.UIAxes,"on")
            app.UIAxes.XTickMode = "auto";
            app.UIAxes.YTickMode = "auto";
            app.UIAxes.ZTickMode = "auto";
            xlim(app.UIAxes,[-1 1])
            ylim(app.UIAxes,[-1 1])
            zlim(app.UIAxes,[-1 1])
            
            for i = 1:size(app.customStart)
                line = [app.customStart(i,:);app.customEnd(i,:)];
                plot3(app.UIAxes,(line(:,1))',(line(:,2))',(line(:,3))',"-b")
                rotate3d(app.UIAxes,'on');
                axis(app.UIAxes, "equal");
                camlight(app.UIAxes, 'headlight');
                light(app.UIAxes,'position',[0 -1 0]);
                lighting(app.UIAxes,'flat') ;
                pbaspect(app.UIAxes,[1,1,1])
            end
            hold(app.UIAxes,'off')

            if ~isempty(app.customStart)
                app.SaveCustom.Enable = "on";
            else
                app.SaveCustom.Enable = "off";
            end
            
        end

        % Value changed function: DensityControl
        function DensityControlValueChanged(app, event)
            if strcmp(app.DensityControl.Value,"Thickness") && strcmp(app.DensityType.Value,"Uniform") && strcmp(app.Hollow.Value,"Hollow")
                app.thickness.Enable = "off";
                app.thickness_grade_2.Enable = "off";
                app.relativeDensity.Enable = 'off';
                app.relativeDensity_grade_2.Enable = 'off';
                app.InnerDiameter.Enable = "on";
                app.OuterDiameter.Enable = "on";
                app.InnerDiameter2.Enable = "off";
                app.OuterDiameter2.Enable = "off";
                app.coefficientA_grade.Enable = "off";
                app.coefficientB_grade.Enable = "off";
                app.coefficientC_grade.Enable = "off";
                app.coefficientD_grade.Enable = "off";
                app.GradingFormula.Enable = "off";
                app.GradingEquation.Enable = "off";
                app.EquationLabel.Enable = "off";
                app.CoefficientLabel.Enable = "off";
                app.RelativePosition_grade.Enable = "off";
                app.positionX_grade.Enable = "off";
                app.positionY_grade.Enable = "off";
                app.positionZ_grade.Enable = "off";
            elseif strcmp(app.DensityControl.Value,"Thickness") && strcmp(app.DensityType.Value,"Graded") && strcmp(app.Hollow.Value,"Hollow")
                app.thickness.Enable = "off";
                app.thickness_grade_2.Enable = "off";
                app.relativeDensity.Enable = 'off';
                app.relativeDensity_grade_2.Enable = 'off';
                app.InnerDiameter.Enable = "on";
                app.OuterDiameter.Enable = "on";
                app.InnerDiameter2.Enable = "on";
                app.OuterDiameter2.Enable = "on";
                app.coefficientA_grade.Enable = "on";
                app.coefficientB_grade.Enable = "on";
                app.coefficientC_grade.Enable = "on";
                app.coefficientD_grade.Enable = "on";
                app.GradingFormula.Enable = "on";
                app.GradingEquation.Enable = "on";
                app.EquationLabel.Enable = "on";
                app.CoefficientLabel.Enable = "on";
                app.RelativePosition_grade.Enable = "on";
                app.positionX_grade.Enable = "on";
                app.positionY_grade.Enable = "on";
                app.positionZ_grade.Enable = "on";
            elseif strcmp(app.DensityControl.Value,"Thickness") && strcmp(app.DensityType.Value,"Uniform") && strcmp(app.Hollow.Value,"Solid")
                app.thickness.Enable = "on";
                app.thickness_grade_2.Enable = "off";
                app.relativeDensity.Enable = 'off';
                app.relativeDensity_grade_2.Enable = 'off';
                app.InnerDiameter.Enable = "off";
                app.OuterDiameter.Enable = "off";
                app.InnerDiameter2.Enable = "off";
                app.OuterDiameter2.Enable = "off";
                app.coefficientA_grade.Enable = "off";
                app.coefficientB_grade.Enable = "off";
                app.coefficientC_grade.Enable = "off";
                app.coefficientD_grade.Enable = "off";
                app.GradingFormula.Enable = "off";
                app.GradingEquation.Enable = "off";
                app.EquationLabel.Enable = "off";
                app.CoefficientLabel.Enable = "off";
                app.RelativePosition_grade.Enable = "off";
                app.positionX_grade.Enable = "off";
                app.positionY_grade.Enable = "off";
                app.positionZ_grade.Enable = "off";
            elseif strcmp(app.DensityControl.Value,"Thickness") && strcmp(app.DensityType.Value,"Graded") && strcmp(app.Hollow.Value,"Solid")
                app.thickness.Enable = "on";
                app.thickness_grade_2.Enable = "on";
                app.relativeDensity.Enable = 'off';
                app.relativeDensity_grade_2.Enable = 'off';
                app.InnerDiameter.Enable = "off";
                app.OuterDiameter.Enable = "off";
                app.InnerDiameter2.Enable = "off";
                app.OuterDiameter2.Enable = "off";
                app.coefficientA_grade.Enable = "on";
                app.coefficientB_grade.Enable = "on";
                app.coefficientC_grade.Enable = "on";
                app.coefficientD_grade.Enable = "on";
                app.GradingFormula.Enable = "on";
                app.GradingEquation.Enable = "on";
                app.EquationLabel.Enable = "on";
                app.CoefficientLabel.Enable = "on";
                app.RelativePosition_grade.Enable = "on";
                app.positionX_grade.Enable = "on";
                app.positionY_grade.Enable = "on";
                app.positionZ_grade.Enable = "on";
            elseif strcmp(app.DensityControl.Value,"Relative Density") && strcmp(app.DensityType.Value,"Uniform") 
                app.thickness.Enable = "off";
                app.thickness_grade_2.Enable = "off";
                app.relativeDensity.Enable = 'on';
                app.relativeDensity_grade_2.Enable = 'off';
                app.InnerDiameter.Enable = "off";
                app.OuterDiameter.Enable = "off";
                app.InnerDiameter2.Enable = "off";
                app.OuterDiameter2.Enable = "off";
                app.coefficientA_grade.Enable = "off";
                app.coefficientB_grade.Enable = "off";
                app.coefficientC_grade.Enable = "off";
                app.coefficientD_grade.Enable = "off";
                app.GradingFormula.Enable = "off";
                app.GradingEquation.Enable = "off";
                app.EquationLabel.Enable = "off";
                app.CoefficientLabel.Enable = "off";
                app.RelativePosition_grade.Enable = "off";
                app.positionX_grade.Enable = "off";
                app.positionY_grade.Enable = "off";
                app.positionZ_grade.Enable = "off";
            elseif strcmp(app.DensityControl.Value,"Relative Density") && strcmp(app.DensityType.Value,"Graded") 
                app.thickness.Enable = "off";
                app.thickness_grade_2.Enable = "off";
                app.relativeDensity.Enable = 'on';
                app.relativeDensity_grade_2.Enable = "on";
                app.InnerDiameter.Enable = "off";
                app.OuterDiameter.Enable = "off";
                app.InnerDiameter2.Enable = "off";
                app.OuterDiameter2.Enable = "off";
                app.coefficientA_grade.Enable = "on";
                app.coefficientB_grade.Enable = "on";
                app.coefficientC_grade.Enable = "on";
                app.coefficientD_grade.Enable = "on";
                app.GradingFormula.Enable = "on";
                app.GradingEquation.Enable = "on";
                app.EquationLabel.Enable = "on";
                app.CoefficientLabel.Enable = "on";
                app.RelativePosition_grade.Enable = "on";
                app.positionX_grade.Enable = "on";
                app.positionY_grade.Enable = "on";
                app.positionZ_grade.Enable = "on";
            else
            end
            
        end

        % Value changed function: DensityType
        function DensityTypeValueChanged(app, event)
            if strcmp(app.DensityControl.Value,"Thickness") && strcmp(app.DensityType.Value,"Uniform") && strcmp(app.Hollow.Value,"Hollow")
                app.thickness.Enable = "off";
                app.thickness_grade_2.Enable = "off";
                app.relativeDensity.Enable = 'off';
                app.relativeDensity_grade_2.Enable = 'off';
                app.InnerDiameter.Enable = "on";
                app.OuterDiameter.Enable = "on";
                app.InnerDiameter2.Enable = "off";
                app.OuterDiameter2.Enable = "off";
                app.coefficientA_grade.Enable = "off";
                app.coefficientB_grade.Enable = "off";
                app.coefficientC_grade.Enable = "off";
                app.coefficientD_grade.Enable = "off";
                app.GradingFormula.Enable = "off";
                app.GradingEquation.Enable = "off";
                app.EquationLabel.Enable = "off";
                app.CoefficientLabel.Enable = "off";
                app.RelativePosition_grade.Enable = "off";
                app.positionX_grade.Enable = "off";
                app.positionY_grade.Enable = "off";
                app.positionZ_grade.Enable = "off";
            elseif strcmp(app.DensityType.Value,"Graded") && strcmp(app.Hollow.Value,"Hollow")
                app.thickness.Enable = "off";
                app.thickness_grade_2.Enable = "off";
                app.relativeDensity.Enable = 'off';
                app.relativeDensity_grade_2.Enable = 'off';
                app.InnerDiameter.Enable = "on";
                app.OuterDiameter.Enable = "on";
                app.InnerDiameter2.Enable = "on";
                app.OuterDiameter2.Enable = "on";
                app.coefficientA_grade.Enable = "on";
                app.coefficientB_grade.Enable = "on";
                app.coefficientC_grade.Enable = "on";
                app.coefficientD_grade.Enable = "on";
                app.GradingFormula.Enable = "on";
                app.GradingEquation.Enable = "on";
                app.EquationLabel.Enable = "on";
                app.CoefficientLabel.Enable = "on";
                app.RelativePosition_grade.Enable = "on";
                app.positionX_grade.Enable = "on";
                app.positionY_grade.Enable = "on";
                app.positionZ_grade.Enable = "on";
            elseif strcmp(app.DensityControl.Value,"Thickness") && strcmp(app.DensityType.Value,"Uniform") && strcmp(app.Hollow.Value,"Solid")
                app.thickness.Enable = "on";
                app.thickness_grade_2.Enable = "off";
                app.relativeDensity.Enable = 'off';
                app.relativeDensity_grade_2.Enable = 'off';
                app.InnerDiameter.Enable = "off";
                app.OuterDiameter.Enable = "off";
                app.InnerDiameter2.Enable = "off";
                app.OuterDiameter2.Enable = "off";
                app.coefficientA_grade.Enable = "off";
                app.coefficientB_grade.Enable = "off";
                app.coefficientC_grade.Enable = "off";
                app.coefficientD_grade.Enable = "off";
                app.GradingFormula.Enable = "off";
                app.GradingEquation.Enable = "off";
                app.EquationLabel.Enable = "off";
                app.CoefficientLabel.Enable = "off";
                app.RelativePosition_grade.Enable = "off";
                app.positionX_grade.Enable = "off";
                app.positionY_grade.Enable = "off";
                app.positionZ_grade.Enable = "off";
            elseif strcmp(app.DensityControl.Value,"Thickness") && strcmp(app.DensityType.Value,"Graded") && strcmp(app.Hollow.Value,"Solid")
                app.thickness.Enable = "on";
                app.thickness_grade_2.Enable = "on";
                app.relativeDensity.Enable = 'off';
                app.relativeDensity_grade_2.Enable = 'off';
                app.InnerDiameter.Enable = "off";
                app.OuterDiameter.Enable = "off";
                app.InnerDiameter2.Enable = "off";
                app.OuterDiameter2.Enable = "off";
                app.coefficientA_grade.Enable = "on";
                app.coefficientB_grade.Enable = "on";
                app.coefficientC_grade.Enable = "on";
                app.coefficientD_grade.Enable = "on";
                app.GradingFormula.Enable = "on";
                app.GradingEquation.Enable = "on";
                app.EquationLabel.Enable = "on";
                app.CoefficientLabel.Enable = "on";
                app.RelativePosition_grade.Enable = "on";
                app.positionX_grade.Enable = "on";
                app.positionY_grade.Enable = "on";
                app.positionZ_grade.Enable = "on";
            elseif strcmp(app.DensityControl.Value,"Relative Density") && strcmp(app.DensityType.Value,"Uniform") 
                app.thickness.Enable = "off";
                app.thickness_grade_2.Enable = "off";
                app.relativeDensity.Enable = 'on';
                app.relativeDensity_grade_2.Enable = 'off';
                app.InnerDiameter.Enable = "off";
                app.OuterDiameter.Enable = "off";
                app.InnerDiameter2.Enable = "off";
                app.OuterDiameter2.Enable = "off";
                app.coefficientA_grade.Enable = "off";
                app.coefficientB_grade.Enable = "off";
                app.coefficientC_grade.Enable = "off";
                app.coefficientD_grade.Enable = "off";
                app.GradingFormula.Enable = "off";
                app.GradingEquation.Enable = "off";
                app.EquationLabel.Enable = "off";
                app.CoefficientLabel.Enable = "off";
                app.RelativePosition_grade.Enable = "off";
                app.positionX_grade.Enable = "off";
                app.positionY_grade.Enable = "off";
                app.positionZ_grade.Enable = "off";
            elseif strcmp(app.DensityControl.Value,"Relative Density") && strcmp(app.DensityType.Value,"Graded") 
                app.thickness.Enable = "off";
                app.thickness_grade_2.Enable = "off";
                app.relativeDensity.Enable = 'on';
                app.relativeDensity_grade_2.Enable = "on";
                app.InnerDiameter.Enable = "off";
                app.OuterDiameter.Enable = "off";
                app.InnerDiameter2.Enable = "off";
                app.OuterDiameter2.Enable = "off";
                app.coefficientA_grade.Enable = "on";
                app.coefficientB_grade.Enable = "on";
                app.coefficientC_grade.Enable = "on";
                app.coefficientD_grade.Enable = "on";
                app.GradingFormula.Enable = "on";
                app.GradingEquation.Enable = "on";
                app.EquationLabel.Enable = "on";
                app.CoefficientLabel.Enable = "on";
                app.RelativePosition_grade.Enable = "on";
                app.positionX_grade.Enable = "on";
                app.positionY_grade.Enable = "on";
                app.positionZ_grade.Enable = "on";
            end
            
        end

        % Value changed function: relativeDensity
        function relativeDensityValueChanged(app, event)
            try
                app.stopFlag = 0;
                app.Lamp.Color = [1,1,0];
                app.LampLabel.Text = "Estimating...";
                drawnow;
        
                relDensity = app.relativeDensity.Value;
                thicknessGuess = relDensity*2*app.cellX.Value/3;
        
                max_iterations = 1000;
        
                tolerance = 0.00001;
        
                for i = 1:max_iterations
                    drawnow;
                    if app.stopFlag == 0
                    [f,xx,yy,zz] = GenerateStructure(app,app.cellX.Value,app.cellY.Value,app.cellZ.Value,app.cellX.Value,app.cellY.Value,app.cellZ.Value,app.Gridpoints.Value,app.Topology.Value,app.Topology2.Value,app.Curvepoints.Value,app.curve_control.Value,app.customStart,app.customEnd,thicknessGuess,app.thickness_grade_2.Value, ...
                            app.HybridStructure.Value,"Solid",[],[],[],[],"No",app.fileName.Value,app.CompressiveSample.Value,app.height.Value,"Uniform",app.GradingEquation.Value,app.coefficientA_grade.Value,app.coefficientB_grade.Value,app.coefficientC_grade.Value,app.coefficientD_grade.Value,app.positionX_grade.Value,app.positionY_grade.Value,app.positionZ_grade.Value);
                    end
        
                    drawnow;
                    if app.stopFlag == 0
                        [face1, vertex1] = isosurface(xx,yy,zz,f,0);
                    end
        
                    drawnow;
                    if app.stopFlag == 0
                        [face2, vertex2] = isocaps(xx,yy,zz,f,0);
                        F = [face1; length(vertex1(:,1)) + face2]; %concatenates the face arrays which represent the faces of the resulting solid
                        V = [vertex1; vertex2]; 
                        V = [V(:,1)*app.cellX.Value V(:,2)*app.cellY.Value V(:,3)*app.cellZ.Value]; 
                        v_ini = app.cellX.Value*app.cellY.Value*app.cellZ.Value;
                        lattice_volume = abs(stlVolume(V',F'));
                        rd = lattice_volume/v_ini;
                    end
                    error = relDensity-rd;
                    if abs(error) < tolerance
                        break
                    else
                        thicknessGuess = abs(thicknessGuess + error*2*app.cellX.Value/3);
                    end
                end
                app.thickness.Value = thicknessGuess;
                app.Lamp.Color = [0,1,0];
                app.LampLabel.Text = " ";
        
            catch ME
                if app.stopFlag == 0
                app.Lamp.Color = [1,0,0];
                app.LampLabel.Text = 'Error! Check log';
                if exist("error_log",'dir') == 0
                    mkdir error_log
                else
                end
                logFile = fopen('.\error_log\logfile.txt', 'a');
                fprintf(logFile, '%s\n', ME.message);
                rethrow(ME)
                else
                    drawnow;
                    app.Lamp.Color = [0,1,0];
                    app.LampLabel.Text = " ";
                end
            end
        end

        % Value changed function: relativeDensity_grade_2
        function relativeDensity_grade_2ValueChanged(app, event)
            try
                app.stopFlag = 0;
                app.Lamp.Color = [1,1,0];
                app.LampLabel.Text = "Estimating...";
                drawnow;
        
                relDensity = app.relativeDensity_grade_2.Value;
                thicknessGuess = relDensity*2*app.cellX.Value/3;
        
                max_iterations = 1000;
        
                tolerance = 0.00001;
        
                for i = 1:max_iterations
                    
                    drawnow;
                    if app.stopFlag == 0
                    [f,xx,yy,zz] = GenerateStructure(app,app.cellX.Value,app.cellY.Value,app.cellZ.Value,app.cellX.Value,app.cellY.Value,app.cellZ.Value,app.Gridpoints.Value,app.Topology.Value,app.Topology2.Value,app.Curvepoints.Value,app.curve_control.Value,app.customStart,app.customEnd,thicknessGuess,app.thickness_grade_2.Value, ...
                            app.HybridStructure.Value,"Solid",[],[],[],[],"No",app.fileName.Value,app.CompressiveSample.Value,app.height.Value,"Uniform",app.GradingEquation.Value,app.coefficientA_grade.Value,app.coefficientB_grade.Value,app.coefficientC_grade.Value,app.coefficientD_grade.Value,app.positionX_grade.Value,app.positionY_grade.Value,app.positionZ_grade.Value);
                    end
        
                    drawnow;
                    if app.stopFlag == 0
                        [face1, vertex1] = isosurface(xx,yy,zz,f,0);
                    end
        
                    drawnow;
                    if app.stopFlag == 0
                        [face2, vertex2] = isocaps(xx,yy,zz,f,0);
                        F = [face1; length(vertex1(:,1)) + face2]; %concatenates the face arrays which represent the faces of the resulting solid
                        V = [vertex1; vertex2]; 
                        V = [V(:,1)*app.cellX.Value V(:,2)*app.cellY.Value V(:,3)*app.cellZ.Value]; 
                        v_ini = app.cellX.Value*app.cellY.Value*app.cellZ.Value;
                        lattice_volume = abs(stlVolume(V',F'));
                        rd = lattice_volume/v_ini;
                    end
                    error = relDensity-rd;
                    if abs(error) < tolerance
                        break
                    else
                        thicknessGuess = thicknessGuess + error*2*app.cellX.Value/3;
                    end
                end
                app.thickness_grade_2.Value = thicknessGuess;
                app.Lamp.Color = [0,1,0];
                app.LampLabel.Text = " ";
            
            catch ME
                if app.stopFlag == 0
                app.Lamp.Color = [1,0,0];
                app.LampLabel.Text = 'Error! Check log';
                if exist("error_log",'dir') == 0
                    mkdir error_log
                else
                end
                logFile = fopen('.\error_log\logfile.txt', 'a');
                fprintf(logFile, '%s\n', ME.message);
                rethrow(ME)
                else
                    drawnow;
                    app.Lamp.Color = [0,1,0];
                    app.LampLabel.Text = " ";
                end
            end
        end

        % Value changed function: GradingEquation
        function GradingEquationValueChanged(app, event)
            if strcmp(app.GradingEquation.Value,"Linear")
                app.GradingFormula.Value = "A + BX + CY + DZ";
            elseif strcmp(app.GradingEquation.Value,"Quadratic")
                app.GradingFormula.Value = "A + BX^2 + CY^2 + DZ^2";
            elseif strcmp(app.GradingEquation.Value,"Cubic")
                app.GradingFormula.Value = "A + BX^3 + CY^3 + DZ^3";
            elseif strcmp(app.GradingEquation.Value,"Circular")
                app.GradingFormula.Value = "sqrt(AX^2 + BY^2 + CZ^2) - R";
            elseif strcmp(app.GradingEquation.Value,"Exponential")
                app.GradingFormula.Value = "e^(AX) + e^(BY) + e^(CZ)";
            elseif strcmp(app.GradingEquation.Value,"Trigonometric - Sin")
                app.GradingFormula.Value = "sin(AX) + sin(BY) + sin(CZ)";
            elseif strcmp(app.GradingEquation.Value,"Trigonometric - Cosine")
                app.GradingFormula.Value = "cos(AX) + cos(BY) + cos(CZ)";
            end     
        end

        % Value changed function: Plot
        function PlotValueChanged(app, event)
            try
                tic
                app.stopFlag = 0;
                app.Lamp.Color = [1,1,0];
                app.LampLabel.Text = "Running...";
                drawnow;
                
                %% Generate Structure
                [f,xx,yy,zz] = GenerateStructure(app,app.cuboidX.Value,app.cuboidY.Value,app.cuboidZ.Value,app.cellX.Value,app.cellY.Value,app.cellZ.Value,app.Gridpoints.Value,app.Topology.Value,app.Topology2.Value,app.Curvepoints.Value,app.curve_control.Value,app.customStart,app.customEnd,app.thickness.Value,app.thickness_grade_2.Value, ...
                    app.HybridStructure.Value,app.Hollow.Value,app.OuterDiameter.Value,app.InnerDiameter.Value,app.OuterDiameter2.Value,app.InnerDiameter2.Value,app.ImportedMesh.Value,app.fileName.Value,app.CompressiveSample.Value,app.height.Value,app.DensityType.Value,app.GradingEquation.Value,app.coefficientA_grade.Value,app.coefficientB_grade.Value, ...
                    app.coefficientC_grade.Value,app.coefficientD_grade.Value,app.positionX_grade.Value,app.positionY_grade.Value,app.positionZ_grade.Value);
                
                drawnow;
                if app.stopFlag == 0
                    [face1, vertex1] = isosurface(xx,yy,zz,f,0);
                end

                drawnow;
                if app.stopFlag == 0
                    [face2, vertex2] = isocaps(xx,yy,zz,f,0);
                    F = [face1; length(vertex1(:,1)) + face2]; %concatenates the face arrays which represent the faces of the resulting solid
                    V = [vertex1; vertex2]; 

                    if strcmpi(app.ImportedMesh.Value,'Yes')
                        Name = app.fileName.Value;
                        if contains(Name,'.stl') || contains(Name,'.STL')
                            inp = Name;
                        else
                            inp= strcat(Name, '.stl');
                        end
                        drawnow;
                        if app.stopFlag == 0
                           nd = stlread(inp);                                                              % read the imported mesh domain
                           ndv = nd.Points; ndf = nd.ConnectivityList;                                     % get face and vertices of imported mesh domain
                           v_ini = stlVolume(ndv',ndf');                                                   % compute the volume of imported mesh domain
                        end
                    else
                        v_ini = app.cuboidX.Value*app.cuboidY.Value*app.cuboidZ.Value;
                        V = [V(:,1)*app.cellX.Value V(:,2)*app.cellY.Value V(:,3)*app.cellZ.Value]; 
                    end
                        lattice_volume = abs(stlVolume(V',F'));
                        rd = sprintf('%.4f', lattice_volume/v_ini);
                        app.exactRelativeDensity.Enable = "on";
                        app.exactRelativeDensity.Value = rd;
                        app.LatticeVolume.Enable = "on";
                        app.LatticeVolume.Value = sprintf('%.4f',lattice_volume/1000);
                end

                %% Plotting Surfaces
                drawnow;
                if app.stopFlag == 0
                    app.UIAxes.XTickMode = "auto";
                    app.UIAxes.YTickMode = "auto";
                    app.UIAxes.ZTickMode = "auto";
                    trisurf(F,V(:,1),V(:,2),V(:,3), 'Facecolor', '[1, 0.341, 0.200]','Edgecolor','none','Parent',app.UIAxes);
                    axis(app.UIAxes, "equal");
                    c = camlight(app.UIAxes, 'headlight');
                    light(app.UIAxes,'position',[0 -1 0]);
                    lighting(app.UIAxes,'flat') ;
                    pbaspect(app.UIAxes,[1,1,1])
                    set(c,'style','infinite');    % Set style
                    h = rotate3d(app.UIAxes);                 % Create rotate3d-handle
                    h.ActionPostCallback = @(a, b) RotationCallback(c);
                    h.Enable = 'on';              % no need to click the UI-button
                end
                
                
                drawnow;
                app.Lamp.Color = [0,1,0];
                app.LampLabel.Text = " ";

                app.Nodes.Enable = "on";
                app.Nodes.Value = sprintf('%d',size(f,1)*size(f,2)*size(f,3));
                app.Runtime.Enable = "on";
                app.Runtime.Value = sprintf('%.4f',toc);
                app.Faces = F;
                app.Vertices = V;

            catch ME
                if app.stopFlag == 0
                    app.Lamp.Color = [1,0,0];
                    app.LampLabel.Text = 'Error! Check log';
                    if exist("error_log",'dir') == 0
                        mkdir error_log
                    else
                    end
                    logFile = fopen('.\error_log\logfile.txt', 'a');
                    fprintf(logFile, '%s\n', ME.message);
                    rethrow(ME)
                else
                    drawnow;
                    app.Lamp.Color = [0,1,0];
                    app.LampLabel.Text = " ";
                end
            end
        end

        % Button pushed function: ExportSTL
        function ExportSTLButtonPushed(app, event)
            try
                app.stopFlag = 0;
                app.Lamp.Color = [1,1,0];
                app.LampLabel.Text = "Running...";
                drawnow;
                
                %% Export Structure
                if app.Faces == 0
                    app.LampLabel.Text = "Generate structure to export";
                    %period(1);
                    %app.LampLabel.Text = "";
                else
                drawnow;
                if ~app.stopFlag
                    [file, path] = uiputfile('.stl','Save As');
                    if ~isequal(file, 0)  % Check if the user canceled the dialog
                        NameofFile = fullfile(path,file);
                        stlwrite2(NameofFile, app.Faces, app.Vertices); %creates the object on an stl file
                    else
                    end
                end
                
                app.LampLabel.Text = " ";

                end
                
                app.Lamp.Color = [0,1,0];

            catch ME
                if app.stopFlag == 0
                    app.Lamp.Color = [1,0,0];
                    app.LampLabel.Text = 'Error! Check log';
                    if exist("error_log",'dir') == 0
                        mkdir error_log
                    else
                    end
                    logFile = fopen('.\error_log\logfile.txt', 'a');
                    fprintf(logFile, '%s\n', ME.message);
                    rethrow(ME)
                else
                    drawnow;
                    app.Lamp.Color = [0,1,0];
                    app.LampLabel.Text = " ";
                end
            end
        end

        % Button pushed function: SaveCustom
        function SaveCustomButtonPushed(app, event)
            if app.stopFlag == 0
                customCell = [];
                for i = 1:size(app.customStart,1)
                    customCell = [customCell;app.customStart(i,:);app.customEnd(i,:)];
                end
                %fileID = fopen('Custom Cell.txt', 'w');

                [file, path] = uiputfile('.txt','Save As');
                if ~isequal(file, 0)  % Check if the user canceled the dialog
                    NameofFile = fullfile(path,file);
                    fileID = fopen(NameofFile, 'w');
                else
                end

                if fileID == -1
                    error('Failed to open file. Check the file path and permissions.');
                end
                
                fprintf(fileID, '%d %d %d\n', customCell');
                fclose(fileID);
                app.LampLabel.Text = "Cell Saved";
            end
        end

        % Value changed function: Stop
        function StopValueChanged(app, event)
            if strcmp(app.LampLabel.Text, "Running...")
                app.stopFlag = 1;
                app.Lamp.Color = [1,0,0];
                app.LampLabel.Text = "Stopping...";
                pause(1)
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0 0 0];
            app.UIFigure.Position = [100 35 1105 794];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [1 1 1105 794];

            % Create StrutGeneratorTab
            app.StrutGeneratorTab = uitab(app.TabGroup);
            app.StrutGeneratorTab.Title = 'Strut Generator';
            app.StrutGeneratorTab.BackgroundColor = [0.9608 0.9608 0.9608];
            app.StrutGeneratorTab.Scrollable = 'on';

            % Create UIAxes
            app.UIAxes = uiaxes(app.StrutGeneratorTab);
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.DataAspectRatio = [1 0.69833729216152 1];
            app.UIAxes.XColor = [0.651 0.651 0.651];
            app.UIAxes.XTick = [];
            app.UIAxes.YColor = [0.651 0.651 0.651];
            app.UIAxes.YTick = [];
            app.UIAxes.ZColor = [0.651 0.651 0.651];
            app.UIAxes.ZTick = [];
            app.UIAxes.Color = [0.9608 0.9608 0.9608];
            app.UIAxes.GridColor = [1 1 1];
            app.UIAxes.MinorGridColor = [0 0 0];
            app.UIAxes.Box = 'on';
            app.UIAxes.Position = [580 124 495 633];

            % Create Panel
            app.Panel = uipanel(app.StrutGeneratorTab);
            app.Panel.ForegroundColor = [0 1 1];
            app.Panel.BackgroundColor = [1 1 1];
            app.Panel.Position = [27 582 542 160];

            % Create GeometryInitializationLabel
            app.GeometryInitializationLabel = uilabel(app.Panel);
            app.GeometryInitializationLabel.FontSize = 14;
            app.GeometryInitializationLabel.FontWeight = 'bold';
            app.GeometryInitializationLabel.FontColor = [0.2588 0.5216 0.9569];
            app.GeometryInitializationLabel.Position = [9 129 162 28];
            app.GeometryInitializationLabel.Text = 'Geometry Initialization';

            % Create ImportCustomDomainLabel
            app.ImportCustomDomainLabel = uilabel(app.Panel);
            app.ImportCustomDomainLabel.FontColor = [0.149 0.149 0.149];
            app.ImportCustomDomainLabel.Tooltip = {''};
            app.ImportCustomDomainLabel.Position = [13 107 132 22];
            app.ImportCustomDomainLabel.Text = 'Import Custom Domain:';

            % Create ImportedMesh
            app.ImportedMesh = uidropdown(app.Panel);
            app.ImportedMesh.Items = {'No', 'Yes'};
            app.ImportedMesh.ValueChangedFcn = createCallbackFcn(app, @ImportedMeshValueChanged, true);
            app.ImportedMesh.FontColor = [0.2 0.2 0.2];
            app.ImportedMesh.Position = [161 107 54 22];
            app.ImportedMesh.Value = 'No';

            % Create NameofFileLabel
            app.NameofFileLabel = uilabel(app.Panel);
            app.NameofFileLabel.FontColor = [0.149 0.149 0.149];
            app.NameofFileLabel.Tooltip = {'Provide the name of the imported mesh file or "Browse" to locate it on your computer'};
            app.NameofFileLabel.Position = [13 72 88 26];
            app.NameofFileLabel.Text = 'Name of file:';

            % Create fileName
            app.fileName = uieditfield(app.Panel, 'text');
            app.fileName.Editable = 'off';
            app.fileName.FontColor = [0.2 0.2 0.2];
            app.fileName.Position = [160 77 148 23];

            % Create BrowseButton
            app.BrowseButton = uibutton(app.Panel, 'state');
            app.BrowseButton.ValueChangedFcn = createCallbackFcn(app, @BrowseButtonValueChanged, true);
            app.BrowseButton.Enable = 'off';
            app.BrowseButton.Text = 'Browse';
            app.BrowseButton.BackgroundColor = [0.2588 0.5216 0.9608];
            app.BrowseButton.Position = [313 77 59 23];

            % Create CuboidDimmmLabel
            app.CuboidDimmmLabel = uilabel(app.Panel);
            app.CuboidDimmmLabel.FontColor = [0.149 0.149 0.149];
            app.CuboidDimmmLabel.Tooltip = {'Enter the length, width, and height values for the bounding box'};
            app.CuboidDimmmLabel.Position = [13 43 144 23];
            app.CuboidDimmmLabel.Text = 'Cuboid Dim. (mm):';

            % Create XSpinnerLabel_4
            app.XSpinnerLabel_4 = uilabel(app.Panel);
            app.XSpinnerLabel_4.HorizontalAlignment = 'right';
            app.XSpinnerLabel_4.Position = [121 44 25 22];
            app.XSpinnerLabel_4.Text = 'X:';

            % Create cuboidX
            app.cuboidX = uispinner(app.Panel);
            app.cuboidX.Limits = [0 Inf];
            app.cuboidX.Position = [161 44 54 22];
            app.cuboidX.Value = 20;

            % Create YLabel
            app.YLabel = uilabel(app.Panel);
            app.YLabel.HorizontalAlignment = 'right';
            app.YLabel.Position = [214 44 25 22];
            app.YLabel.Text = 'Y:';

            % Create cuboidY
            app.cuboidY = uispinner(app.Panel);
            app.cuboidY.Limits = [0 Inf];
            app.cuboidY.Position = [254 44 54 22];
            app.cuboidY.Value = 20;

            % Create ZLabel
            app.ZLabel = uilabel(app.Panel);
            app.ZLabel.HorizontalAlignment = 'right';
            app.ZLabel.Position = [308 44 25 22];
            app.ZLabel.Text = 'Z:';

            % Create CellDimmmLabel
            app.CellDimmmLabel = uilabel(app.Panel);
            app.CellDimmmLabel.FontColor = [0.149 0.149 0.149];
            app.CellDimmmLabel.Tooltip = {'Enter the length, width, and height values for the unit cell'};
            app.CellDimmmLabel.Position = [13 12 107 23];
            app.CellDimmmLabel.Text = 'Cell Dim. (mm):';

            % Create cuboidZ
            app.cuboidZ = uispinner(app.Panel);
            app.cuboidZ.Limits = [0 Inf];
            app.cuboidZ.Position = [348 44 54 22];
            app.cuboidZ.Value = 20;

            % Create XSpinnerLabel_5
            app.XSpinnerLabel_5 = uilabel(app.Panel);
            app.XSpinnerLabel_5.HorizontalAlignment = 'right';
            app.XSpinnerLabel_5.Position = [121 13 25 22];
            app.XSpinnerLabel_5.Text = 'X:';

            % Create cellX
            app.cellX = uispinner(app.Panel);
            app.cellX.Limits = [0 Inf];
            app.cellX.Position = [161 13 54 22];
            app.cellX.Value = 10;

            % Create YLabel_2
            app.YLabel_2 = uilabel(app.Panel);
            app.YLabel_2.HorizontalAlignment = 'right';
            app.YLabel_2.Position = [214 13 25 22];
            app.YLabel_2.Text = 'Y:';

            % Create cellY
            app.cellY = uispinner(app.Panel);
            app.cellY.Limits = [0 Inf];
            app.cellY.Position = [254 13 54 22];
            app.cellY.Value = 10;

            % Create ZLabel_2
            app.ZLabel_2 = uilabel(app.Panel);
            app.ZLabel_2.HorizontalAlignment = 'right';
            app.ZLabel_2.Position = [308 13 25 22];
            app.ZLabel_2.Text = 'Z:';

            % Create cellZ
            app.cellZ = uispinner(app.Panel);
            app.cellZ.Limits = [0 Inf];
            app.cellZ.Position = [348 13 54 22];
            app.cellZ.Value = 10;

            % Create ImportCustomDomainLabel_2
            app.ImportCustomDomainLabel_2 = uilabel(app.Panel);
            app.ImportCustomDomainLabel_2.FontColor = [0.149 0.149 0.149];
            app.ImportCustomDomainLabel_2.Tooltip = {''};
            app.ImportCustomDomainLabel_2.Position = [315 107 112 22];
            app.ImportCustomDomainLabel_2.Text = 'Sandwich Structure:';

            % Create CompressiveSample
            app.CompressiveSample = uidropdown(app.Panel);
            app.CompressiveSample.Items = {'No', 'Yes'};
            app.CompressiveSample.FontColor = [0.2 0.2 0.2];
            app.CompressiveSample.Position = [463 107 54 22];
            app.CompressiveSample.Value = 'No';

            % Create ZLabel_20
            app.ZLabel_20 = uilabel(app.Panel);
            app.ZLabel_20.HorizontalAlignment = 'right';
            app.ZLabel_20.Position = [406 77 43 22];
            app.ZLabel_20.Text = 'Height:';

            % Create height
            app.height = uispinner(app.Panel);
            app.height.Limits = [0 Inf];
            app.height.Position = [464 77 54 22];
            app.height.Value = 1;

            % Create Panel_2
            app.Panel_2 = uipanel(app.StrutGeneratorTab);
            app.Panel_2.BackgroundColor = [1 1 1];
            app.Panel_2.Position = [27 404 542 179];

            % Create UnitCellDesignLabel
            app.UnitCellDesignLabel = uilabel(app.Panel_2);
            app.UnitCellDesignLabel.FontSize = 14;
            app.UnitCellDesignLabel.FontWeight = 'bold';
            app.UnitCellDesignLabel.FontColor = [0.2588 0.5216 0.9569];
            app.UnitCellDesignLabel.Position = [9 148 112 22];
            app.UnitCellDesignLabel.Text = 'Unit Cell Design';

            % Create FunctionLabel
            app.FunctionLabel = uilabel(app.Panel_2);
            app.FunctionLabel.FontColor = [0.149 0.149 0.149];
            app.FunctionLabel.Tooltip = {'Select a predefined TPMS function'};
            app.FunctionLabel.Position = [13 112 80 24];
            app.FunctionLabel.Text = 'Cell Topology:';

            % Create Topology
            app.Topology = uidropdown(app.Panel_2);
            app.Topology.Items = {'BCC', 'BCC-Curved', 'Octet', 'FCC', 'FCC-Curved', 'DCC', 'Cubic', 'Octagon', 'Kelvin Cell', 'Butterfly-Curved', 'X-rods', 'Y-rods', 'Z-rods', 'Custom'};
            app.Topology.ValueChangedFcn = createCallbackFcn(app, @TopologyValueChanged, true);
            app.Topology.Tooltip = {''};
            app.Topology.FontColor = [0.149 0.149 0.149];
            app.Topology.BackgroundColor = [1 1 1];
            app.Topology.Position = [158 109 98 27];
            app.Topology.Value = 'BCC';

            % Create CustomCellStrutsLabel
            app.CustomCellStrutsLabel = uilabel(app.Panel_2);
            app.CustomCellStrutsLabel.FontSize = 14;
            app.CustomCellStrutsLabel.FontWeight = 'bold';
            app.CustomCellStrutsLabel.FontColor = [0.2588 0.5216 0.9608];
            app.CustomCellStrutsLabel.Position = [9 75 136 22];
            app.CustomCellStrutsLabel.Text = 'Custom Cell Struts:';

            % Create XSpinnerLabel_10
            app.XSpinnerLabel_10 = uilabel(app.Panel_2);
            app.XSpinnerLabel_10.HorizontalAlignment = 'right';
            app.XSpinnerLabel_10.Position = [119 47 25 22];
            app.XSpinnerLabel_10.Text = 'X:';

            % Create StartPointX
            app.StartPointX = uispinner(app.Panel_2);
            app.StartPointX.Step = 0.1;
            app.StartPointX.Limits = [-1 1];
            app.StartPointX.Enable = 'off';
            app.StartPointX.Position = [159 47 54 22];
            app.StartPointX.Value = -1;

            % Create StartPointmmLabel
            app.StartPointmmLabel = uilabel(app.Panel_2);
            app.StartPointmmLabel.FontColor = [0.149 0.149 0.149];
            app.StartPointmmLabel.Position = [13 47 96 22];
            app.StartPointmmLabel.Text = 'Start Point (mm):';

            % Create EndPointmmLabel
            app.EndPointmmLabel = uilabel(app.Panel_2);
            app.EndPointmmLabel.FontColor = [0.149 0.149 0.149];
            app.EndPointmmLabel.Position = [13 13 92 22];
            app.EndPointmmLabel.Text = 'End Point (mm):';

            % Create YLabel_13
            app.YLabel_13 = uilabel(app.Panel_2);
            app.YLabel_13.HorizontalAlignment = 'right';
            app.YLabel_13.FontColor = [0.149 0.149 0.149];
            app.YLabel_13.Position = [217 48 25 22];
            app.YLabel_13.Text = 'Y:';

            % Create StartPointY
            app.StartPointY = uispinner(app.Panel_2);
            app.StartPointY.Step = 0.1;
            app.StartPointY.Limits = [-1 1];
            app.StartPointY.Enable = 'off';
            app.StartPointY.Position = [257 48 54 22];
            app.StartPointY.Value = -1;

            % Create ZLabel_15
            app.ZLabel_15 = uilabel(app.Panel_2);
            app.ZLabel_15.HorizontalAlignment = 'right';
            app.ZLabel_15.FontColor = [0.149 0.149 0.149];
            app.ZLabel_15.Position = [314 48 25 22];
            app.ZLabel_15.Text = 'Z:';

            % Create StartPointZ
            app.StartPointZ = uispinner(app.Panel_2);
            app.StartPointZ.Step = 0.1;
            app.StartPointZ.Limits = [-1 1];
            app.StartPointZ.Enable = 'off';
            app.StartPointZ.Position = [354 48 54 22];
            app.StartPointZ.Value = -1;

            % Create XSpinnerLabel_11
            app.XSpinnerLabel_11 = uilabel(app.Panel_2);
            app.XSpinnerLabel_11.HorizontalAlignment = 'right';
            app.XSpinnerLabel_11.Position = [118 13 25 22];
            app.XSpinnerLabel_11.Text = 'X:';

            % Create EndPointX
            app.EndPointX = uispinner(app.Panel_2);
            app.EndPointX.Step = 0.1;
            app.EndPointX.Limits = [-1 1];
            app.EndPointX.Enable = 'off';
            app.EndPointX.Position = [158 13 54 22];
            app.EndPointX.Value = 1;

            % Create YLabel_14
            app.YLabel_14 = uilabel(app.Panel_2);
            app.YLabel_14.HorizontalAlignment = 'right';
            app.YLabel_14.FontColor = [0.149 0.149 0.149];
            app.YLabel_14.Position = [216 14 25 22];
            app.YLabel_14.Text = 'Y:';

            % Create EndPointY
            app.EndPointY = uispinner(app.Panel_2);
            app.EndPointY.Step = 0.1;
            app.EndPointY.Limits = [-1 1];
            app.EndPointY.Enable = 'off';
            app.EndPointY.Position = [256 14 54 22];
            app.EndPointY.Value = 1;

            % Create ZLabel_16
            app.ZLabel_16 = uilabel(app.Panel_2);
            app.ZLabel_16.HorizontalAlignment = 'right';
            app.ZLabel_16.FontColor = [0.149 0.149 0.149];
            app.ZLabel_16.Position = [313 14 25 22];
            app.ZLabel_16.Text = 'Z:';

            % Create EndPointZ
            app.EndPointZ = uispinner(app.Panel_2);
            app.EndPointZ.Step = 0.1;
            app.EndPointZ.Limits = [-1 1];
            app.EndPointZ.Enable = 'off';
            app.EndPointZ.Position = [353 14 54 22];
            app.EndPointZ.Value = 1;

            % Create AddStrut
            app.AddStrut = uibutton(app.Panel_2, 'state');
            app.AddStrut.ValueChangedFcn = createCallbackFcn(app, @AddStrutValueChanged, true);
            app.AddStrut.Enable = 'off';
            app.AddStrut.IconAlignment = 'right';
            app.AddStrut.Text = 'Add ';
            app.AddStrut.BackgroundColor = [1 1 1];
            app.AddStrut.FontWeight = 'bold';
            app.AddStrut.Position = [419 46 45 24];

            % Create HybridStructure
            app.HybridStructure = uiswitch(app.Panel_2, 'slider');
            app.HybridStructure.Items = {'Single', 'Combined'};
            app.HybridStructure.ValueChangedFcn = createCallbackFcn(app, @HybridStructureValueChanged, true);
            app.HybridStructure.FontColor = [0.149 0.149 0.149];
            app.HybridStructure.Position = [198 151 36 16];
            app.HybridStructure.Value = 'Single';

            % Create CellTopology2Label
            app.CellTopology2Label = uilabel(app.Panel_2);
            app.CellTopology2Label.FontColor = [0.149 0.149 0.149];
            app.CellTopology2Label.Tooltip = {'Select a topology to be combined from the dropdown'};
            app.CellTopology2Label.Position = [272 111 90 24];
            app.CellTopology2Label.Text = 'Cell Topology 2:';

            % Create Topology2
            app.Topology2 = uidropdown(app.Panel_2);
            app.Topology2.Items = {'BCC', 'BCC-Curved', 'Octet', 'FCC', 'FCC-Curved', 'DCC', 'Cubic', 'Octagon', 'Kelvin Cell', 'Butterfly-Curved', 'X-rods', 'Y-rods', 'Z-rods'};
            app.Topology2.ValueChangedFcn = createCallbackFcn(app, @Topology2ValueChanged, true);
            app.Topology2.Enable = 'off';
            app.Topology2.Tooltip = {''};
            app.Topology2.FontColor = [0.2 0.2 0.2];
            app.Topology2.BackgroundColor = [1 1 1];
            app.Topology2.Position = [419 109 115 27];
            app.Topology2.Value = 'BCC';

            % Create NumberOfStruts
            app.NumberOfStruts = uieditfield(app.Panel_2, 'text');
            app.NumberOfStruts.BusyAction = 'cancel';
            app.NumberOfStruts.Editable = 'off';
            app.NumberOfStruts.HorizontalAlignment = 'center';
            app.NumberOfStruts.FontColor = [0.2 0.2 0.2];
            app.NumberOfStruts.Enable = 'off';
            app.NumberOfStruts.Tooltip = {''};
            app.NumberOfStruts.Position = [448 13 58 22];
            app.NumberOfStruts.Value = '0';

            % Create RemoveStrut
            app.RemoveStrut = uibutton(app.Panel_2, 'state');
            app.RemoveStrut.ValueChangedFcn = createCallbackFcn(app, @RemoveStrutValueChanged, true);
            app.RemoveStrut.Enable = 'off';
            app.RemoveStrut.IconAlignment = 'right';
            app.RemoveStrut.Text = 'Remove';
            app.RemoveStrut.BackgroundColor = [1 1 1];
            app.RemoveStrut.FontWeight = 'bold';
            app.RemoveStrut.Position = [472 46 62 24];

            % Create Hollow
            app.Hollow = uiswitch(app.Panel_2, 'slider');
            app.Hollow.Items = {'Solid', 'Hollow'};
            app.Hollow.ValueChangedFcn = createCallbackFcn(app, @HollowValueChanged, true);
            app.Hollow.FontColor = [0.149 0.149 0.149];
            app.Hollow.Position = [436 151 36 16];
            app.Hollow.Value = 'Solid';

            % Create ImportCustomCell
            app.ImportCustomCell = uieditfield(app.Panel_2, 'text');
            app.ImportCustomCell.Editable = 'off';
            app.ImportCustomCell.FontSize = 10;
            app.ImportCustomCell.FontColor = [0.502 0.502 0.502];
            app.ImportCustomCell.Enable = 'off';
            app.ImportCustomCell.Position = [158 77 152 18];
            app.ImportCustomCell.Value = 'Import Custom Cell';

            % Create CustomBrowseButton
            app.CustomBrowseButton = uibutton(app.Panel_2, 'state');
            app.CustomBrowseButton.ValueChangedFcn = createCallbackFcn(app, @CustomBrowseButtonValueChanged, true);
            app.CustomBrowseButton.Enable = 'off';
            app.CustomBrowseButton.Text = 'Browse';
            app.CustomBrowseButton.BackgroundColor = [0.2588 0.5216 0.9608];
            app.CustomBrowseButton.FontSize = 10;
            app.CustomBrowseButton.Position = [317 77 45 18];

            % Create Panel_3
            app.Panel_3 = uipanel(app.StrutGeneratorTab);
            app.Panel_3.BackgroundColor = [1 1 1];
            app.Panel_3.Position = [27 22 542 313];

            % Create DensityControlLabel
            app.DensityControlLabel = uilabel(app.Panel_3);
            app.DensityControlLabel.BusyAction = 'cancel';
            app.DensityControlLabel.FontSize = 14;
            app.DensityControlLabel.FontWeight = 'bold';
            app.DensityControlLabel.FontColor = [0.2588 0.5216 0.9569];
            app.DensityControlLabel.Tooltip = {''};
            app.DensityControlLabel.Position = [13 284 117 22];
            app.DensityControlLabel.Text = 'Density Control';

            % Create ThicknessLabel
            app.ThicknessLabel = uilabel(app.Panel_3);
            app.ThicknessLabel.BusyAction = 'cancel';
            app.ThicknessLabel.Tooltip = {'Set the desired thickness value'};
            app.ThicknessLabel.Position = [9 249 94 22];
            app.ThicknessLabel.Text = 'Thickness (mm):';

            % Create thickness
            app.thickness = uispinner(app.Panel_3);
            app.thickness.Step = 0.1;
            app.thickness.Limits = [0.01 Inf];
            app.thickness.BusyAction = 'cancel';
            app.thickness.HorizontalAlignment = 'left';
            app.thickness.Tooltip = {''};
            app.thickness.Position = [158 249 58 22];
            app.thickness.Value = 1;

            % Create CellRelativeDensityLabel
            app.CellRelativeDensityLabel = uilabel(app.Panel_3);
            app.CellRelativeDensityLabel.BusyAction = 'cancel';
            app.CellRelativeDensityLabel.Tooltip = {'Set the desired relative density value to a number between 0 and 1'};
            app.CellRelativeDensityLabel.Position = [9 187 119 22];
            app.CellRelativeDensityLabel.Text = 'Cell Relative Density:';

            % Create relativeDensity
            app.relativeDensity = uispinner(app.Panel_3);
            app.relativeDensity.Step = 0.1;
            app.relativeDensity.Limits = [0.01 1];
            app.relativeDensity.ValueChangedFcn = createCallbackFcn(app, @relativeDensityValueChanged, true);
            app.relativeDensity.BusyAction = 'cancel';
            app.relativeDensity.HorizontalAlignment = 'left';
            app.relativeDensity.Enable = 'off';
            app.relativeDensity.Tooltip = {''};
            app.relativeDensity.Position = [159 186 58 22];
            app.relativeDensity.Value = 0.01;

            % Create Plot
            app.Plot = uibutton(app.Panel_3, 'state');
            app.Plot.ValueChangedFcn = createCallbackFcn(app, @PlotValueChanged, true);
            app.Plot.IconAlignment = 'right';
            app.Plot.Text = 'Generate';
            app.Plot.BackgroundColor = [0.2588 0.5216 0.9569];
            app.Plot.Position = [13 7 68 31];

            % Create ExportSTL
            app.ExportSTL = uibutton(app.Panel_3, 'push');
            app.ExportSTL.ButtonPushedFcn = createCallbackFcn(app, @ExportSTLButtonPushed, true);
            app.ExportSTL.BusyAction = 'cancel';
            app.ExportSTL.IconAlignment = 'right';
            app.ExportSTL.BackgroundColor = [0.2588 0.5216 0.9608];
            app.ExportSTL.Position = [102 7 76 31];
            app.ExportSTL.Text = 'Export STL';

            % Create Lamp
            app.Lamp = uilamp(app.Panel_3);
            app.Lamp.Position = [308 12 20 20];

            % Create LampLabel
            app.LampLabel = uilabel(app.Panel_3);
            app.LampLabel.Position = [333 9 118 26];
            app.LampLabel.Text = ' ';

            % Create Stop
            app.Stop = uibutton(app.Panel_3, 'state');
            app.Stop.ValueChangedFcn = createCallbackFcn(app, @StopValueChanged, true);
            app.Stop.Tooltip = {''};
            app.Stop.IconAlignment = 'right';
            app.Stop.Text = 'Stop';
            app.Stop.BackgroundColor = [0.9608 0.2588 0.2588];
            app.Stop.Position = [460 7 76 31];

            % Create EquationLabel
            app.EquationLabel = uilabel(app.Panel_3);
            app.EquationLabel.Tooltip = {'Set a grading pattern'};
            app.EquationLabel.Position = [9 116 150 24];
            app.EquationLabel.Text = 'Grading Equation:';

            % Create GradingEquation
            app.GradingEquation = uidropdown(app.Panel_3);
            app.GradingEquation.Items = {'Linear', 'Quadratic', 'Cubic', 'Circular', 'Exponential', 'Trigonometric - Sin', 'Trigonometric - Cosine'};
            app.GradingEquation.ValueChangedFcn = createCallbackFcn(app, @GradingEquationValueChanged, true);
            app.GradingEquation.Enable = 'off';
            app.GradingEquation.Tooltip = {''};
            app.GradingEquation.FontColor = [0.2 0.2 0.2];
            app.GradingEquation.BackgroundColor = [1 1 1];
            app.GradingEquation.Position = [161 117 158 22];
            app.GradingEquation.Value = 'Linear';

            % Create GradingFormula
            app.GradingFormula = uieditfield(app.Panel_3, 'text');
            app.GradingFormula.Editable = 'off';
            app.GradingFormula.HorizontalAlignment = 'center';
            app.GradingFormula.FontColor = [0.2 0.2 0.2];
            app.GradingFormula.Enable = 'off';
            app.GradingFormula.Tooltip = {''};
            app.GradingFormula.Position = [354 117 178 22];
            app.GradingFormula.Value = 'A + BX + CY + DZ';

            % Create CoefficientLabel
            app.CoefficientLabel = uilabel(app.Panel_3);
            app.CoefficientLabel.Tooltip = {'Adjust the coefficient of the selected grading equation to control the grading pattern'};
            app.CoefficientLabel.Position = [9 84 81 22];
            app.CoefficientLabel.Text = 'Coefficient:';

            % Create RelativePosition_grade
            app.RelativePosition_grade = uilabel(app.Panel_3);
            app.RelativePosition_grade.Tooltip = {'Define the starting position'};
            app.RelativePosition_grade.Position = [9 45 110 30];
            app.RelativePosition_grade.Text = 'Reference Position:';

            % Create curve_control
            app.curve_control = uispinner(app.Panel_3);
            app.curve_control.Limits = [0 Inf];
            app.curve_control.BusyAction = 'cancel';
            app.curve_control.HorizontalAlignment = 'left';
            app.curve_control.Enable = 'off';
            app.curve_control.Tooltip = {''};
            app.curve_control.Position = [161 152 58 22];
            app.curve_control.Value = 18;

            % Create ThicknessLabel_3
            app.ThicknessLabel_3 = uilabel(app.Panel_3);
            app.ThicknessLabel_3.BusyAction = 'cancel';
            app.ThicknessLabel_3.Tooltip = {'Set the desired curvature angle'};
            app.ThicknessLabel_3.Position = [9 151 82 22];
            app.ThicknessLabel_3.Text = 'Curve Control:';

            % Create ThicknessLabel_4
            app.ThicknessLabel_4 = uilabel(app.Panel_3);
            app.ThicknessLabel_4.BusyAction = 'cancel';
            app.ThicknessLabel_4.Tooltip = {'Set the desired thickness value'};
            app.ThicknessLabel_4.Position = [273 250 104 22];
            app.ThicknessLabel_4.Text = 'Thickness 2 (mm):';

            % Create thickness_grade_2
            app.thickness_grade_2 = uispinner(app.Panel_3);
            app.thickness_grade_2.Step = 0.1;
            app.thickness_grade_2.Limits = [0.01 Inf];
            app.thickness_grade_2.BusyAction = 'cancel';
            app.thickness_grade_2.HorizontalAlignment = 'left';
            app.thickness_grade_2.Enable = 'off';
            app.thickness_grade_2.Tooltip = {''};
            app.thickness_grade_2.Position = [421 250 58 22];
            app.thickness_grade_2.Value = 2.5;

            % Create RelativeDensity2Label
            app.RelativeDensity2Label = uilabel(app.Panel_3);
            app.RelativeDensity2Label.BusyAction = 'cancel';
            app.RelativeDensity2Label.Tooltip = {'Set the desired relative density value to a number between 0 and 1'};
            app.RelativeDensity2Label.Position = [273 187 129 22];
            app.RelativeDensity2Label.Text = 'Cell Relative Density 2:';

            % Create relativeDensity_grade_2
            app.relativeDensity_grade_2 = uispinner(app.Panel_3);
            app.relativeDensity_grade_2.Step = 0.1;
            app.relativeDensity_grade_2.Limits = [0.01 1];
            app.relativeDensity_grade_2.ValueChangedFcn = createCallbackFcn(app, @relativeDensity_grade_2ValueChanged, true);
            app.relativeDensity_grade_2.BusyAction = 'cancel';
            app.relativeDensity_grade_2.HorizontalAlignment = 'left';
            app.relativeDensity_grade_2.Enable = 'off';
            app.relativeDensity_grade_2.Tooltip = {''};
            app.relativeDensity_grade_2.Position = [421 186 58 22];
            app.relativeDensity_grade_2.Value = 0.01;

            % Create ALabel_5
            app.ALabel_5 = uilabel(app.Panel_3);
            app.ALabel_5.HorizontalAlignment = 'right';
            app.ALabel_5.Tooltip = {''};
            app.ALabel_5.Position = [125 83 25 22];
            app.ALabel_5.Text = 'A:';

            % Create coefficientA_grade
            app.coefficientA_grade = uispinner(app.Panel_3);
            app.coefficientA_grade.Enable = 'off';
            app.coefficientA_grade.Tooltip = {''};
            app.coefficientA_grade.Position = [161 83 55 22];

            % Create YLabel_15
            app.YLabel_15 = uilabel(app.Panel_3);
            app.YLabel_15.HorizontalAlignment = 'right';
            app.YLabel_15.Tooltip = {''};
            app.YLabel_15.Position = [218 83 25 22];
            app.YLabel_15.Text = 'B:';

            % Create coefficientB_grade
            app.coefficientB_grade = uispinner(app.Panel_3);
            app.coefficientB_grade.Enable = 'off';
            app.coefficientB_grade.Tooltip = {''};
            app.coefficientB_grade.Position = [256 83 55 22];
            app.coefficientB_grade.Value = 1;

            % Create ZLabel_17
            app.ZLabel_17 = uilabel(app.Panel_3);
            app.ZLabel_17.HorizontalAlignment = 'right';
            app.ZLabel_17.Tooltip = {''};
            app.ZLabel_17.Position = [313 83 25 22];
            app.ZLabel_17.Text = 'C:';

            % Create coefficientC_grade
            app.coefficientC_grade = uispinner(app.Panel_3);
            app.coefficientC_grade.Enable = 'off';
            app.coefficientC_grade.Tooltip = {''};
            app.coefficientC_grade.Position = [352 83 55 22];

            % Create ALabel_6
            app.ALabel_6 = uilabel(app.Panel_3);
            app.ALabel_6.HorizontalAlignment = 'right';
            app.ALabel_6.Tooltip = {''};
            app.ALabel_6.Position = [125 49 25 22];
            app.ALabel_6.Text = 'X:';

            % Create positionX_grade
            app.positionX_grade = uispinner(app.Panel_3);
            app.positionX_grade.Enable = 'off';
            app.positionX_grade.Tooltip = {''};
            app.positionX_grade.Position = [161 49 55 22];

            % Create YLabel_16
            app.YLabel_16 = uilabel(app.Panel_3);
            app.YLabel_16.HorizontalAlignment = 'right';
            app.YLabel_16.Tooltip = {''};
            app.YLabel_16.Position = [218 49 25 22];
            app.YLabel_16.Text = 'Y:';

            % Create positionY_grade
            app.positionY_grade = uispinner(app.Panel_3);
            app.positionY_grade.Enable = 'off';
            app.positionY_grade.Tooltip = {''};
            app.positionY_grade.Position = [256 49 55 22];

            % Create ZLabel_18
            app.ZLabel_18 = uilabel(app.Panel_3);
            app.ZLabel_18.HorizontalAlignment = 'right';
            app.ZLabel_18.Tooltip = {''};
            app.ZLabel_18.Position = [312 49 25 22];
            app.ZLabel_18.Text = 'Z:';

            % Create positionZ_grade
            app.positionZ_grade = uispinner(app.Panel_3);
            app.positionZ_grade.Enable = 'off';
            app.positionZ_grade.Tooltip = {''};
            app.positionZ_grade.Position = [352 49 55 22];

            % Create DensityType
            app.DensityType = uiswitch(app.Panel_3, 'slider');
            app.DensityType.Items = {'Uniform', 'Graded'};
            app.DensityType.ValueChangedFcn = createCallbackFcn(app, @DensityTypeValueChanged, true);
            app.DensityType.FontColor = [0.149 0.149 0.149];
            app.DensityType.Position = [437 287 36 16];
            app.DensityType.Value = 'Uniform';

            % Create ZLabel_19
            app.ZLabel_19 = uilabel(app.Panel_3);
            app.ZLabel_19.HorizontalAlignment = 'right';
            app.ZLabel_19.Tooltip = {''};
            app.ZLabel_19.Position = [410 84 25 22];
            app.ZLabel_19.Text = 'D:';

            % Create coefficientD_grade
            app.coefficientD_grade = uispinner(app.Panel_3);
            app.coefficientD_grade.Enable = 'off';
            app.coefficientD_grade.Tooltip = {''};
            app.coefficientD_grade.Position = [449 84 55 22];

            % Create DensityControl
            app.DensityControl = uiswitch(app.Panel_3, 'slider');
            app.DensityControl.Items = {'Thickness', 'Relative Density'};
            app.DensityControl.ValueChangedFcn = createCallbackFcn(app, @DensityControlValueChanged, true);
            app.DensityControl.FontColor = [0.149 0.149 0.149];
            app.DensityControl.Position = [217 287 36 16];
            app.DensityControl.Value = 'Thickness';

            % Create ThicknessLabel_5
            app.ThicknessLabel_5 = uilabel(app.Panel_3);
            app.ThicknessLabel_5.BusyAction = 'cancel';
            app.ThicknessLabel_5.Tooltip = {'Set the desired thickness value'};
            app.ThicknessLabel_5.Position = [9 217 123 22];
            app.ThicknessLabel_5.Text = 'Inner-Outer-Dia (mm):';

            % Create InnerDiameter
            app.InnerDiameter = uispinner(app.Panel_3);
            app.InnerDiameter.Step = 0.1;
            app.InnerDiameter.Limits = [0.01 Inf];
            app.InnerDiameter.BusyAction = 'cancel';
            app.InnerDiameter.HorizontalAlignment = 'left';
            app.InnerDiameter.Enable = 'off';
            app.InnerDiameter.Tooltip = {''};
            app.InnerDiameter.Position = [137 217 58 22];
            app.InnerDiameter.Value = 1;

            % Create OuterDiameter
            app.OuterDiameter = uispinner(app.Panel_3);
            app.OuterDiameter.Step = 0.1;
            app.OuterDiameter.Limits = [0.01 Inf];
            app.OuterDiameter.BusyAction = 'cancel';
            app.OuterDiameter.HorizontalAlignment = 'left';
            app.OuterDiameter.Enable = 'off';
            app.OuterDiameter.Tooltip = {''};
            app.OuterDiameter.Position = [202 217 58 22];
            app.OuterDiameter.Value = 2.5;

            % Create ThicknessLabel_6
            app.ThicknessLabel_6 = uilabel(app.Panel_3);
            app.ThicknessLabel_6.BusyAction = 'cancel';
            app.ThicknessLabel_6.Tooltip = {'Set the desired thickness value'};
            app.ThicknessLabel_6.Position = [274 217 133 22];
            app.ThicknessLabel_6.Text = 'Inner-Outer-Dia 2 (mm):';

            % Create InnerDiameter2
            app.InnerDiameter2 = uispinner(app.Panel_3);
            app.InnerDiameter2.Step = 0.1;
            app.InnerDiameter2.Limits = [0.01 Inf];
            app.InnerDiameter2.BusyAction = 'cancel';
            app.InnerDiameter2.HorizontalAlignment = 'left';
            app.InnerDiameter2.Enable = 'off';
            app.InnerDiameter2.Tooltip = {''};
            app.InnerDiameter2.Position = [407 217 58 22];
            app.InnerDiameter2.Value = 1.5;

            % Create OuterDiameter2
            app.OuterDiameter2 = uispinner(app.Panel_3);
            app.OuterDiameter2.Step = 0.1;
            app.OuterDiameter2.Limits = [0.01 Inf];
            app.OuterDiameter2.BusyAction = 'cancel';
            app.OuterDiameter2.HorizontalAlignment = 'left';
            app.OuterDiameter2.Enable = 'off';
            app.OuterDiameter2.Tooltip = {''};
            app.OuterDiameter2.Position = [469 217 58 22];
            app.OuterDiameter2.Value = 2.5;

            % Create SaveCustom
            app.SaveCustom = uibutton(app.Panel_3, 'push');
            app.SaveCustom.ButtonPushedFcn = createCallbackFcn(app, @SaveCustomButtonPushed, true);
            app.SaveCustom.BusyAction = 'cancel';
            app.SaveCustom.IconAlignment = 'right';
            app.SaveCustom.BackgroundColor = [0.2588 0.5216 0.9608];
            app.SaveCustom.Enable = 'off';
            app.SaveCustom.Position = [198 7 87 31];
            app.SaveCustom.Text = 'Save Custom';

            % Create Panel_12
            app.Panel_12 = uipanel(app.StrutGeneratorTab);
            app.Panel_12.BackgroundColor = [1 1 1];
            app.Panel_12.Position = [27 334 542 72];

            % Create NumberofGridpointsSpinnerLabel_4
            app.NumberofGridpointsSpinnerLabel_4 = uilabel(app.Panel_12);
            app.NumberofGridpointsSpinnerLabel_4.FontColor = [0.149 0.149 0.149];
            app.NumberofGridpointsSpinnerLabel_4.Tooltip = {'Specify the number of gridpoints for generating the plot'};
            app.NumberofGridpointsSpinnerLabel_4.Position = [8 14 122 22];
            app.NumberofGridpointsSpinnerLabel_4.Text = 'Number of Gridpoints:';

            % Create Gridpoints
            app.Gridpoints = uispinner(app.Panel_12);
            app.Gridpoints.Limits = [0 Inf];
            app.Gridpoints.Position = [159 14 54 22];
            app.Gridpoints.Value = 30;

            % Create CurvepointsLabel
            app.CurvepointsLabel = uilabel(app.Panel_12);
            app.CurvepointsLabel.FontColor = [0.149 0.149 0.149];
            app.CurvepointsLabel.Tooltip = {'Specify the number of gridpoints for generating the plot'};
            app.CurvepointsLabel.Position = [272 14 132 22];
            app.CurvepointsLabel.Text = 'Number of Curvepoints:';

            % Create Curvepoints
            app.Curvepoints = uispinner(app.Panel_12);
            app.Curvepoints.Enable = 'off';
            app.Curvepoints.Position = [420 14 54 22];
            app.Curvepoints.Value = 20;

            % Create ResolutionControlLabel
            app.ResolutionControlLabel = uilabel(app.Panel_12);
            app.ResolutionControlLabel.FontSize = 14;
            app.ResolutionControlLabel.FontWeight = 'bold';
            app.ResolutionControlLabel.FontColor = [0.2588 0.5216 0.9569];
            app.ResolutionControlLabel.Position = [11 43 162 28];
            app.ResolutionControlLabel.Text = 'Resolution Control';

            % Create Panel_13
            app.Panel_13 = uipanel(app.StrutGeneratorTab);
            app.Panel_13.BorderType = 'none';
            app.Panel_13.BackgroundColor = [0.9608 0.9608 0.9608];
            app.Panel_13.Position = [600 16 458 71];

            % Create ExactRelativeDensityLabel_4
            app.ExactRelativeDensityLabel_4 = uilabel(app.Panel_13);
            app.ExactRelativeDensityLabel_4.BusyAction = 'cancel';
            app.ExactRelativeDensityLabel_4.Tooltip = {'The exact relative density of the structure is displayed here'};
            app.ExactRelativeDensityLabel_4.Position = [8 7 221 37];
            app.ExactRelativeDensityLabel_4.Text = 'Volume (cm^3):';

            % Create LatticeVolume
            app.LatticeVolume = uieditfield(app.Panel_13, 'text');
            app.LatticeVolume.BusyAction = 'cancel';
            app.LatticeVolume.Editable = 'off';
            app.LatticeVolume.HorizontalAlignment = 'center';
            app.LatticeVolume.FontColor = [0.2 0.2 0.2];
            app.LatticeVolume.Enable = 'off';
            app.LatticeVolume.Tooltip = {''};
            app.LatticeVolume.Position = [117 15 80 22];

            % Create ExactRelativeDensityLabel_5
            app.ExactRelativeDensityLabel_5 = uilabel(app.Panel_13);
            app.ExactRelativeDensityLabel_5.BusyAction = 'cancel';
            app.ExactRelativeDensityLabel_5.Tooltip = {'The exact relative density of the structure is displayed here'};
            app.ExactRelativeDensityLabel_5.Position = [248 40 221 37];
            app.ExactRelativeDensityLabel_5.Text = 'Number of Nodes: ';

            % Create Nodes
            app.Nodes = uieditfield(app.Panel_13, 'text');
            app.Nodes.BusyAction = 'cancel';
            app.Nodes.Editable = 'off';
            app.Nodes.HorizontalAlignment = 'center';
            app.Nodes.FontColor = [0.2 0.2 0.2];
            app.Nodes.Enable = 'off';
            app.Nodes.Tooltip = {''};
            app.Nodes.Position = [383 49 76 22];

            % Create ExactRelativeDensityLabel_6
            app.ExactRelativeDensityLabel_6 = uilabel(app.Panel_13);
            app.ExactRelativeDensityLabel_6.BusyAction = 'cancel';
            app.ExactRelativeDensityLabel_6.Tooltip = {'The exact relative density of the structure is displayed here'};
            app.ExactRelativeDensityLabel_6.Position = [8 40 221 37];
            app.ExactRelativeDensityLabel_6.Text = 'Runtime (secs):';

            % Create Runtime
            app.Runtime = uieditfield(app.Panel_13, 'text');
            app.Runtime.BusyAction = 'cancel';
            app.Runtime.Editable = 'off';
            app.Runtime.HorizontalAlignment = 'center';
            app.Runtime.FontColor = [0.2 0.2 0.2];
            app.Runtime.Enable = 'off';
            app.Runtime.Tooltip = {''};
            app.Runtime.Position = [117 48 80 22];

            % Create ExactRelativeDensityLabel_7
            app.ExactRelativeDensityLabel_7 = uilabel(app.Panel_13);
            app.ExactRelativeDensityLabel_7.BusyAction = 'cancel';
            app.ExactRelativeDensityLabel_7.Tooltip = {'The exact relative density of the structure is displayed here'};
            app.ExactRelativeDensityLabel_7.Position = [248 6 228 37];
            app.ExactRelativeDensityLabel_7.Text = 'Exact Relative Density';

            % Create exactRelativeDensity
            app.exactRelativeDensity = uieditfield(app.Panel_13, 'text');
            app.exactRelativeDensity.BusyAction = 'cancel';
            app.exactRelativeDensity.Editable = 'off';
            app.exactRelativeDensity.HorizontalAlignment = 'center';
            app.exactRelativeDensity.FontColor = [0.2 0.2 0.2];
            app.exactRelativeDensity.Enable = 'off';
            app.exactRelativeDensity.Tooltip = {''};
            app.exactRelativeDensity.Position = [383 16 76 22];

            % Create SummaryLabel
            app.SummaryLabel = uilabel(app.StrutGeneratorTab);
            app.SummaryLabel.BusyAction = 'cancel';
            app.SummaryLabel.HorizontalAlignment = 'center';
            app.SummaryLabel.FontSize = 14;
            app.SummaryLabel.FontWeight = 'bold';
            app.SummaryLabel.FontColor = [0.2588 0.5216 0.9569];
            app.SummaryLabel.Tooltip = {''};
            app.SummaryLabel.Position = [771 91 117 22];
            app.SummaryLabel.Text = 'Summary';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = StrutPlot

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end