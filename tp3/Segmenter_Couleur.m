function segImg = Segmenter_Couleur(img,LUT_R,LUT_G,LUT_B)
    % Extraire chaque couleur separement
    R = img(:,:,1);
    G = img(:,:,2);
    B = img(:,:,3);
    
    % Creer de nouvelles composantes selon les LUT transmises
    R_seg = intlut(R,LUT_R);
    G_seg = intlut(G,LUT_G);
    B_seg = intlut(B,LUT_B);
    
    segImg = cat(3,R_seg,G_seg,B_seg);
end