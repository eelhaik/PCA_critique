% pca_projection

% Projecting new color
% In order to represent a new point in the principal component space created by the original data, there are two steps:
% 1.  Subtract the mean of the original data from the new point.
% 2.  Multiply the result by the coefficients of the principle components.

% M_ is the new dataset to be projected on M.
% M is the original dataset

% M_ = single(Data_clear(PopA_indexes(:), Fewer_SNPs));
% M = single(Data_clean(:, Fewer_SNPs));

function [y, Y]= pca_projection(M_, M, handle_missingness)

    if nargin==2
        handle_missingness=0;
    end;
    
    threshold = 0.3;

    %pca_projection doesn't like data without a variation
    [~,c1] = find(var(M_,1)==0);
    [~,c2] = find(var(M,1)==0);
    
    disp(['pca_projection: Removing ' num2str(numel([c1 c2])) ' out of ' num2str(numel(M(:))./min(size(M)))]);
    M_(:,[c1 c2])=[];
    M(:,[c1 c2])=[];

    %Here, M is being centered and standardized.
    %PCA returns the principal components based on the correlation matrix.
    %Note, this function cannot take NaN
    [W, Y] = pca(M, 'VariableWeights', 'variance', 'Centered', true);
%     plot(Y(:,1), Y(:,2),'.')

    % Calculate the orthonormal coefficient matrix (check that W*W' = I)
    W = diag(std(M))\W;

    % Getting mean and weights of data (for M_)
    [~, mu, sigma] = zscore(M);
    sigma(sigma==0) = 1;

    % New point in the original system
    x = M_;
    x = bsxfun(@minus,x, mu);
    x = bsxfun(@rdivide, x, sigma);

    % New coordinates as principal components
%     y0 = Y(1,:); % point we should get in result

    %handle missing values
    if handle_missingness
        disp('Removing missing columns...')
        indexes_to_remove = (sum(~isnan(x))./size(x,1)) < threshold;
        x(:,indexes_to_remove) = [];
        W(indexes_to_remove,:) = [];
        disp([num2str(size(W,1)) ' columns remained']);

        %impute missing values in x
        disp('Imputing the missing values in the remaining columns...');
        for i=1:size(x,2)
            curr_x = x(:,i);
            values_to_impute = unique(curr_x(~isnan(curr_x)));
            num_of_values_to_impute = numel(curr_x(isnan(curr_x)));
            p = randsample(numel(values_to_impute), num_of_values_to_impute, 1);
            
            curr_x(isnan(curr_x)) = values_to_impute(p);
            x(:,i) = curr_x;
        end;
    end;
    
    y = (x*W); % our result
    
    if isempty(y)
        error_message('pca_projection: y is empty');
    end;
end