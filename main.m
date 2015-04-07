clear all
close all

[filename, time] = textread ('image.txt', '%s %f');
n = size(filename, 1);

B = zeros(n, 1);
for i = 1:n
	B(i) = time(i);
end
B = log(B);


%calculage function
lamdba = 125;
weight = ones(256, 1);
weight(1:128) = 1:1:128;
weight(129:256) = 128:-1:1;

pixel = 256;    %Z0 ~ Z255, total 256
picked = 64;

%for r, g, b
gf = zeros(pixel, 3);
lnE = zeros(picked, 3);
%read all images
for i = 1:n
	I1 = imread (filename{i});
	[row, col, height] = size(I1);
	range = row * col;
	images(i, 1:row, 1:col, 1:height) = I1;
end
[num, row, col, height] = size(images);

%calculate g and ln(E)
input = zeros(picked, n);
for k = 1:3
	for i = 1:n
		tmp = images(i,(int64(row/2) -4 ):(int64(row/2+3)), (int64(col/2)-4):(int64(col/2)+3), k);
		input (:, i) = reshape(tmp, 64, 1); 
	end
	%mysolve is provided in teacher's lecture
	[gf(:, k), lnE(:, k)] = mysolve(input, B, lamdba, weight);	
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




%output HDR image
hdrwrite(output, 'result.hdr');
rgb = tonemap(output, 'AdjustLightness', [0.001, 1.0], 'AdjustSaturation', 9);

%show tone mapping image
figure(1);
imshow(rgb);
print ('-dpng', 'result.png');




%the response curve of the curve
figure(2);
for i = 1:3
	subplot (2, 2, i);
	switch i
	case 1
		plot (gf(:, i), 0:1:255, 'r.');
		title ('red');
	case 2
		plot (gf(:, i), 0:1:255, 'g.');
		title ('green');
	case 3
		plot (gf(:, i), 0:1:255, 'b.');
		title ('blue');
	end
	set (gca, 'ytick', [0:25:300]);
	xlabel ('log Expouse X');
	ylabel ('Pixel value Z');

end
subplot (2, 2, 4)
plot (gf(:,1), 0:1:255, 'r.', gf(:,2), 0:1:255, 'g.', gf(:,3), 0:1:255, 'b.');
legend ('Red', 'Green', 'Blue');
title ('Red vs Green vs Blue');
xlabel ('log Expouse X');
ylabel ('Pixel value Z');

print ('-dpng', 'curve.png');

