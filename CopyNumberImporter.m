function [CopyNumber,Coverage] = CopyNumberImporter(Read_Index, Template_Index)

[Values,Genomes]=xlsread('InputCN.xlsx');
Genomes=Genomes(2:end,1);
CoverageValues = Values(2:end,1);
Values = Values(2:end,2:end);

Genome_Index = [];
for i = 1:length(Genomes)
    if not(strcmp(Genomes{i},''))
        Genome_Index = [Genome_Index i];
    end
end

Coverage = [];
CopyNumber = [];
if Read_Index==0 && Template_Index==0
    for i = Genome_Index
        CopyNumber = [CopyNumber;repmat(Values(i,2:end),Values(i,1),1)];
        Coverage = [Coverage;repmat(CoverageValues(i),Values(i,1),1)];
    end
elseif Read_Index==0
    for i = Genome_Index
        CopyNumber = [CopyNumber;repmat(Values(i,Template_Index+1),Values(i,1),1)];
        Coverage = [Coverage;repmat(CoverageValues(i),Values(i,1),1)];
    end
elseif Template_Index==0
    Counter = 0;
    for i = Genome_Index
        Counter = Counter + Values(i,1);
        if Counter >= Read_Index
            CopyNumber = Values(i,2:end);
            Coverage = CoverageValues(i);
            break
        end
    end
else
    Counter = 0;
    for i = Genome_Index
        Counter = Counter + Values(i,1);
        if Counter >= Read_Index
            CopyNumber = Values(i,Template_Index+1);
            Coverage = CoverageValues(i);
            break
        end
    end
end

Number_of_Templates = size(Values,2)-1;
Number_of_Genomes = size(CopyNumber,1);

end
