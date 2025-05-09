
# Práctica: Filtro SMA

## Algoritmo SMA (Simple Moving Average)

El filtro **SMA (Simple Moving Average)** de orden 4 implementado en esta práctica es un filtro digital que suaviza señales ruidosas tomando la media aritmética de las últimas cuatro muestras de entrada.

### Funcionamiento:
A cada nuevo dato de entrada (`din`), el filtro:
1. Desplaza las tres muestras anteriores.
2. Añade la nueva muestra al final del registro.
3. Calcula la media como:

```
dout = (x[n] + x[n−1] + x[n−2] + x[n−3]) / 4
```

Donde:
- `x[n]` es la muestra actual.
- `dout` es la salida filtrada.

Este promedio reduce el efecto del ruido y produce una versión más suave de la señal original, pero introduce **retardo** y **amortiguación** en las transiciones rápidas.

---

## Discusión de Resultados

Se han simulado cuatro tipos de señal de entrada y se ha observado el comportamiento del filtro SMA en cada una:

### 1. Señal Triangular:
- La salida sigue la forma general de la señal.
- Las esquinas agudas se suavizan.
- Hay un **ligero retardo** (2 muestras) en la salida respecto a la entrada.

### 2. Señal Cuadrada:
- El filtro suaviza los bordes, eliminando las transiciones abruptas.
- La señal de salida adquiere una forma trapezoidal.
- Se reduce el contenido de alta frecuencia.

### 3. Señal Diente de Sierra:
- El filtro suaviza el incremento lineal.
- Se observa un retardo constante y una reducción en la pendiente de subida.
- La salida parece una versión "atenuada" de la original.

### 4. Señal Senoidal:
- La salida se mantiene senoidal pero más suave.
- Se reduce el ruido y se conserva la forma general.
- El retardo es evidente pero aceptable para señales periódicas.

---

## Conclusión

El filtro SMA implementado funciona correctamente y es eficaz para eliminar ruido y suavizar señales, especialmente aquellas con transiciones bruscas. No requiere multiplicaciones (solo sumas y desplazamiento para dividir), lo que lo hace **eficiente para hardware digital** como FPGAs. El principal efecto secundario es un **retardo temporal**, típico de este tipo de filtros.
