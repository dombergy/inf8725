function c_dft = showImgAndDft(img)
    gr_img = rgb2gray(img);
    fft_gr_img = Centered_DFT(gr_img);
    figure;
    subplot(1,2,1), imshow(img)
    title('Image grayscale')
    subplot(1,2,2), imshow(log(1 + abs(fft_gr_img)),[])
    title('Image TFD')
    c_dft = fft_gr_img;
end