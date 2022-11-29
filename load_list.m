% load_list

% Load a list with 1 column of strings, header is options
function list = load_list(input_filename, header, num_of_cols)
    
    if nargin==1
        header=0;
        num_of_cols=1;
    elseif nargin==2
        num_of_cols=1;
    end;
    
    if num_of_cols==1
        fid_rel = fopen(input_filename);
        list = textscan(fid_rel,'%s', 'delimiter', '\t', 'headerlines',header);
        fclose(fid_rel);
    elseif num_of_cols==2
        fid_rel = fopen(input_filename);
        list = textscan(fid_rel,'%s %s', 'delimiter', '\t', 'headerlines',header);
        fclose(fid_rel);        
    elseif num_of_cols==3
        fid_rel = fopen(input_filename);
        list = textscan(fid_rel,'%s %s %s', 'delimiter', '\t', 'headerlines',header);
        fclose(fid_rel);        
    elseif num_of_cols==4
        fid_rel = fopen(input_filename);
        list = textscan(fid_rel,'%s %s %s %s', 'delimiter', '\t', 'headerlines',header);
        fclose(fid_rel);        
    end;
end


