% type Filtre_Canny.m;
% type Calculer_Precision.m;

% %% Exercice 1: Restauration d�image
% % Numero 1
% %Charger l'image
% voiture = imread('Formula_Ford.png');
% %Afficher l'image
% figure()
% imshow(voiture)
% 
% %Num�ro 2
% % h = fspecial('motion', len, theta): len = 30 et theta = 0 ce qui
% % �quivaut � une motion horizontal de 30 pixels
% % Les valeurs de 31 et 24 ont �t� obtenues par essai-erreur
% h = fspecial('motion', 31, 24);
% 
% %Num�ro 3
% nouvelleImage = deconvwnr(voiture, h, 0);
% %Afficher l'image
% figure()
% imshow(nouvelleImage)
% 
% % M�me s'il est difficile de visualiser quoi que ce soit sur l'image
% % obtenue, on peut remarquer la silhouette de la voiture et l'impression
% % que nous avons est que le d�placement de 30pixels � �t� effectu� et
% % r�sulte en une s�rie de barre verticale. L'image poss�de beaucoup de
% % bruit et est probablement le r�sultat d'un param�tre qui n'est pas
% % ad�quat (voir K, comme K est le ratio du bruit et du signal, la valeur 0
% % n'est pas ad�quate, car il est faux de pr�tendre qu'il n'y a pas de
% % bruit dans l'image).  
% 
% %Num�ro 4
% noise_var = 1e-3;
% I = im2double(voiture);
% estimated_nsr = noise_var / var(I(:));
% 
% %Num�ro 5
% plaqueVisible = deconvwnr(voiture, h, estimated_nsr);
% %Afficher l'image
% figure()
% imshow(plaqueVisible)
% %Le num�ro de la plaque du criminel est FF12FMC

% %% Exercice 2: Segmentation d�image
% %Num�ro 1
% %Charger l'image
 escalier = imread('escaliers.jpg');
% %Afficher l'image
% figure()
% imshow(escalier)
% 
% %Num�ro 2
 gaussien = fspecial('gaussian', 3, 0.5);
 resultat = Filtre_Canny(escalier, gaussien ,20);
 figure()
 imshow(resultat)

%Num�ro 3

%Num�ro 4
escalierReference = imread('escaliers_TrueSeg.jpg') > 128;
resultat = Filtre_Canny(escalier, gaussien, 79);
[Performance, TPF, TFN] = Calculer_Precision(resultat, escalierReference)

%On remarque en faisant varier le seuil que sa valeur optimale ossille
%autour de 79. En effet, lors de notre premi�re utilisation du filtre
%Canny, nous utlisions un seuil de 20 qui nous paraissait donner un
%r�sultat convenable. Suite � l'analyse, nous avons passer d'une
%performance de 19.41% � 27.26% en  passant d'une seuil de 20 � 79. Nous
%acceptions ainsi trop de faux contours.






