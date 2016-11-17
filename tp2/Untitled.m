houseImage = imread('NewHouse.png');
houseImageGray = rgb2gray(houseImage);
TFDShifted = fftshift(fft2(houseImageGray));

H = fspecial('gaussian', size(TFDShifted), 22);
fftFiltered = TFDShifted .* H / max(max(H));

figure;
imshow(log(1 + abs(fftFiltered)), []);

imgfiltre = uint8(ifft2(ifftshift(fftFiltered)));
figure;
imshow(imgfiltre);
title('House Image Gaussien');