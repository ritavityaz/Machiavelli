function Reads = ReadImporter(Index,Tag)

File_List = dir;
Num_Files = length(File_List);
for i = Num_Files:-1:1
    if not(strncmpi(File_List(i).name,Tag,5))
        File_List(i) = [ ];
    end
end
if Index == 0
    Num_Files = length(File_List);
    Reads = cell(1,Num_Files);
    for i = 1:length(File_List)
        [~, Sequence, ~] = fastqread(File_List(i).name);
        Reads{i} = Sequence;
    end
else
    [~, Reads, ~] = fastqread(File_List(Index).name);
end

end