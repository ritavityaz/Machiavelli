clc
clear all

%% Settings

Error_Bound = 20;
Real_Copy_Number = 4
Genome_Coverage = 73.4;
[~, Reads, ~] = fastqread('ERR550670_1.fastq');
Template = 'GCCGGTGAGCGAGCGCGCGTAGCGGGGGAGCGAACGGCGCAGTTGGCACCA';

%% Import Data

[Template,Template_Length] = StringToVector(Template);
[Reads,Read_Length] = StringToVector(Reads);

%%%% Toy Example %%%%
% Reads = [1 2 3 3 0 0;
%          1 2 3 5 1 1;
%          2 3 4 1 1 0;
%          5 3 4 1 2 3;
%          3 3 2 3 2 0];
% Template = [1 2 3 4];
% Genome_Coverage = 1;
% Real_CopyNumber = 1;

%% Algorithm

Number_Reads = size(Reads,1);
Internal_Coverage = 0;
for i = 1:Number_Reads
    Read = Reads(i,:);
    Read = Read(Read~=0);
    Read_Length = length(Read);
    Read_Internal_Coverage = 0;
    for k = 1:Template_Length
        Rotation = Template([k:Template_Length 1:k-1]);
        Rotation = repmat(Rotation,1,ceil(Read_Length/Template_Length));
        Distance  = 0;
        for i = 1:Read_Length
            if Read(i) ~= Rotation(i)
                Distance = Distance + 1;
            end
            if Distance > Error_Bound
                break
            end
        end
        if Distance <= Error_Bound
            Read_Internal_Coverage = max(Read_Length - Distance,Read_Internal_Coverage);
        end
    end
    Internal_Coverage = Internal_Coverage + Read_Internal_Coverage;
end
Internal_Copy_Number = Internal_Coverage./(Genome_Coverage*Template_Length')
