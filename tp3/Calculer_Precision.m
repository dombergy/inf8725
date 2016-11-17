function [Performance, TPF, TFN] = Calculer_Precision(image, imageReference)
    resultat = image&imageReference;

    ContoursDetectes = sum(image(:));
    ContoursReferences = sum(imageReference(:));
    ContoursCorrects = sum(resultat(:));

    FauxPositifs = ContoursDetectes - ContoursCorrects;
    FauxNegatifs = ContoursReferences - ContoursCorrects;

    Performance = ContoursCorrects/(ContoursCorrects+FauxPositifs+FauxNegatifs);
    TPF = FauxPositifs/(ContoursCorrects+FauxPositifs+FauxNegatifs);
    TFN = FauxNegatifs/(ContoursCorrects+FauxPositifs+FauxNegatifs);
end