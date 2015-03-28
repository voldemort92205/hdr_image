function [g, lnE] = mysolve(images, B, lamdba, weight)
	[row, num] = size(images);
	n = 256;
	A = zeros((row*num+n+1), row+n);
	b = zeros(size(A,1), 1);
	k = 1;
	for j = 1:num
		for i = 1:row
			wij = weight(images(i,j)+1);
			A(k,images(i,j)+1) = wij;
			A(k,n+i) = -wij;
			b(k+1) = wij * B(j);

			k = k + 1;
		end
	end
	A(k,129) = 1;
	k = k + 1;
	for i = 1:n-2
		A(k,i) = lamdba * weight(i+1);
		A(k,i+1) = -2 * lamdba * weight(i+1);
		A(k,i+2) = lamdba * weight(i+1);
		k = k + 1;
	end
	x = A \ b;
	g = x(1:n);
	lnE = x(n+1:size(x,1));
end
