# Cosas para charlar con Javier

## Ejercicio 1

Elegimos el problema de encontrar el mayor área alcanzable por un polígono de N lados, si restringimos el diámetro a `d`.

Una primera observación es que podemos resolver el problema para el caso particular `d=1` y multiplicar el resultado por `d^2`. Entendemos que el problema consiste en encontrar una forma, sin importar el tamaño de la misma. Con esto queremos decir que si `P=[v_1, ..., v_n]` es un polígono que maximiza área para `d=1`, entonces `P'=[k*v_1, ..., k*v_n]` será maximal para `d=k`. Más aún, si el área de P es A, entonces el área de P' es `k^2*A` (se demuestra fácil a partir de la formulación en [1], podemos escribirla bien en el informe).

Elegimos este problema por lo que nos generó al leerlo: "Es obvio, la solución tiene que ser el polígono regular!". Nos sorprendió leer que esto no era así, al menos no para cualquier n.

Estaba planteado resolverlo utilizando métodos de minimización sin restricciones, agregando a la función objetivo una función de penalidad. 

La primera idea que tuvimos fue:
```
best = 0
for i = 1:niter
    funciónObjetivo = funcionOriginal - C(i) * penalización
    x0 = random;
    maximizar función objetivo, con x0 como punto inicial
    actualizar best si mejoró (*)
```

Sin embargo, esto tiene un problema fundamental. ¿Qué pasa si un polígono tiene una penalización alta (no está en la región factible) pero en la primera iteración tiene un valor de la función objetivo muy alto? Nunca va a ser retirado como best

Como primera solución pensamos en modificar (*) por `modificar best por el minimo obtenido`. Ahora bien, esto tiene otro problema mucho más importante. ¿Por qué correr 10 iteraciones, si simplemente vamos a quedarnos con el resultado de la última? 
Decidimos entonces que lo mejor sería quedarnos con el minimizador, y utilizarlo como punto inicial para la siguiente iteración. Así, minimizamos para cierta penalización y obtenemos un `x_1`. Luego aumentamos la penalización y minimizamos, partiendo del `x_1`, obteniendo un `x_2`. Y así sucesivamente. De este modo "actualizamos" el mejor valor, moviéndolo hacia la región factible.

### ¿Cómo penalizar?
Decidimos penalizar:

1. Por cada par de vértices, (distancia entre ellos -1), si esto es mayor a 0.
2. Por cada par consecutivo de ángulos, cuán "cruzados" están. Decidimos no penalizar que sean iguales, pues esto no generaría mejoras en la función objetivo (y por ende no hay incentivo para mover el x hacia allí).
3. Restricciones de dominio. Como mencionamos, penalizaremos si algún tita es negativo o mayor a `pi`, y si algún radio es menor a 0 (aunque probablemente este último no modifique el comportamiento del programa por algo similar a 2.).


### Implementación

Partimos de una premisa. Queremos reutilizar código utilizado en los tps anteriores, adaptándolo cuando sea necesario para ajustarlos al problema. Tenemos implementadas varias versiones del método del gradiente, y una versión de Recocido Simulado con reinicios que nos otorgó muy buenos resultados en el TP3, para funciones en varias variables.

Las variables a encontrar son los radios y los ángulos de todos los puntos. Como primera optimización, decidimos tomar el último punto como "implícito" en el (0,0), para reducir en 2 la dimensionalidad del problema. Además, restringimos el dominio a puntos en los dos cuadrantes superiores, ya que un polígono maximal en cuanto a área tiene que ser convexo.

Nuestra variable a minimizar será x = [rs, titas], con ambos de tamaño 1x(n-1). Calcular el área ocupada por ese polígono es sencillo, y está descrito en el enunciado del problema.


#### Primera versión: Recocido Simulado

Al ser el algoritmo minimizador que mejor nos funcionó durante la cursada para funciones en muchas variables, pensamos que era una buena opción para resolver este problema. Implementamos una versión con reinicios, pero le agregamos un primer punto inicial sugerido. Es decir, al utilizar este método, elegimos un primer punto a partir del cual navegar el dominio, pero si no encontramos mejoras luego de cierta cantidad de iteraciones elegimos un nuevo punto inicial aleatorio.

Otra modificación que le hicimos fue no permitir que los puntos iniciales tengan ángulos cruzados. Sabemos que esto no sucede en ningún maximizador, por lo que nos pareció razonable agregar esta restricción.

Por otra parte, recocido simulado toma dominios acotados. Lo que hicimos fue extender los rangos de dominio para permitir que recorra puntos que luego penalizaremos (sin permitir puntos iniciales muy descabellados).


Algunos interrogantes que nos surgieron:
- ¿Cuántas iteraciones?
- ¿Cómo tiene que ser C(i)?
- ¿En cada iteración, cuántos puntos recorremos en recocido simulado?
- ¿Cada cuántos puntos recorridos realizamos un reinicio
- ¿Qué punto inicial "sugerimos"?

Notamos que el tiempo de ejecución de este algoritmo depende únicamente de cantidad de iteraciones y cantidad de puntos en cada iteración. La cantidad de vértices afecta también, pero en menor medida. 

La función de peso de la penalidad C(i) tiene que crecer a ritmo exponencial, o al menos polinomial de grado muy alto. Es importante también que la penalidad arranque baja para permitir recorrer distintas regiones más fácilmente. Además, tiene que estar atada a la cantidad de iteraciones: si ésta es baja, la función tiene que alcanzar valores altos más rápidamente para finalizar con puntos factibles o cuasi factibles. Si la cantidad de iteraciones es alta, debemos fijar un crecimiento más lento, de modo de aprovechar una curva más suave. Encontramos que `C(i) = 2^i * 0.1` para `niter = 30` es una buena combinación de ambas restricciones. Aunque por supuesto la calidad del resultado va a depender de la cantidad de vértices. 

Punto inicial "sugerido":

Ok, el óptimo no será el regular. Pero de todos modos el regular va a tener una muy buena razón diámetro-área. Esto lo hace un muy buen candidato a punto inicial. En efecto, observamos que los resultados son notablemente mejores que al utilizar puntos aleatorios.

Resultados.

Los resultados obtenidos por este método no fueron ideales. Para n chico se logran polígonos razonables, y mejores que los regulares. Pero al agrandar `n`, No logra ningún punto mejor que el inicial.



¿Qué hacemos?



#### Segunda versión: Método del gradiente con Armijo

Notamos que no estamos haciendo uso de características particulares de la función objetivo, como ser derivable ctp. El método del gradiente nos permite descender rápidamente hacia mínimos locales. Modificar la penalidad a cada iteración debería permitirnos mover el punto actual hacia la región factible, mejorando el valor de la función objetivo.
De todas formas, no tenemos una fórmula cerrada/cómoda para ella, por lo que calculamos el gradiente de forma numérica. 

Nos surgieron, al implementarlo, interrogantes parecidos a Recocido. ¿Qué punto inicial tomar? ¿Cómo tiene que ser C(i)? ¿Qué variante elegimos para la búsqueda lineal en el método del gradiente?


Decidimos que C(i) en este caso tenga un crecimiento menor, pero arranque con una penalidad razonable. Notamos que una vez que estamos en un "buen punto", incrementar la penalidad no genera un gran costo para el método del gradiente en adaptarlo. Muchas iteraciones no afectarán la performance


Probamos las diversas variantes que tenemos del método del gradiente, y encontramos que armijo resultó ser la que arroja mejores resultados. 

Otras cosas a mencionar

- Recocido: ¿Tomar maxima penalidad y raíz niter-esima? 

## Ejercicio 2

// TODO: Describir el problema

Cómo encontrar un punto inicial factible? Modificamos el modelo para permitir catenarias de longitud menor a L. De este modo permitimos que la linea recta entre ambos extremos sea factible, y que fmincon busque a partir de ahí. De todos modos, mayor longitud de cuerda permite menor área por debajo, por lo cual al minimizar se va a forzar que la longitud sea L (o algo muy parecido a L).


- Catenaria
- Masa por longitud vs masa por extensión en x
- Diferentes alturas