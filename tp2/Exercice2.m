%% Exercice 2: Compteur1 de monnaie
type binariser.m
type Compter_Monnaie.m
% Numéro 1
%Charger l'image
monnaieImage = imread('monnaie.png');   
%Afficher l'image
figure(1)
imshow(monnaieImage)

%Numéro 2
imageBinarisee = binariser(monnaieImage, 250);
%Inversion des couleurs
imageBinarisee = 255-imageBinarisee;
figure(2)
imshow(imageBinarisee)

%Numéro 3
imageBinariseeFermee = imclose(imageBinarisee, strel('disk', 1));
figure(3)
imshow(imageBinariseeFermee)

%Numéro 4
Compter_Monnaie(imageBinariseeFermee);

%% Deuxieme partie : Filtrage spectral
% Exercice 3: Transformée de Fourier 2D
%Numéro 1
barresVerticales = imread('Barres_Verticales.png');
barresHorizontales = imread('Barres_Horizontales.png');
barresObliques = imread('Barres_Obliques.png');

figure(4)
imshow(barresVerticales)
figure(5)
imshow(barresHorizontales)
figure(6)
imshow(barresObliques)

%Numéro 2
TFDabs = abs(fft2(barresVerticales));
TFDExtreme = log(1 + fftshift(TFDabs));

figure(7)
imshow(TFDExtreme, [])

TFDabs = abs(fft2(barresHorizontales));
TFDExtreme = log(1 + fftshift(TFDabs));

figure(8)
imshow(TFDExtreme, [])

TFDabs = abs(fft2(barresObliques));
TFDExtreme = log(1 + fftshift(TFDabs));

figure(9)
imshow(TFDExtreme, [])

%Numéro 3
verticalesTournees = imrotate(barresVerticales, 70, 'bilinear','crop');
TFDabs = abs(fft2(verticalesTournees));
TFDExtreme = log(1 + fftshift(TFDabs));
figure(10)
imshow(TFDExtreme, [])

%Numéro 4
%On peut facilement voir la symétrie dans le résultats des images. En
%effet, les résultats respectent la symétrie selon l'axe diagonale des
%images d'entrée. Aussi, en récupérant la composante réelle seuelement des
%valeurs obtenues suite à la transformée, on comprend bien que la
%transformée est séparable. Finalement, avec la rotation, on voit bien la
%propritété de la rotation qui est respectée. En effet, le résultat nous
%présente en majorité l'axe avec la rotation de 70 degrés appliquée à
%l'image de départ.



