function usps_imshow(uspsdata,x,y)
%usps_imshow shows the images of uspadata in x rows y columns
%   
%   usps_imshow(USPSDATA,X,Y)
%   
%   November 10, 2016, by HanzheTeng

% check if uspsdata is correct
[row,col] = size(uspsdata);
if col~=256 
    error('This is not the USPS data set.');
end

% check if uspsdata is enough to show
total = x*y;
exceed = 0;
if row<total   
    total = row;
    exceed = 1;
    x = floor(row/y);
    y_left = mod(row,y);
end

% reshape 256-dimensional vectors into 16*16 matrices
imdata = zeros(16*x,16*y);
for i=1:x
    for j=1:y
        imdata((i-1)*16+1:i*16,(j-1)*16+1:j*16) = reshape(uspsdata((i-1)*y+j,:),16,16)';
    end
end

 % if exceeded, reshape the last row
if exceed==1   
    i = i+1;
    for k=1:y_left
        imdata((i-1)*16+1:i*16,(k-1)*16+1:k*16) = reshape(uspsdata((i-1)*y+k,:),16,16)';
    end
end

% show the images
imshow(imdata)
title(['A total of ',num2str(total),' images in this USPS dataset']);
xlabel([num2str(i),' Rows ',num2str(y),' Columns']);

end % End of function usps_imshow
