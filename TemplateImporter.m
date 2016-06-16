function Template = TemplateImporter(Index)

[~,All_Patterns]=xlsread('InputT.xlsx');
All_Patterns = All_Patterns(2:end,2);
if Index ==0
    Template = All_Patterns;
else
    Template = All_Patterns{Index};
end

end