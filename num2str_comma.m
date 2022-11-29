% num2str_comma

% Ver 2.00 - correcting for numbers with decimal points

function return_string = num2str_comma(get_number)

    %If there are decimal point - save it aside.
    dec_point = get_number-floor(get_number);
    dec_point_s = num2str(dec_point);
    
    get_number = floor(get_number);
    
    get_number_s = fliplr(num2str(get_number));
    
    comma_zeros = num2str(floor(log10(get_number)-2));
    return_string = get_number_s;
    
    switch comma_zeros
        case {'1' '2' '3'}
            return_string = strcat(get_number_s(1:3), ',', get_number_s(4:end));
        case {'4' '5' '6'}
            return_string = strcat(get_number_s(1:3), ',', get_number_s(4:6), ',', get_number_s(7:end));
        case {'7' '8' '9'}
            return_string = strcat(get_number_s(1:3), ',', get_number_s(4:6), ',', get_number_s(7:9), ',', get_number_s(10:end));
        case {'10' '11' '12'}
            return_string = strcat(get_number_s(1:3), ',', get_number_s(4:6), ',', get_number_s(7:9), ',', get_number_s(10:12), ',',  get_number_s(13:end));
    end;
    return_string = strcat(fliplr(return_string), dec_point_s(2:end));
end

        





