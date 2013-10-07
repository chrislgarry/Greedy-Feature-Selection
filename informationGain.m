function [information_gain] = informationGain(pixel_positions, train_threes,train_fives)
    input = {[0 0]};
    input{1}(1) = sub2ind(size(train_threes), pixel_positions(1,1), pixel_positions(1,2));
    input{1}(2) = sub2ind(size(train_threes), pixel_positions(2,1), pixel_positions(2,2));
    information_gain = mikPixelsClass(input, train_threes,train_fives) - miPixelClass({[pixel_positions(2,1) pixel_positions(2,2)]},train_threes,train_fives);
end