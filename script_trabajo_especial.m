%-------------------------------------------------------------------------------
%               Taller de Matem�tica Compuracional - TUDAI
%                     Primer Cuatrimestre - A�o 2017
%        Parcial Nro. 3 - C�lculo de probabilidades por Montecarlo
%-------------------------------------------------------------------------------

% Limpiamos la pantalla y eliminamos los valores de las variables.
clear 
clc


% Welcome, welcome!
disp('---------------------------------------------------------------------------------------------------------------')
disp('                                 Taller de Matem�tica Computacional - TUDAI')
disp('                                       Primer Cuatrimestre - A�o 2017')
disp('                          Parcial Nro. 3 - C�lculo de probabilidades por Montecarlo')
disp('')
disp('                                  SIRACUSA, Angel Jonat�n. DNI: 32253161')
disp('---------------------------------------------------------------------------------------------------------------')
disp('')
disp('')


% Inicializamos las variables.
epsilon_arreglo = [0.1, 0.01, 0.001];
dni = 32253161;
contador = 1;
desvio_estandar_primeras = 0;
desvio_estandar_ultimas = 0;


% Calculamos las probabilidades con los epsilon del arreglo.
while (contador < 4)
  tic
  
  epsilon = epsilon_arreglo(contador);
  [probabilidad_estimada, probabilidades_parciales] = calcular_probabilidad_fallos (dni, epsilon);
  desvio_estandar_primeras = std(probabilidades_parciales(1:20));
  desvio_estandar_ultimas = std(probabilidades_parciales(end-20:end));
  
  
  disp('')
  fprintf('La probabilidad de 2 fallos seguidos en la autorizaci�n de disparo, con un epsilon de %d', epsilon);
  fprintf(', es de: %f.\n', probabilidad_estimada);
  fprintf('El desv�o est�ndar de las 20 primeras iteraiciones es de: %f.\n', desvio_estandar_primeras);
  fprintf('El desv�o est�ndar de las 20 �ltimas iteraiciones es de: %f.\n', desvio_estandar_ultimas);
  fflush(stdout);
  
  contador = contador + 1;
  
  
  % Graficamos las probabilidades parciales.
  figure, plot(probabilidades_parciales);
  leyenda = sprintf('Epsilon = %u', epsilon);
  legend(leyenda);
  ylim([0 1]);
  grid on;
  title('Gr�fico de probabilidades parciales, por m�todo de Montecarlo');
  xlabel('Cantidad de Iteraciones');
  ylabel('Probabilidades');
  
  
  % Calculamos e imprimimos el tiempo que tardo el algoritmo en calcularse.
  fprintf('Tiempo de procesamiento de este algoritmo es de');
  tiempo = toc;
  fprintf(': %f', tiempo);
  fprintf(' segundos.\n');

end
