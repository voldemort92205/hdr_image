clear all
close all


%sample test is rain.jpg

filename = 'rain.png';
I1 = imread(filename);
[row, col, height] = size(I1);
median = medianIntensity (I1);

%convert to gray scale

for i = 1:row
	for j = 1:col
		tmp = sum(double(I1(i, j, :))) / 3 ;
		if tmp < median
			I1(i, j, :) = 0;
		else
			I1(i, j, :) = 255;
		end
	end
end
imwrite(I1, 'test.png');
