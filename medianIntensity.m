function median = medianIntenstiy(image)
	[row, col, height] = size(image);
	total = 0;
	for k = 1:3
		for j = 1:col
			total = total + sum(double(image(:, j, k)));
		%	total = total + sum(double(image(:, j, k))+ double(image(:, j, k)) + double(image(:, j, k))) / 256;
		end
	end

	median = total / (3 * row * col);
end
