function [mtb] = mtbFunction (images)
	[row, col] = size(images);
	mtb = images;
	%tmp = sum(images(i, :, :));
	%	tmp = sum(tmp(1, 1, :));
	tmp = sum(sum(double(images))');
	average = tmp / (row*col);
	below = find (images < average);
	above = find (images >= average);
	mtb(below) = 0;
	mtb(above) = 255;
end
