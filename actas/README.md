# Generación del Libro de Actas LatinR 2022

Esta carpeta contiene los archivos necesarios para generar el libro de actas de LatinR 2022 en formato PDF.

## Estrategia

Se usa un enfoque en dos pasos para evitar dependencias de paquetes LaTeX complejos:

1. **Quarto** renderiza las páginas del libro (portada, introducción, equipo, índice de contribuciones) como PDF.
2. **`pdftools`** combina ese PDF con los 40 papers individuales en un único archivo final.

## Estructura

```
actas/
├── _quarto.yml          # Configuración del libro Quarto
├── index.qmd            # Capítulo de introducción
├── equipo.qmd           # Comité organizador y científico
├── contribuciones.qmd   # Índice/tabla de contribuciones
├── generar_actas.R      # Script principal para generar el libro
└── README.md            # Este archivo
```

El PDF final se guarda en la **raíz del repositorio** como `actas_LatinR2022.pdf`.

## Requisitos

- R >= 4.1
- [Quarto](https://quarto.org/docs/get-started/) instalado en el sistema
- Una distribución LaTeX básica (TinyTeX es suficiente — **no** se necesita `pdfpages`)
  ```r
  install.packages("tinytex")
  tinytex::install_tinytex()
  ```
- Paquetes R: `quarto`, `fs`, `pdftools`, `glue`, `here`
  ```r
  install.packages(c("quarto", "fs", "pdftools", "glue", "here"))
  ```

## Cómo generar el libro

1. Cloná el repositorio:
   ```bash
   git clone https://github.com/LatinR/presentaciones-LatinR2022.git
   cd presentaciones-LatinR2022
   ```

2. Ejecutá el script desde R (con el working directory en la raíz del repo):
   ```r
   source("actas/generar_actas.R")
   ```

3. El PDF final estará en la raíz del repo: `actas_LatinR2022.pdf`

## Notas

- **Equipo**: El archivo `equipo.qmd` tiene los datos del equipo 2022. Revisá y completá si es necesario.
- **Logo**: Si querés agregar el logo de LatinR en la portada, guardalo como `actas/logo_latinr.png` y descomentá la línea correspondiente en `index.qmd`.
- Los papers se incluyen ordenados numéricamente por número de propuesta.
