% helper function to plot the walks
function plotWalks(ax, N, P, s, w, e, titleStr)
    [heights] = simulateWalks(N, P, s, w, e, 99);
    axes(ax);
    bar(1:99, heights, 'BarWidth', 1.0);
    xlim([1 99]); % 99xlimit grid but + 2 on y axis to make graph easier to read
    ylim([0 max(1, max(heights)+2)]);
    xlabel('bins') 
    ylabel('height')
    title(titleStr);
    grid on;
end