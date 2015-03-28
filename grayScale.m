function grayScale (input, output)

	image = imread (input);
	median = medianIntensity (image);
	[row, col, height] = size(image);
	for j = 1:col
		for i = 1:row
			tmp = sum(double(image(i, j, :))) / 3;
			if tmp < median
				image(i, j, :) = 0;
			else
				image(i, j, :) = 255;
			end
		end
	end
	imwrite (image, output);
end
