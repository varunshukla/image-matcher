%prompt = 'Do you want more? Y/N [Y]: ';
%str = input(prompt,'s');
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
find = input('Enter the image name you want to search in database.\n','s');
findi = imread(find);
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
        k = int64(max(C(:)));
        if k == 1
            index = arri;
            flag = 1;
            break;
        end
    end
end
flag
if flag == 1
    fprintf('Image found.\n');
%     figure;
    imshowpair(findi , index, 'montage');
else
    fprintf('Image not present\n');
    imshow(find);
end
