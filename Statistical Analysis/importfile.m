function S = importfile(workbookFile, sheetName, startRow, endRow)
%% Input handling
% this function imports the data from exel files

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 3
    startRow = 2;
    endRow = 1000;
end

%% Import the data

% Read the data without specifying variable names and types
S2 = readtable(workbookFile, 'Sheet', sheetName, 'Range', ['A' num2str(startRow) ':S' num2str(endRow)]);

%% Assign variable names and types

variableNames = {'index', 'R_actual', 'C_actual', 'TW_start_actual', 'A_actual', 'NS_actual', 'TW_delay_interval', 'TW_duration_interval', 'R_C_interval', 'C_A_interval', 'TW_A_interval', 'A_NS_interval', 'C_NS_interval', 'C_clock_actual', 'A_clock_actual', 'NS_clock_actual', 'AS_played', 'perceive_type', 'perceived_time'};
variableTypes = {'char', 'double', 'double', 'double', 'double', 'double', 'double', 'double', 'double', 'double', 'double', 'double', 'double', 'double', 'double', 'double', 'char', 'char', 'double'};

S2.Properties.VariableNames = matlab.lang.makeValidName(variableNames);
% for i = 1:numel(variableNames)
%     if strcmp(variableTypes{i}, 'char') && isstring(S2.(variableNames{i}))
%         S2.(variableNames{i}) = cellstr(S2.(variableNames{i}));
%     end
%     S2.(variableNames{i}) = cast(S2.(variableNames{i}), variableTypes{i});
% end

end
