
function runWalks()
    tic
    % cases in a struct to group each related values for each biased walk
    cases = {
        %case 1 - 4
        struct('s',1/3,'w',1/3,'e',1/3,'name','(i) s=1/3, w=1/3, e=1/3'),
        struct('s',2/3,'w',1/6,'e',1/6,'name','(ii) s=2/3, w=1/6, e=1/6'),
        struct('s',3/5,'w',3/10,'e',1/10,'name','(iii) s=3/5, w=3/10, e=1/10'),
        struct('s',3/5,'w',1/10,'e',3/10,'name','(iv) s=3/5, w=1/10, e=3/10')
    };

    % figure 1
    % loop through 4 times plotting each given case for each figure
    figure('Name','Figure 1: P = 1, N = 100');
   
    for i = 1:4
        nexttile;
        plotWalks(gca, 100, 1, cases{i}.s, cases{i}.w, cases{i}.e, cases{i}.name);
    end
    sgtitle('Figure 1: P = 1, N = 100');

    % figure 2
    figure('Name','Figure 2: P = 1, N = 200');
    for i = 1:4
        nexttile;
        plotWalks(gca, 200, 1, cases{i}.s, cases{i}.w, cases{i}.e, cases{i}.name);
    end
    sgtitle('Figure 2: P = 1, N = 200');

    % figure 3
    figure('Name','Figure 3: P = rand, N = 100');
    for i = 1:4
        nexttile;
        plotWalks(gca, 100, 'rand', cases{i}.s, cases{i}.w, cases{i}.e, cases{i}.name);
    end
    sgtitle('Figure 3: P = rand,  N = 100');

    % figure 4
    figure('Name','Figure 4: P = rand, N = 200');
    for i = 1:4
        nexttile;
        plotWalks(gca, 200, 'rand', cases{i}.s, cases{i}.w, cases{i}.e, cases{i}.name);
    end
    sgtitle('Figure 4: P = rand,  N = 200');
    toc

end