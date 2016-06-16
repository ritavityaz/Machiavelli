
%% Settings
clc
clear all

Directory = 'C:\Users\Leonardo\Desktop\CNDataset'; cd(Directory)
Read_Files_Tag = 'SAMEA';
Error_Bound = 10;
Genome_Index = 5;
Template_Index = 7;

%% Import Data

% Read_Matrix = ReadImporter(Genome_Index,Read_Files_Tag);
[~, Reads, ~] = fastqread('SAMEA2533380.fastq');
Template_Matrix = TemplateImporter(Template_Index);
[Real_CNV,Genome_Coverage] = CopyNumberImporter(Genome_Index, Template_Index);
[Template_Matrix,~] = StringToVector(Template_Matrix);
[Read_Matrix,~] = StringToVector(Reads);

%%%% Toy Example %%%%
% Read_Matrix = [1 2 3 3 0 0;
%                1 2 3 5 1 1;
%                2 3 4 1 1 0;
%                5 3 4 1 2 3;
%                3 3 2 3 2 0];
% Template_Matrix = [1 2 3 4];
% 
% Genome_Coverage = 1;
% Real_CNV = [1 1]';

%% Algorithm

Number_Reads = size(Read_Matrix,1);
[Number_Templates,Longest_Template] = size(Template_Matrix);

Template_Coverage = zeros(Number_Templates,Longest_Template);
Internal_Coverage = zeros(Number_Templates,1);

for j = 1:Number_Templates
    Template = Template_Matrix(j,:);
    Template = Template(Template~=0);
    Template_Length(j) = length(Template);
    for i = 1:Number_Reads
        Read = Read_Matrix(i,:);
        Read = Read(Read~=0);
        [Read_Template_Coverage,Read_Internal_Coverage] = HammingCoverage(Template,Read,Error_Bound);
        Template_Coverage(j,1:length(Read_Template_Coverage)) = Template_Coverage(j,1:length(Read_Template_Coverage)) + Read_Template_Coverage;
        Internal_Coverage(j) = Internal_Coverage(j) + Read_Internal_Coverage;
    end
end

% Template_Coverage
Template_CNV = mean(Template_Coverage,2)/Genome_Coverage;
Internal_CNV = Internal_Coverage./(Genome_Coverage*Template_Length');
% [Internal_CNV Template_CNV Real_CNV]
