clear all
close all


%sample test is rain.jpg

%const
outputName = 'project1.hdr';

[filename, savedname] = textread ('image.txt', '%s %s');
n = size(filename, 1);



%no alignment



%for i = 1:n
%	tmp = grayScale(filename{i}, savedname{i});
%	[row, col] = size(tmp);
%	grayImages(i, 1:row, 1:col) = tmp;
%end
%alias

%TODO

%calculage function
lambda = 55;
weight = ones(256, 1);
weight(1:128) = 1:1:128;
weight(129:256) = 128:-1:1;

B = log([8, 5, 2.5, 1, 0.5, 0.25, 1/8, 1/15, 1/30, 1/60, 1/320]);
pixel = 256;
picked = 64;


%for r, g, b
gf = zeros(pixel, 3);
lnE = zeros(picked, 3);
n = 11 ;
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
	end
	[gf(:, k), lnE(:, k)] = mysolve(input, B, lambda, weight);	
end

%construct HDR radaince map
output = zeros(row, col, height);
for k = 1:3
	for j = 1:col
		for i = 1:row
			total1 = 0;
			total2 = 0;
			for m = 1:n
				total1 = total1 + weight(images(m, i, j, k)+1) * (gf(images(m, i, j, k)+1)-B(m));
				total2 = total2 + weight(images(m, i, j, k)+1);
			end
			output(i, j, k) = exp(total1 / total2);
		end
	end
end
hdrwrite(output, outputName);
rgb = tonemap(output);
figure(1);
imshow(rgb);
print ('-dpng', 'project1.png');
%draw picture

figure(2);
for i = 1:3
	subplot (2, 2, i);
	switch i
	case 1
		plot (0:1:255, gf(:, i), 'r.');
		title ('red');
	case 2
		plot (0:1:255, gf(:, i), 'g.');
		title ('green');
	case 3
		plot (0:1:255, gf(:, i), 'b.');
		title ('blue');
	end
	set (gca, 'xtick', [0:25:300]);

end
print ('-dpng', 'curve.png');

