function [x, y] = alignment (image1, image2)
	
	errorMax = 100;
	[num1, row1, col1] = size(image1);
	[num2, row2, col2] = size(image2);
	row = max(row1, row2);
	col = max(col1, col2);

	%use for xor
	picture1 = zeros(row1, col1);
	picture2 = zeros(row2, col2);
	tmp = find(image1(1,:,:) == 255);
	picture1(tmp) = 1;
	tmp = find(image2(1,:,:) == 255);
	picture2(tmp) = 1;
	
	
	delta = 0;
	colMaxRange = col;
	rowMaxRange = row;
	theBest = [-1, -1, -1, -1];
	%right shift
	while range < (min(col, row)/2)
		for j = 1:col-colMaxRange+1
			for i = 1:row-rowMaxRange+1
				
			end		
		end
		break;
	end

	




	x = 0;
	y = 0;
end
