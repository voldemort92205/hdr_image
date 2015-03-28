clear all
close all


%sample test is rain.jpg

%const
lambda = 1;
weight = ones(256, 1);

pixel = 256;
picked = 64;



[filename, savedname] = textread ('image.txt', '%s %s');
n = size(filename, 1);
B = log([8, 5, 2.5, 1, 0.5, 0.25, 1/8, 1/15, 1/30, 1/60, 1/320]);

for i = 1:n
	tmp = grayScale(filename{i}, savedname{i});
	[row, col] = size(tmp);
	grayImages(i, 1:row, 1:col) = tmp;
end
%alias

%TODO


%calculage function

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
[num, row, col, height] = size(images);

%calculate g and ln(E)
input = zeros(picked, n);
for k = 1:3
	for i = 1:n
		tmp = images(i,(int64(row/2) -4 ):(int64(row/2+3)), (int64(col/2)-4):(int64(col/2)+3), k);
		input (:, i) = reshape(tmp, 64, 1); 
%		tmp = images(i, :, :, k);
%		input(:, i) = tmp (start:(start+picked-1))';
	end
	[gf(k,:), lnE(k,:)] = mysolve(input, B, lambda, weight);	
end


%plot (1:pixel, exp(gf(1, :)), 1:pixel, exp(gf(2, :)), 1:pixel, exp(gf(3,:)));
plot (1:pixel, exp(gf(1, :)));
title ('Red');
ylabel('g');


