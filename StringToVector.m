function [Matrix,Lengths] = StringToVector(Array)

if iscellstr(Array)
    
    Elements = length(Array);
    for i = 1:Elements
        Lengths(i) = numel(Array{i});
    end
    
    Matrix = zeros(Elements,max(Lengths));
    for i = 1:Elements
        String = Array{i};
        String = strrep(String, 'A', '1 ');
        String = strrep(String, 'C', '2 ');
        String = strrep(String, 'G', '3 ');
        String = strrep(String, 'T', '4 ');
        String = strrep(String, 'N', '5 ');
        Vector = str2num(String);
        Matrix(i,1:length(Vector)) = Vector;
    end
    
else
    Lengths = numel(Array);
    Array = strrep(Array, 'A', '1 ');
    Array = strrep(Array, 'C', '2 ');
    Array = strrep(Array, 'G', '3 ');
    Array = strrep(Array, 'T', '4 ');
    Array = strrep(Array, 'N', '5 ');
    Matrix = str2num(Array);    
end

end