% helper function to simulate walks
function [heights, occupied] = simulateWalks(N, P, s, w, e, gridSize)
  

    probability = [s, w, e]; probability / sum(probability);
    s = probability(1); %probability of south
    w = probability(2); %probability of west
    e = probability(3); %probability of east

    occupied = false(gridSize); 
    L = gridSize;                    
    % loop through each biased walk N amount of times (100/200)
    for k = 1:N
            % if P is a 1, start biased walk at column 50
        if isequal(P, 1) || (ischar(P) && strcmpi(P, '1'))
            column = 50;
            % if P is random (rand) assigned in plot walks func in
            % runWalks.m, choose a random column to start at (1,99)
        elseif (ischar(P) && strcmpi(P,'rand')) || (isstring(P) && lower(P)=="rand")
            column = randi(L);
        end
        row = 1;             

        if occupied(row, column)
            continue;
        end

        while true
            if row == L
                occupied(row, column) = true;
                break;
            end

            westColumn = column - 1; 
            if westColumn < 1 
               westColumn = L; 
            end
            eastColumn = column + 1; 
            if eastColumn > L
               eastColumn = 1; 
            end
            westoccupied = occupied(row, westColumn);
            eastoccupied = occupied(row, eastColumn);

            while true
                r = rand;
                if r < s
                    dir = 'S';
                    break;
                elseif r < s + w
                    if not(westoccupied) % if True
                        dir = 'W';
                        break;
                    else

                    end
                else
                    if not(eastoccupied) % if True
                        dir = 'E';
                        break;

                    end
                end
            end

            if dir == 'S'

                if occupied(row+1, column)
                    occupied(row, column) = true;
                    break;
                else
                    row = row + 1;
                end
            elseif dir == 'W'
                column = westColumn;
            else % going east, 'E'
                column = eastColumn;
            end
        end
    end

    heights = sum(occupied, 1)';
    
end


