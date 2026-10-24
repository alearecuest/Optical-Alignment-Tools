% Generación de interferogramas para pruebas de alineación óptica
clear; clc; close all;

% Definir el plano focal y la apertura
[x, y] = meshgrid(linspace(-1, 1, 400));
r = sqrt(x.^2 + y.^2);
mask = double(r <= 1); % Máscara circular para el límite del espejo/lente

% Definir errores en el frente de onda (Wavefront Error - WFE)
% Inclinación en X (desalineación)
tilt_x = 4 * x; 
% Aberración esférica (Polinomio de Zernike simplificado)
spherical = 2 * (6*r.^4 - 6*r.^2 + 1); 

% Frente de onda total
wavefront = tilt_x + spherical;

% Ecuación de interferencia de dos haces (Intensidad)
I = 0.5 * (1 + cos(2 * pi * wavefront));
I = I .* mask; % Cortar los bordes fuera de la óptica

% Graficar el frente de onda 3D y el interferograma resultante
figure('Name', 'Herramientas de Alineación Óptica', 'Color', 'w');
subplot(1,2,1); 
surf(x, y, wavefront .* mask, 'EdgeColor', 'none'); 
title('Mapa del Frente de Onda (WFE)'); 
view(2); axis square; colormap(jet); colorbar;

subplot(1,2,2); 
imshow(I); 
title('Interferograma Simulado (Patrón de Franjas)');