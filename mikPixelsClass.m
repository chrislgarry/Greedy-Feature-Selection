function [mutual_information] = mikPixelsClass(pixel_pos, train_threes, train_fives)

    %% Initialize vars
    num_features = size(pixel_pos{1},2);
    threes_feature_values = zeros(num_features, 50); % Pixel values in set of threes at feature coord
    fives_feature_values = zeros(num_features, 50);  % Pixel values in set of threes at feature coord
    feature_likelihoods_threes = zeros(1,2^num_features);
    feature_likelihoods_fives = zeros(1,2^num_features);
    possible_feature_vals = zeros(num_features, 2^num_features);
    %% Generate all permutations of feature values for n pixel positions
    binary_feature_values = dec2bin(0:((2^num_features)-1));
    possible_feature_vals = (((binary_feature_values - '0')*255)+0.5)';
    
    %Convert cell array input to matrix of pixel values
    %pixel_pos = cell2mat(pixel_positions);
    %% Get actual values of the n features in all 50 images (row = feature, col = image)
    pixel_mat = zeros(size(pixel_pos{1},2),2);
    
    for x=1:size(pixel_pos{1},2)
        [X Y] = ind2sub(size(train_threes), pixel_pos{1}(x));
        pixel_mat(x,:) = [X Y];
    end
    
    for i=1:num_features
        threes_feature_values(i,:) = train_threes(pixel_mat(i,1),pixel_mat(i,2),:);
        fives_feature_values(i,:)  = train_fives(pixel_mat(i,1),pixel_mat(i,2),:);
    end
    
    %% Compute likelihoods of all feature permutations in class labels
    for x =1:2^num_features
        count_threes = 0;
        count_fives = 0;
        for i=1:50
            if threes_feature_values(:,i) == possible_feature_vals(:,x)
                count_threes = count_threes + 1;
            end
            if fives_feature_values(:,i) == possible_feature_vals(:,x)
                count_fives = count_fives + 1;
            end
        end
        %Likelihood is out of all classes, so divide by 100
        feature_likelihoods_threes(x) = count_threes/100;
        feature_likelihoods_fives(x) = count_fives/100;
    end

    feature_likelihoods_all = feature_likelihoods_threes + feature_likelihoods_fives;
    %% MUTUAL INFO FOR THREES CLASS
        mutual_information = sum(feature_likelihoods_threes(feature_likelihoods_threes ~=0).*...
            log2((feature_likelihoods_threes(feature_likelihoods_threes ~=0))./((feature_likelihoods_all(feature_likelihoods_threes ~=0))*0.5)));
    %% MUTUAL INFO FOR FIVES + THREES
        mutual_information = mutual_information + sum(feature_likelihoods_fives(feature_likelihoods_fives~=0).*...
            log2((feature_likelihoods_fives(feature_likelihoods_fives~=0))./((feature_likelihoods_all(feature_likelihoods_fives~=0))*0.5)));
end