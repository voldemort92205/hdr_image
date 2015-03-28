clear all
close all


%sample test is rain.jpg

%const
lambda = 1;
weight = ones(256, 1);
B = ones (256, 1);

pixel = 256;
picked = 75;



%use for loop to convert many image to gray scale
[filename, savedname] = textread ('image.txt', '%s %s');
n = size(filename, 1);
for i = 1:n
	tmp = grayScale(filename{i}, savedname{i});
	[row, col] = size(tmp);
	grayImages(i, 1:row, 1:col) = tmp;
end
%alias
%record the range of each picture
resize = zeros(n, 4);
%for test

for i = 1:(n-1)
	[x, y] = alignment (grayImages(i,:, :), grayImages(i+1, :, :));
end



%calculage function
%open image


%for r, g, b
gf = zeros(3, pixel);
lnE = zeros(3, picked);

%read all images
for i = 1:n
	I1 = imread (filename{i});
	[row, col, height] = size(I1);
	range = row * col;
	images(i, 1:row, 1:col, 1:height) = I1;
end
start = randi ([1, range-100], 1, 1);



%calculate g and ln(E)
input = zeros(picked, n);
for k = 1:3
	for i = 1:n
		tmp = images(i, :, :, k);
		input(:, i) = tmp (start:(start+picked-1))';
	end
	[gf(k,:), lnE(k,:)] = mysolve(input, B, lambda, weight);	
end


%plot (1:pixel, gf(1, :), 1:pixel, gf(2, :), 1:pixel, gf(3,:));

