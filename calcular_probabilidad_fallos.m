## Author: Angel Jonatán <Angel Jonatán>
## Created: 2017-06-10

function [probabilidad_estimada, probabilidades_parciales] = calcular_probabilidad_fallos (dni, epsilon)
  
  % Inicio las variables que voy a necesitar.
  probabilidad_estimada = 0;
  probabilidades_parciales = [];
  probabilidad_actual = 1;
  probabilidad_anterior = 0;
  autorizacion_actual = 0;
  autorizacion_anterior = 0;
  
  exitos = 0;
  total_intentos = 0;
  suceso_aleatorio = 1;
  
  convergencia = 1;
  converge = false;
  tiradas_minimas = 50;
  
  % Mientras que las probabilidades no converjan a Epsilon, seguira ciclando.
  while ~converge
    probabilidad_anterior = probabilidad_actual;
    autorizacion_anterior = autorizacion_actual;
    
    [autorizacion_actual] = my_mex_service(dni);
    
    % Verifico si se cumplen las condiciones del Suceso Aleatorio.
    if (autorizacion_actual + autorizacion_anterior == 0)
      suceso_aleatorio = true;
    else
      suceso_aleatorio = false;
    end
    
    % Si el Suceso Aleatorio se produce, sumo un éxito.
    if suceso_aleatorio
      exitos = exitos + 1;
    end
    
    % Calculo la probabilidad hasta el momento.
    total_intentos = total_intentos + 1;
    probabilidad_actual = exitos / total_intentos;
    
    convergencia = abs(probabilidad_actual - probabilidad_anterior);
    
    probabilidades_parciales = cat(1, probabilidades_parciales, probabilidad_actual);
    
    % Verifico si la convergencia es menor que Epsilon.
    if (convergencia < epsilon) && (total_intentos > tiradas_minimas)
      converge = true;
    else
      converge = false;
    end
  end
  
  probabilidad_estimada = probabilidad_actual;
   
end
