function LUT = ObtenirLUT(nbSegments)
    maxIntensity = 255;
    % Tableau contenant les bornes inferieures et superieures de chaque
    % segment (d'ou nbSegments+1)
    delimiters = linspace(0,maxIntensity,nbSegments+1);
    % Preallocation pour rapidite sur recommadation de notre ami matlab
    avgValues = zeros(1,nbSegments);
    for v = 1:numel(delimiters)
        if v < numel(delimiters)
            % Calcul des valeurs moyennes
            avgValues(v) = (delimiters(v)+delimiters(v+1))/2;
        end
    end
    
    preLUT = repelem(uint8(ceil(avgValues)),ceil(maxIntensity/nbSegments));
    
    % Il faut s'assurer que les LUT ont bien 256 valeurs
    if numel(preLUT) > 256
        preLUT = preLUT(1:256);
    elseif numel(preLUT) < 256
        nbElements = 256 - numel(preLUT);
        suffix = ones(1,nbElements)*max(avgValues);
        preLUT = [preLUT suffix];
    end
    
    LUT = preLUT;
end