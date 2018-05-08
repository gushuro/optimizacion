# Cosas para charlar con Javier

## Ejercicio 1

Elegimos el problema de encontrar el mayor área alcanzable por un polígono de N lados, si restringimos el diámetro a `d`.

Una primera observación es que podemos resolver el problema para el caso particular `d=1` y multiplicar el resultado por `d^2`. Entendemos que el problema consiste en encontrar una forma, sin importar el tamaño de la misma. Con esto queremos decir que si `P=[v_1, ..., v_n]` es un polígono que maximiza área para `d=1`, entonces `P'=[k*v_1, ..., k*v_n]` será maximal para `d=k`. Más aún, si el área de P es A, entonces el área de P' es `k^2*A` (se demuestra fácil a partir de la formulación en [1], podemos escribirla bien en el informe).

Elegimos este problema por lo que nos generó al leerlo. "Es obvio, la solución tiene que ser el polígono regular!". Nos sorprendió leer que esto no era así, al menos no para cualquier n.



- Minimización sin restricciones
- Métodos de penalidad. ¿Cómo penalizar?
- ¿Es válido un punto tomado como mínimo antes de llegar a una penalización alta?