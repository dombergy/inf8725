function [R,G,B] = Split_Couleurs(img)
    % Extraire chaque couleur separement
    R = img(:,:,1);
    G = img(:,:,2);
    B = img(:,:,3);
end