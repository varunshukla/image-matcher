clc;
clear all;
num = input('Enter the number of images you have in database.\n');
fprintf('Please make sure that all the images are present in the same directory where the script is running.\n');
arr = cell(num,1);
flag = 0;
prompt = 'Please enter the image name along with extension\n';
for i = 1:num
    arr{i} = input( prompt, 's');
end
findo = input('Enter the image name you want to search in database.\n','s');
findi = imread(findo);
%findr2g = rgb2gray(findi);
[rows, columns, numberOfColorChannels] = size(findi);
if numberOfColorChannels > 1
    findr2g = rgb2gray(findi);
else
    % It's already gray scale.  No need to convert.
    findr2g = findi;
end
for i = 1:num
    arri = imread(arr{i});
    %arrr2g = rgb2gray(arri);
    [rows_arr, columns_arr, ColorChannels] = size(arri);
    if rows > rows_arr || columns > columns_arr
        continue;
    else
        if ColorChannels > 1
            arrr2g = rgb2gray(arri);
        else
            % It's already gray scale.  No need to convert.
            arrr2g = arri;
        end

        C = normxcorr2(findr2g , arrr2g);
        [ypeak, xpeak] = find(C==max(C(:)));
        k = int64(max(C(:)));
        if k == 1
            index = arri;
            flag = 1;
            break;
        end
    end
end
yoffSet = ypeak-size(findr2g,1);
xoffSet = xpeak-size(findr2g,2);

hFig = figure;
hAx  = axes;
if flag == 1
    fprintf('Image found.\n');
%     imshowpair(index,findi, 'montage');
    imshow(arrr2g,'Parent', hAx);
    imrect(hAx, [xoffSet+1, yoffSet+1, size(findr2g,2), size(findr2g,1)]);
else
    fprintf('Image not present\n');
    imshow(findo);
end
