function [img_result] = binariser(img, seuil)
    img_result = zeros(size(img));
    for i = 1:size(img, 1)
        for j = 1:size(img, 2)
            if img(i,j) < seuil
                img_result(i,j) = 0;
            else
                img_result(i,j) = 255;
            end
        end
    end            
end