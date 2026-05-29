# Generación del Libro de Actas LatinR 2022

Esta carpeta contiene los archivos necesarios para generar el libro de actas de LatinR 2022 en formato PDF usando [Quarto](https://quarto.org/).

## Estructura

```
actas/
├── _quarto.yml          # Configuración del libro Quarto
├── index.qmd            # Capítulo de introducción
├── equipo.qmd           # Comité organizador y científico
├── contribuciones.qmd   # Todos los papers (incluye PDFs)
├── generar_actas.R      # Script R para ejecutar la generación
├── logo_latinr.png      # Logo (agregar manualmente si se desea)
└── papers/              # Carpeta donde se copian los PDFs (se crea automáticamente)
```

## Requisitos

- R >= 4.1
- [Quarto](https://quarto.org/docs/get-started/) instalado en el sistema
- Una distribución LaTeX (recomendado: [TinyTeX](https://yihui.org/tinytex/))
  ```r
  install.packages("tinytex")
  tinytex::install_tinytex()
  ```
- Paquetes R: `quarto`, `fs`, `glue`, `here`
  ```r
  install.packages(c("quarto", "fs", "glue", "here"))
  ```

## Cómo generar el libro

1. Cloná el repositorio:
   ```bash
   git clone https://github.com/LatinR/presentaciones-LatinR2022.git
   cd presentaciones-LatinR2022
   ```

2. (Opcional) Agregá el logo `logo_latinr.png` dentro de `actas/`.

3. Ejecutá el script desde R (con el working directory en la raíz del repo):
   ```r
   source("actas/generar_actas.R")
   ```

   O directamente desde la terminal:
   ```bash
   cd actas
   quarto render
   ```

4. El PDF resultante estará en `actas/_book/`.

## Notas

- Los PDFs de los papers se leen desde `papers/` en la raíz del repo y se copian a `actas/papers/` antes de renderizar.
- La sección `equipo.qmd` contiene datos del equipo 2022 basados en <https://2022.latinr.org/equipo/>. Revisá y completá los datos si es necesario.
- Si querés agregar el logo de LatinR, descargalo y guardalo como `actas/logo_latinr.png`.
