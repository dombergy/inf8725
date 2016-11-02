function [valeurTotale]  = Compter_Monnaie(img)
    %40 �tant le diam�tre incluant toutes les pi�ces
    nombreTotal = max(max(bwlabel(imerode(img, strel('disk',40), 'same'))));
    %45 �tant un diam�tre plus grand que celui des pi�ces de 10c
    nombre10cents = nombreTotal - max(max(bwlabel(imerode(img, strel('disk',45), 'same'))));
    %55 �tant un diam�tre plus grand que celui des pi�ces de 5c
    nombre5cents = nombreTotal - nombre10cents - max(max(bwlabel(imerode(img, strel('disk',55), 'same'))));
    %60 �tant un diam�tre plus grand que celui des pi�ces de 25c
    nombre25cents = nombreTotal - nombre10cents - nombre5cents - max(max(bwlabel(imerode(img, strel('disk',60), 'same'))));
    %64 �tant un diam�tre plus grand que celui des pi�ces de 1$
    nombre1dollard = nombreTotal - nombre25cents - nombre10cents - nombre5cents - max(max(bwlabel(imerode(img, strel('disk',64), 'same'))));
    %67 �tant un diam�tre plus grand que celui des pi�ces de 2$
    nombre2dollard = nombreTotal - nombre1dollard - nombre25cents - nombre10cents - nombre5cents - max(max(bwlabel(imerode(img, strel('disk',67), 'same'))));
    
    valeurTotale = (nombre10cents*0.1) + (nombre5cents * 0.05) + (nombre25cents * 0.25) + (nombre10cents) + (nombre2dollard * 2);
end