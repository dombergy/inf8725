% type Filtre_Canny.m;
% type Calculer_Precision.m;

% %% Exercice 1: Restauration d’image
% % Numero 1
% %Charger l'image
% voiture = imread('Formula_Ford.png');
% %Afficher l'image
% figure()
% imshow(voiture)
% 
% %Numéro 2
% % h = fspecial('motion', len, theta): len = 30 et theta = 0 ce qui
% % équivaut à une motion horizontal de 30 pixels
% % Les valeurs de 31 et 24 ont été obtenues par essai-erreur
% h = fspecial('motion', 31, 24);
% 
% %Numéro 3
% nouvelleImage = deconvwnr(voiture, h, 0);
% %Afficher l'image
% figure()
% imshow(nouvelleImage)
% 
% % Même s'il est difficile de visualiser quoi que ce soit sur l'image
% % obtenue, on peut remarquer la silhouette de la voiture et l'impression
% % que nous avons est que le déplacement de 30pixels à été effectué et
% % résulte en une série de barre verticale. L'image possède beaucoup de
% % bruit et est probablement le résultat d'un paramètre qui n'est pas
% % adéquat (voir K, comme K est le ratio du bruit et du signal, la valeur 0
% % n'est pas adéquate, car il est faux de prétendre qu'il n'y a pas de
% % bruit dans l'image).  
% 
% %Numéro 4
% noise_var = 1e-3;
% I = im2double(voiture);
% estimated_nsr = noise_var / var(I(:));
% 
% %Numéro 5
% plaqueVisible = deconvwnr(voiture, h, estimated_nsr);
% %Afficher l'image
% figure()
% imshow(plaqueVisible)
% %Le numéro de la plaque du criminel est FF12FMC

% %% Exercice 2: Segmentation d’image
% %Numéro 1
% %Charger l'image
 escalier = imread('escaliers.jpg');
% %Afficher l'image
% figure()
% imshow(escalier)
% 
% %Numéro 2
 gaussien = fspecial('gaussian', 3, 0.5);
 resultat = Filtre_Canny(escalier, gaussien ,20);
 figure()
 imshow(resultat)

%Numéro 3

%Numéro 4
escalierReference = imread('escaliers_TrueSeg.jpg') > 128;
resultat = Filtre_Canny(escalier, gaussien, 79);
[Performance, TPF, TFN] = Calculer_Precision(resultat, escalierReference)

%On remarque en faisant varier le seuil que sa valeur optimale ossille
%autour de 79. En effet, lors de notre première utilisation du filtre
%Canny, nous utlisions un seuil de 20 qui nous paraissait donner un
%résultat convenable. Suite à l'analyse, nous avons passer d'une
%performance de 19.41% à 27.26% en  passant d'une seuil de 20 à 79. Nous
%acceptions ainsi trop de faux contours.






