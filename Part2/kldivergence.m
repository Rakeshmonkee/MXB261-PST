%% KL divergence through sampling

LAMBDA = 4;
k = 0:15; 


% poisspdf from external libray / toolbox (statitics and machine learning) i think.
truePMF = poisspdf(k, LAMBDA);
truePMF = truePMF / sum(truePMF); 

% Sample sizes 
sampleSizes = [10, 25, 50, 100, 175, 250];
numExperiments = 100;

klDivergenceMean = zeros(length(sampleSizes),1);
klDivergenceSe = zeros(length(sampleSizes),1);

% sampling and klDivergence
for s = 1:length(sampleSizes)
    N = sampleSizes(s);
    klDivergenceValues = zeros(numExperiments,1);
    
    for exp = 1:numExperiments
        % Inverse transform sampling
        cdf = cumsum(truePMF);
        u = rand(N,1);
        samples = arrayfun(@(x) k(find(cdf >= x, 1)), u);
        
        % emperical PMF
        empericalCounts = histcounts(samples, -0.5:15.5);
        empericalPmf = empericalCounts / sum(empericalCounts);
        empericalPmf = max(empericalPmf, 1e-10); % remvoe log issue
        
        % klDivergence
        klDivergenceValues(exp) = sum(truePMF .* log(truePMF ./ empericalPmf));
    end
    
    % Mean and standard error
    klDivergenceMean(s) = mean(klDivergenceValues);

    % using SE = std(KL values)/sqrt(nbr of experiments)

    klDivergenceSe(s) = std(klDivergenceValues)/sqrt(numExperiments);
end

% Figure 1: Mean klDivergence with error bars
figure;
errorbar(sampleSizes, klDivergenceMean, klDivergenceSe);
xlabel('Sample size');
ylabel('Mean klDivergence');
title('klDivergence vs Sample Size');
grid on;

% Figure 2: True vs emperical PMF
figure;
%loop through all sample sizes
for s = 1:length(sampleSizes)
    N = sampleSizes(s);
    
    % Sample one example emperical PMF
    cdf = cumsum(truePMF);
    u = rand(N,1);
    samplesExample = arrayfun(@(x) k(find(cdf >= x,1)), u);
    
    empericalCounts = histcounts(samplesExample, -0.5:15.5);
    empericalPmfExample = empericalCounts / sum(empericalCounts);
    
    subplot(2,3,s);
    bar(k-0.2, truePMF, 0.4, 'FaceColor', 'green'); hold on;
    bar(k+0.2, empericalPmfExample, 0.4, 'FaceColor', 'red');
    xlabel('k'); ylabel('Probability');
    title(['Sample size = ', num2str(N)]);
    legend('True PMF', 'emperical PMF');
    grid on;
end
