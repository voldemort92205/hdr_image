clear all
close all


%sample test is rain.jpg
n = 1;

%use for loop to convert many image to gray scale
filename = 'rain.png';
%grayScale(filename, 'test.png');
length = size(filename);
pictures(1, 1:length(2)) = filename;

%alias


%calculage function
%open image
lambda = 1;
weight = ones(256, 1);
I1 = imread (pictures(1,:));
for k = 1:3
	for i = 1:n
		input = I1(:, :, i);
	end
	[gR, lnE] = mysolve(input, lambda, weight);
		
end



%[g, lnE] = mysolve (I1, )
