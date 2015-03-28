clear all
close all


%sample test is rain.jpg

%const
lambda = 1;
weight = ones(256, 1);
B = ones (256, 1);

n = 1;
pixel = 256;
picked = 75;



%use for loop to convert many image to gray scale
filename = 'rain.png';
%grayScale(filename, 'test.png');
length = size(filename);
pictures(1, 1:length(2)) = filename;

%alias


%calculage function
%open image


%for r, g, b
gf = zeros(3, pixel);
lnE = zeros(3, picked);


	I1 = imread (pictures(1,:));
	[row, col, height] = size(I1);
	range = row * col;
	start = randi ([1, range-100], 1, 1);

input = zeros(picked, n);
for k = 1:3
	for i = 1:n
		tmp = I1(:, :, k);
		input(:, i) = tmp (start:(start+picked-1))';
	end
	[gf(k,:), lnE(k,:)] = mysolve(input, B, lambda, weight);	
end


%plot (1:pixel, gf(1, :), 1:pixel, gf(2, :), 1:pixel, gf(3,:));

