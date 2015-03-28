function [Image] = grayScale (input, output)
	image = imread (input);
	[row, col, height] = size(image);
%	Image = (54 * double(image (:, :, 1)) + 183 * double(image (:, :, 2)) + 19 * double(image (:, :, 3))) / 256;
	Image = rgb2gray(image);
	Image = mtbFunction(Image);
	imwrite (Image, output);
end
