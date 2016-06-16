function [Template_Coverage,Internal_Coverage] = HammingCoverage(Template,Read,Error_Bound)
%Output covered part of a template (or its rotations) by a read

Read_Length = length(Read);
Template_Length  = length(Template);
Template_Coverage = zeros(1,Template_Length);
Internal_Coverage = 0;

% Template longer or equal to Read
if Template_Length >= Read_Length
    % rotate through Template positions
    for k = 1:Template_Length
        Rotation = Template([k:Template_Length 1:k-1]);
        Distance  = 0;
        % Compute distance
        for i = 1:Read_Length
            if Read(i) ~= Rotation(i)
                Distance = Distance + 1;
            end
            % skip the rest of the matching if found enough mismatches
            if Distance > Error_Bound
                break
            end
        end
        % if ended up having less than threshold of mismatches, ignore other rotations and return the corresponding Coverage
        if Distance <= Error_Bound
            Internal_Coverage = Read_Length - Distance;
            % when shuold increment middle part of the template coverage
            if Read_Length+k-1 <= Template_Length
                Template_Coverage(k:k+Read_Length-1) = 1;
                % when should increment end and begining part of template coverage
            else
                Template_Coverage([1:k+Read_Length-Template_Length-1 k:Template_Length]) = 1;
            end
            break
        end
    end

else
    % Template shorter than Read
    % rotate through Template positions
    for k = 1:Template_Length
        Rotation = Template([k:Template_Length 1:k-1]);
        
        % forward Read check (similar to the first scenario)
        Distance  = 0;
        for i = 1:Template_Length
            if Read(i) ~= Rotation(i)
                Distance = Distance + 1;
            end
            % skip the rest of the matching if found enough mismatches
            if Distance > Error_Bound
                break
            end
        end
        
        % scoring coverage
        if Distance <= Error_Bound
            % score what u already know is matched (score even mismatches whithin error bound !)
            Template_Coverage(1:Template_Length) = 1;
            Internal_Coverage = Template_Length;
            % enumerate matches and add them to coverage one by one (allow no gaps !)
            for i = Template_Length+1:Read_Length
                % equivalent of Read index for Template
                j = mod(i-1,Template_Length)+1;
                if Read(i) == Rotation(j)
                    Template_Coverage(k+j-1) = Template_Coverage(k+j-1) + 1;
                    Internal_Coverage = Internal_Coverage + 1;
                else
                    Distance = Distance + 1;
                end
                if Distance > Error_Bound
                    break
                end
            end
        end
        
        % backward Read check
        Rotation = fliplr(Rotation);
        Read = fliplr(Read);
        % Template_Coverage = fliplr(Template_Coverage);
        Distance  = 0;
        for i = 1:Template_Length
            if Read(i) ~= Rotation(i)
                Distance = Distance + 1;
            end
            % skip the rest of the matching if found enough mismatches
            if Distance > Error_Bound
                break
            end
        end
        % scoring coverage
        if Distance <= Error_Bound
            % score what u already know is matched (score even mismatches whithin error bound !)
            Template_Coverage(1:Template_Length) = 1;
            Internal_Coverage = Template_Length;
            % enumerate matches and add them to coverage one by one (allow no gaps !)
            for i = Template_Length+1:Read_Length
                % equivalent of Read index for Template
                j = mod(i-1,Template_Length)+1;
                h = mod(k-i-1,Template_Length)+1;
                if Read(i) == Rotation(j)
                    Template_Coverage(h) = Template_Coverage(h) + 1;
                    Internal_Coverage = Internal_Coverage + 1;
                else
                    Distance = Distance + 1;
                end
                if Distance > Error_Bound
                    break
                end
            end
        end
        % Template_Coverage = fliplr(Template_Coverage);
        Rotation = fliplr(Rotation);
        Read = fliplr(Read);
    end
end

end
