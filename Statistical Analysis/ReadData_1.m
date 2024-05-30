function S=ReadData(add,sheetname)
%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
   Workbook: C:\Users\Sajjad\Dropbox\Projects\On Going\Ahmad\Data\20210215-060612-110.xls
   Worksheet: Condition 1
%
% Auto-generated by MATLAB on 10-Jun-2021 04:27:05

%% Setup the Import Options
opts = spreadsheetImportOptions("NumVariables", 18);

% Specify sheet and range
opts.Sheet = sheetname;
opts.DataRange = "A2:R170";

% Specify column names and types
opts.VariableNames = ["index", "R_actual", "C_actual", "TW_start_actual", "A_actual", "NS_actual", "TW_delay_interval", "TW_duration_interval", "R_C_interval", "C_A_interval", "TW_A_interval", "A_NS_interval", "C_NS_interval", "C_clock_actual", "A_clock_actual", "NS_clock_actual", "perceive_type", "perceived_time"];
opts.VariableTypes = ["string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "categorical", "double"];
opts = setvaropts(opts, 1, "WhitespaceRule", "preserve");
opts = setvaropts(opts, [1, 17], "EmptyFieldRule", "auto");

% Import the data
S = readtable(add, opts, "UseExcel", false);


%% Clear temporary variables
clear opts
end