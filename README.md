# Mapa Tierra — Temperaturas y calidad del aire en 3D

Globo terráqueo interactivo (Three.js) que muestra la temperatura actual y la
calidad del aire de las ciudades españolas de 50.000 habitantes o más como un
degradado de color sobre el territorio, más 41 ciudades de Francia como
puntos individuales.

## Qué hace

- Esfera 3D oscura con las costas en blanco y controles de órbita
  (rotar con el ratón, zoom con la rueda).
- Pestaña **Temperatura**: valores actuales de la API de **Open-Meteo**
  (sin clave), interpolación IDW (distancia inversa) dibujada como malla de
  puntos densos (`InstancedMesh`), recortada a la silueta real de cada
  territorio:
  - **Península**: solo ciudades peninsulares, sin derrames a Portugal,
    Francia ni el norte de África. Sin líneas de frontera visibles: el
    recorte es la propia delimitación.
  - **Canarias** y **Baleares**: cada archipiélago es un ente independiente,
    interpolado solo con sus ciudades y recortado a sus islas.
  - Ceuta y Melilla: puntos individuales con su temperatura.
  - **Francia**: 41 ciudades (de `world_cities_geoname.csv`) como puntos
    individuales, sin interpolar, del mismo tamaño que los de España.
- Pestaña **Calidad del aire**: mismo esquema (degradado IDW por territorio
  para España + puntos de Francia), con puntos coloreados según el índice
  europeo AQI y panel lateral con los valores horarios actuales de PM2.5,
  PM10, O₃, NO₂, SO₂, CO y CO₂ (Air Quality API de Open-Meteo).
  - El panel incluye **buscador por ciudad** y selección por **ciudad o país**:
    al seleccionar, el resto de puntos pierde opacidad y la cámara vuela
    hasta centrar la ciudad (zoom máximo) o encuadrar el país.
- Leyenda adaptativa (escala de temperatura o categorías AQI según la pestaña).
- Caché en `localStorage` de 1 hora para no refetchear las APIs.

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
| `index.html`     | App completa: escena Three.js, fetch de clima/aire, IDW y renderizado |
| `localidades.csv`| Localidades de España (se usan las de ≥ 50.000 habitantes)       |
| `world_cities_geoname.csv` | Ciudades del mundo (se usan las de Francia)           |
| `server.bat`     | Lanza `python -m http.server 8080`                               |

## Fuentes de datos

- Clima: <https://api.open-meteo.com/v1/forecast?current=temperature_2m>
- Aire: <https://air-quality-api.open-meteo.com/v1/air-quality?hourly=pm10,pm2_5,ozone,sulphur_dioxide,nitrogen_dioxide,carbon_dioxide,carbon_monoxide>
- Costa (50 m): `world-atlas@2/land-50m.json` vía jsDelivr
- Fronteras (50 m): `world-atlas@2/countries-50m.json` vía jsDelivr
