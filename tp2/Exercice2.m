%% Exercice 2: Compteur1 de monnaie
type binariser.m
type Compter_Monnaie.m
% Num�ro 1
%Charger l'image
monnaieImage = imread('monnaie.png');   
%Afficher l'image
figure(1)
imshow(monnaieImage)

%Num�ro 2
imageBinarisee = binariser(monnaieImage, 250);
%Inversion des couleurs
imageBinarisee = 255-imageBinarisee;
figure(2)
imshow(imageBinarisee)

%Num�ro 3
imageBinariseeFermee = imclose(imageBinarisee, strel('disk', 1));
figure(3)
imshow(imageBinariseeFermee)

%Num�ro 4
Compter_Monnaie(imageBinariseeFermee);

%% Deuxieme partie : Filtrage spectral
% Exercice 3: Transform�e de Fourier 2D
%Num�ro 1
barresVerticales = imread('Barres_Verticales.png');
barresHorizontales = imread('Barres_Horizontales.png');
barresObliques = imread('Barres_Obliques.png');

figure(4)
imshow(barresVerticales)
figure(5)
imshow(barresHorizontales)
figure(6)
imshow(barresObliques)

%Num�ro 2
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

%Num�ro 3
verticalesTournees = imrotate(barresVerticales, 70, 'bilinear','crop');
TFDabs = abs(fft2(verticalesTournees));
TFDExtreme = log(1 + fftshift(TFDabs));
figure(10)
imshow(TFDExtreme, [])

%Num�ro 4
%On peut facilement voir la sym�trie dans le r�sultats des images. En
%effet, les r�sultats respectent la sym�trie selon l'axe diagonale des
%images d'entr�e. Aussi, en r�cup�rant la composante r�elle seuelement des
%valeurs obtenues suite � la transform�e, on comprend bien que la
%transform�e est s�parable. Finalement, avec la rotation, on voit bien la
%proprit�t� de la rotation qui est respect�e. En effet, le r�sultat nous
%pr�sente en majorit� l'axe avec la rotation de 70 degr�s appliqu�e �
%l'image de d�part.



