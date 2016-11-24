type Filtre_Canny.m;
type Calculer_Precision.m;
type ObtenirLUT.m;
type Segmenter_Couleur.m;
type Split_Couleurs.m;
%% Exercice 1: Restauration d�image
% Numero 1
%Charger l'image
voiture = imread('Formula_Ford.png');
%Afficher l'image
figure()
imshow(voiture)
title('Image originale')

%Num�ro 2
% h = fspecial('motion', len, theta): len = 30 et theta = 0 ce qui
% �quivaut � une motion horizontal de 30 pixels
% Les valeurs de 31 et 24 ont �t� obtenues par essai-erreur
h = fspecial('motion', 31, 24);

%Num�ro 3
nouvelleImage = deconvwnr(voiture, h, 0);
%Afficher l'image
figure()
imshow(nouvelleImage)
title('Filtre inverse')

% M�me s'il est difficile de visualiser quoi que ce soit sur l'image
% obtenue, on peut remarquer la silhouette de la voiture et l'impression
% que nous avons est que le d�placement de 30pixels � �t� effectu� et
% r�sulte en une s�rie de barre verticale. L'image poss�de beaucoup de
% bruit et est probablement le r�sultat d'un param�tre qui n'est pas
% ad�quat (voir K, comme K est le ratio du bruit et du signal, la valeur 0
% n'est pas ad�quate, car il est faux de pr�tendre qu'il n'y a pas de
% bruit dans l'image).  

%Num�ro 4
noise_var = 1e-3;
I = im2double(voiture);
estimated_nsr = noise_var / var(I(:));

%Num�ro 5
plaqueVisible = deconvwnr(voiture, h, estimated_nsr);
%Afficher l'image
figure()
imshow(plaqueVisible)
title('Image plaque visible')
%Le num�ro de la plaque du criminel est FF12FMC

%% Exercice 2: Segmentation d�image
%Num�ro 1
%Charger l'image
escalier = imread('escaliers.jpg');
%Afficher l'image
figure()
imshow(escalier)
title('Image escalier')

%Num�ro 2
gaussien = fspecial('gaussian', 3, 0.5);
resultat = Filtre_Canny(escalier, gaussien ,20);
figure()
imshow(resultat)
title('Image Filtre Canny')

%Num�ro 3

%Num�ro 4
escalierReference = imread('escaliers_TrueSeg.jpg') > 128;
resultat = Filtre_Canny(escalier, gaussien, 79);
[Performance, TPF, TFN] = Calculer_Precision(resultat, escalierReference);

%On remarque en faisant varier le seuil que sa valeur optimale oscille
%autour de 79. En effet, lors de notre premi�re utilisation du filtre
%Canny, nous utlisions un seuil de 20 qui nous paraissait donner un
%r�sultat convenable. Suite � l'analyse, nous avons passer d'une
%performance de 19.41% � 27.26% en  passant d'une seuil de 20 � 79. Nous
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
% couleur, donc 24 bits pour chaque pixel, ceci r�sulte donc en un espace
% n�cessaire de 1920x1280x24bits = 58 982 400 bits. Or, pour l'image
% segment�e, nous avons besoin de 3 bits par couleur, donc 9 bits par
% pixels, ce qui fait donc un total de 22 118 400 bits. L'image segment�e
% n�cessite donc 37.5% de la quantit� d'information n�cessaire pour
% repr�senter l'image originale.

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
title('Einstein 10X8X8 gauss�');

% Num�ro 4
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