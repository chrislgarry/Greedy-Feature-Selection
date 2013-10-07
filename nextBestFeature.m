function [next_best] = nextBestFeature(chosen_features, train_threes,train_fives)
    
    [I, J] = ind2sub(size(train_threes),[1:128*128]);
    all_pixels_cell = mat2cell(cat(1, I, J)', ones(1,128*128), 2);
    gain_array = zeros(1,128*128);
    
    
    for i=1:size(all_pixels_cell,1) 
        temp = zeros(1, size(chosen_features, 1));
        for x=1:size(chosen_features, 1)
            temp(x) = informationGain([chosen_features(x,:); all_pixels_cell{i}],train_threes,train_fives);
        end
        gain_array(i) = min(temp); 
    end
    
    [I J] = max(gain_array);
    next_best = J;
end