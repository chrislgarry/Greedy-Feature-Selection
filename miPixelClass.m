function [mutual_information] = miPixelClass(pixel_position, train_threes,train_fives)
    three = 0.5; %Probability of label being three
    five = 0.5;  %Probability of label being five
    
    pixel_pos = pixel_position{1};
    on_and_three  = sum(train_threes(pixel_pos(1),pixel_pos(2),:) == 255.5)/100;
    on_and_five   = sum(train_fives(pixel_pos(1),pixel_pos(2),:) == 255.5)/100;
    off_and_three = sum(train_threes(pixel_pos(1),pixel_pos(2),:) == 0.5)/100;
    off_and_five  = sum(train_fives(pixel_pos(1),pixel_pos(2),:) == 0.5)/100;
    
    on_and_any = on_and_three + on_and_five;
    off_and_any = off_and_three + off_and_five;
    
    if on_and_any == 0, on_and_any = 0.5; end
    if off_and_any == 0, off_and_any = 0.5; end
    
    term1 = (on_and_three *log2(on_and_three/(on_and_any*three)));
    term2 = (on_and_five  *log2(on_and_five/(on_and_any*five)));
    term3 = (off_and_three*log2(off_and_three/(off_and_any*three)));
    term4 = (off_and_five *log2(off_and_five/(off_and_any*five)));
    
    if on_and_three == 0, term1 = 0; end
    if on_and_five == 0, term2 = 0; end
    if off_and_three == 0, term3 = 0; end
    if off_and_five == 0, term4 = 0; end
    
    mutual_information = term1 + term2 + term3 + term4;
end