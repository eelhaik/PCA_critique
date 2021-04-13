%% EuroBunny
close all; clear all; clc;
global Labels;

disp('#7 Pairwise comparisons');
%Can PCA be used to decide whether two populations overlap or not? In other
%words, does overlap mean shared genetic origins.

[input_file_excel input_dir_excel Data_ Labels]= Load_Database_final('Lazaridis_1kg_AJ_full');

%% Get the records for Africans, Asians, Europeans, and AJs
Pop1_codes = [1016 1195 1044 1046 1052 1056 1059 1060 1063 1062 1065 1066 1067 1068 1069 1070 1071 1079 1080 1081 1082 1083 1098 1099 1114 1125 1141 1155 1156 1157 ...
1158 1159 1160 1161 1162 1163 1164 1202 1200 1182 1183 1184 1185 1186]; Pop1_indexes = (Labels.Pop_code==Pop1_codes); 
Pop2_codes = [1006]; Pop2_indexes = (Labels.Pop_code==Pop2_codes); %
Pop3_codes = [1084]; Pop3_indexes = (Labels.Pop_code==Pop3_codes); %
Pop4_codes = [1210]; Pop4_indexes = (Labels.Pop_code==Pop4_codes); %
% Pop5_codes = [1113]; Pop5_indexes = (Labels.Pop_code==Pop5_codes); %
% Pop6_codes = [1197]; Pop6_indexes = (Labels.Pop_code==Pop6_codes); %
% Pop7_codes = [1085]; Pop7_indexes = (Labels.Pop_code==Pop7_codes); %

% Find the smallest population
Sample_sizes = (([sum(sum(Pop1_indexes)) sum(sum(Pop2_indexes)) sum(sum(Pop3_indexes)) sum(sum(Pop4_indexes)) ]));

% Sample_sizes = (([sum(sum(Pop1_indexes)) sum(sum(Pop2_indexes)) sum(sum(Pop3_indexes)) sum(sum(Pop4_indexes)) sum(sum(Pop5_indexes)) sum(sum(Pop6_indexes)) sum(sum(Pop7_indexes))]));
Min_Sample_sizes = min(Sample_sizes);

% Sample_indexes = [sum(Pop1_indexes,2)>0 sum(Pop2_indexes,2)>0 sum(Pop3_indexes,2)>0 sum(Pop4_indexes,2)>0 sum(Pop5_indexes,2)>0 sum(Pop6_indexes,2)>0 sum(Pop7_indexes,2)>0];
Sample_indexes = [sum(Pop1_indexes,2)>0 sum(Pop2_indexes,2)>0 sum(Pop3_indexes,2)>0 sum(Pop4_indexes,2)>0];

disp([sum(Sample_indexes)]); 

pops_for_legend = [];
figure

    n=[750 200 50 0]; 
    Pop_indexes = Find_n_indexes(Sample_indexes, n);
    Pop_indexes = Pop_indexes(:);
    Pop_indexes(Pop_indexes==0) = [];
    pops_for_legend = [pops_for_legend' Pop_indexes(:)']';

    [SCORE, ~, pcvars] = pca1(Data_(Pop_indexes,:));
    
    CalculatePCA_pops_plot(SCORE, pcvars, Labels, Pop_indexes(:), 0);

maximize

% print('-dtiff', 'd:\Bunny.tif', '-r600'); close;
% RemoveWhiteSpace([], 'file', 'd:\Bunny.tif', 'output', 'd:\Bunny_clear.tif');
    