type Filtre_Canny.m;
type Calculer_Precision.m;
type ObtenirLUT.m;
type Segmenter_Couleur.m;
type Split_Couleurs.m;
%% Exercice 1: Restauration d’image
% Numero 1
%Charger l'image
voiture = imread('Formula_Ford.png');
%Afficher l'image
figure()
imshow(voiture)
title('Image originale')

%Numéro 2
% h = fspecial('motion', len, theta): len = 30 et theta = 0 ce qui
% équivaut à une motion horizontal de 30 pixels
% Les valeurs de 31 et 24 ont été obtenues par essai-erreur
h = fspecial('motion', 31, 24);

%Numéro 3
nouvelleImage = deconvwnr(voiture, h, 0);
%Afficher l'image
figure()
imshow(nouvelleImage)
title('Filtre inverse')

% Même s'il est difficile de visualiser quoi que ce soit sur l'image
% obtenue, on peut remarquer la silhouette de la voiture et l'impression
% que nous avons est que le déplacement de 30pixels à été effectué et
% résulte en une série de barre verticale. L'image possède beaucoup de
% bruit et est probablement le résultat d'un paramètre qui n'est pas
% adéquat (voir K, comme K est le ratio du bruit et du signal, la valeur 0
% n'est pas adéquate, car il est faux de prétendre qu'il n'y a pas de
% bruit dans l'image).  

%Numéro 4
noise_var = 1e-3;
I = im2double(voiture);
estimated_nsr = noise_var / var(I(:));

%Numéro 5
plaqueVisible = deconvwnr(voiture, h, estimated_nsr);
%Afficher l'image
figure()
imshow(plaqueVisible)
title('Image plaque visible')
%Le numéro de la plaque du criminel est FF12FMC

%% Exercice 2: Segmentation d’image
%Numéro 1
%Charger l'image
escalier = imread('escaliers.jpg');
%Afficher l'image
figure()
imshow(escalier)
title('Image escalier')

%Numéro 2
gaussien = fspecial('gaussian', 3, 0.5);
resultat = Filtre_Canny(escalier, gaussien ,20);
figure()
imshow(resultat)
title('Image Filtre Canny')

%Numéro 3

%Numéro 4
escalierReference = imread('escaliers_TrueSeg.jpg') > 128;
resultat = Filtre_Canny(escalier, gaussien, 79);
[Performance, TPF, TFN] = Calculer_Precision(resultat, escalierReference);

%On remarque en faisant varier le seuil que sa valeur optimale oscille
%autour de 79. En effet, lors de notre première utilisation du filtre
%Canny, nous utlisions un seuil de 20 qui nous paraissait donner un
%résultat convenable. Suite à l'analyse, nous avons passer d'une
%performance de 19.41% à 27.26% en  passant d'une seuil de 20 à 79. Nous
%acceptions ainsi trop de faux contours.

% Numero 5

% TODO

%% Exercice 3: Segmentation par couleur

% Numero 1
%Charger l'image
figure();
chateau = imread('chateau.jpg');
imshow(chateau);
title('Chateau original');
% Numero 2
% Voir ObtenirLUT.m

% Numero 3
% Voir Segmenter_Couleur.m

% Numero 4
LUT = ObtenirLUT(8);
% On utilise la meme LUT pour chaque couleur puisqu'il y a 8 segments pour
% chaque couleur
chateau_seg = Segmenter_Couleur(chateau,LUT,LUT,LUT);
figure();
imshow(chateau_seg);
title('Chateau segmente');
imwrite(chateau_seg,'chateau_seg.jpg');

%chateauComp = imread('imgCompare.png');
%figure();
%imshow(chateauComp);
%title('Comparaison des formats d''image')

% Considerant que l'image originale necessite 8 bits pour encoder chaque
% couleur, donc 24 bits pour chaque pixel, ceci résulte donc en un espace
% nécessaire de 1920x1280x24bits = 58 982 400 bits. Or, pour l'image
% segmentée, nous avons besoin de 3 bits par couleur, donc 9 bits par
% pixels, ce qui fait donc un total de 22 118 400 bits. L'image segmentée
% nécessite donc 37.5% de la quantité d'information nécessaire pour
% représenter l'image originale.

h = numel(chateau(:,1,1));
w = numel(chateau(1,:,1));

% Numero 5
% Tentative 2 seg bleus, 2 rouges, 2 verts
r = ObtenirLUT(2);
g = ObtenirLUT(2);
b = ObtenirLUT(2);
chateau_tres_seg = Segmenter_Couleur(chateau,r,g,b);
figure();
imshow(chateau_tres_seg);
title('Image devinette');
% On peut voir qu'il n'y a que 2 niveaux de bleus, tres peu de niveaux de
% rouge ainsi que tres peu de niveaux de vert. En essayant une segmentation
% de 2 pour chaque couleur, nous obtenons donc l'effet voulu.

%% Exercice 4: Toon/Paint shading

% Numero 1
einstein = imread('Albert-Einstein.jpg');
figure();
imshow(einstein);
title('Einstein original');

% Numero 2
%lut5 = ObtenirLUT(5);
% Test comme dans l'enonce
lut8 = ObtenirLUT(8);
lut10 = ObtenirLUT(10);
einstein5 = Segmenter_Couleur(einstein,lut10,lut8,lut8);
figure();
imshow(einstein5);
title('Einstein 10X8X8 segments');

% Numero 3
gauss = fspecial('gaussian',[7 7],1);
einstein5_gauss = convn(einstein5,gauss, 'same');
figure();
imshow(uint8(einstein5_gauss));
title('Einstein 10X8X8 gaussé');

% Numéro 4
[einsteinR, einsteinG, einsteinB] = Split_Couleurs(einstein5_gauss);

threshold = 110;
einsteinR_gauss = Filtre_Canny(einsteinR, gauss ,threshold);
einsteinG_gauss = Filtre_Canny(einsteinG, gauss ,threshold);
einsteinB_gauss = Filtre_Canny(einsteinB, gauss ,threshold);

moy = (einsteinR_gauss + einsteinG_gauss + einsteinB_gauss)/3;
figure();
imshow(moy);
title('Contours');

inverse = imcomplement(moy);
figure();
imshow(inverse);
title('Inverse contours');

% Numero 5
contours_gauss = conv2(inverse,gauss, 'same');
figure();
imshow(contours_gauss);
title('Inverse contours gauss');

% Numero 6
einsteinR_fin = double(einsteinR).*double(contours_gauss);
einsteinG_fin = double(einsteinG).*double(contours_gauss);
einsteinB_fin = double(einsteinB).*double(contours_gauss);

cartoonImg = cat(3,uint8(einsteinR_fin), uint8(einsteinG_fin), uint8(einsteinB_fin));
figure();
imshow(cartoonImg)
title('Image cartoon finale');