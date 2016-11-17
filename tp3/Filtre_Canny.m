function [ resultat ] = Filtre_Canny( image, masqueGaussien, treshold )
    tresholdFaible = 1;

    % 1- On doit lisser l'image pour r�duire le bruit afin de ne pas fausser
    % le r�sultat de d�tection de contour
    imageLisse = imfilter(image, masqueGaussien);

    %2- On trouve le gradient, car Canny recherche les zones o� la variation 
    % de l'intensit� lumineuse est la plus importante
    [Gmag,Gdir] = imgradient(imageLisse);

    %3- On supprime les valeurs qui ne sont pas des maximums locaux. 
    rows = size(image,1);
    cols = size(image,2);

    for row = 1:rows
        for col = 1:cols
            voisin1 = 0;
            voisin2 = 0;
            centre = Gmag(row,col);
            direction = abs(Gdir(row,col)); %On veut seulement avoir � v�rifier 1 c�t�

            %Les angles utilis�s sont donn�s dans les notes de cours
            %Sens direction vertical 
            if(direction <= 22.5 || direction > 157.5)  
                if(col > 1)
                    %Voisin gauche
                    voisin1 = Gmag(row, col-1);
                end
                if(col < cols)
                    %Voisin droit
                    voisin2 = Gmag(row, col+1);
                end
            end

            %Sens direction horizontal 
            if(direction > 67.5 && direction <= 112.5) 
                if(row > 1)
                    %Voisin bas
                    voisin1 = Gmag(row-1, col);
                end
                if(row < rows)
                    %Voisin haut
                    voisin2 = Gmag(row+1, col);
                end
            end

            %Sens direction diagonal gauche droite 
            if(direction > 22.5 && direction <= 67.5)
                if(row > 1 && col < cols)
                    %Voisin bas gauche
                    voisin1 = Gmag(row-1, col+1);
                end
                if(row < rows && col > 1)
                    %Voisin haut droit
                    voisin2 = Gmag(row+1, col-1);
                end
            end

            %Sens direction diagonal droite gauche 
            if(direction > 112.5 && direction <= 157.5)  
                if(row > 1 && col > 1)
                    %Voisin bas gauche
                    voisin1 = Gmag(row-1, col-1);
                end
                if(row < rows && col < cols)
                    %Voisin haut droit
                    voisin2 = Gmag(row+1, col+1);
                end
            end

            %Finalement, on garde la valeur maximal du voisinage
            if(centre > voisin1 && centre > voisin2)
                image(row,col) = centre;
            else
                image(row,col) = 0;
            end
        end
    end


    %4- Double seuillage: pour se d�barasser des potentiels faux contours, d�s
    %aux bruits restants ou variation de couleur, on utilise le double
    %seuillage
    %- tous les pixels superieurs au seuil maximal d�fini sont des contours 
    %forts.
    %- tous les pixels inf�rieurs au seuil minimal d�fini sont supprim�s.
    %- tous les pixels situ�s entre ces deux valeurs sont consid�r�s comme des 
    %contours faibles.
    resultat = image > treshold; %On garde les valeurs plus grandes que le seuil

    %5- Detection de contour par hyst�r�sis: Si un contour faible est reli� 
    %� un contour fort, il est ajout� � l'image finale. - Sinon le contour 
    %faible est supprim�.
    for row = 1:rows
        for col = 1:cols
           %On analyse seulement les contours faibles
            if(image(row, col) < treshold && image(row, col) > tresholdFaible)
                if(row > 1 && row < rows && col > 1 && col < cols)
                    %Si le contour faible touche � un contour fort
                    if(resultat(row-1, col) || resultat(row+1, col) || resultat(row, col-1) || resultat(row, col+1) || resultat(row-1, col-1) || resultat(row+1, col+1) || resultat(row-1, col+1) || resultat(row+1, col-1))
                        %On le garde
                        resultat(row, col) = 1;
                    else
                        %On le supprime
                        resultat(row, col) = 0;
                    end
                end            
            end
        end
    end    
end
