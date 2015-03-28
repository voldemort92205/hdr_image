function [g, lnE] = mysolve(z, b, l, w)
	n = 256;
	A = zeros(size(z,1) * size(z,2)+n+1, n+size(z,1));
	b = zeros(size(A,1), 1);

	k = 1;
	for i = 1:size(z,1)
		for j = 1:size(z,2)
			wij = w(z(i,j)+1);
			A(k,z(i,j)+1) = wij;
			A(k,n+i) = -wij;
			b(i,j) = wij * b(j);
			k = k+1;
		end
	end
	
	A(k,129) = 1;
	k = k+1;

	for i = 1:n-2
		A(k,i) = l * w(i+1);
		A(k,i+1) = -2 * l * w(i+1);
		A(k,i+2) = l * w(i+1);
		k = k + 1;
	end

	x = A \ b;
	g = x(1:n);
	ln = x(n+1:size(x,1));
end