# Mapa Tierra — Temperaturas de España en 3D

Globo terráqueo interactivo (Three.js) que muestra la temperatura actual de las
ciudades españolas de 50.000 habitantes o más como un degradado de color sobre
el territorio.

## Qué hace

- Esfera 3D oscura con las costas en blanco y controles de órbita
  (rotar con el ratón, zoom con la rueda).
- Temperaturas actuales obtenidas de la API de **Open-Meteo** (sin clave).
- Interpolación IDW (distancia inversa) dibujada como malla de puntos densos,
  recortada a la silueta real de cada territorio:
  - **Península**: solo ciudades peninsulares, sin derrames a Portugal,
    Francia ni el norte de África. Sin líneas de frontera visibles: el
    recorte es la propia delimitación.
  - **Canarias** y **Baleares**: cada archipiélago es un ente independiente,
    interpolado solo con sus ciudades y recortado a sus islas.
  - Ceuta y Melilla no se dibujan (están sobre el continente africano).
- Leyenda de colores de −5 °C (azul) a 40 °C (rojo oscuro).
- Caché en `localStorage` de 1 hora para no refetchear la API.

## Requisitos

- Navegador moderno con WebGL.
- Conexión a internet (CDNs de Three.js y world-atlas + API de Open-Meteo).
- Servidor HTTP local (los `fetch` no funcionan con `file://`).

## Cómo correrla

Opción 1 — script incluido (Windows):

```bat
server.bat
```

Opción 2 — manual:

```bash
python -m http.server 8080
```

Después abre <http://localhost:8080> en el navegador.

## Estructura

| Fichero          | Contenido                                                        |
|------------------|------------------------------------------------------------------|
| `index.html`     | App completa: escena Three.js, fetch de clima, IDW y renderizado |
| `localidades.csv`| Localidades de España (se usan las de ≥ 50.000 habitantes)       |
| `server.bat`     | Lanza `python -m http.server 8080`                               |

## Fuentes de datos

- Clima: <https://api.open-meteo.com/v1/forecast?current=temperature_2m>
- Costa (50 m): `world-atlas@2/land-50m.json` vía jsDelivr
- Fronteras (50 m): `world-atlas@2/countries-50m.json` vía jsDelivr
