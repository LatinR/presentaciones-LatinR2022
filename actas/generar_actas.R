# ==============================================================================
# Script para generar el Libro de Actas LatinR 2022
# Usa Quarto para compilar un PDF con introducción, equipo y contribuciones
# ==============================================================================

# Paquetes necesarios
if (!requireNamespace("quarto", quietly = TRUE)) install.packages("quarto")
if (!requireNamespace("fs", quietly = TRUE)) install.packages("fs")
if (!requireNamespace("pdftools", quietly = TRUE)) install.packages("pdftools")
if (!requireNamespace("glue", quietly = TRUE)) install.packages("glue")

library(quarto)
library(fs)
library(glue)

# ------------------------------------------------------------------------------
# 1. Verificar que los PDFs de los papers estén disponibles
# ------------------------------------------------------------------------------

papers_dir <- here::here("papers")
pdf_files <- fs::dir_ls(papers_dir, glob = "*.pdf")

cat(glue("Se encontraron {length(pdf_files)} papers en {papers_dir}\n"))

# ------------------------------------------------------------------------------
# 2. Copiar los PDFs a la carpeta de actas para que Quarto los encuentre
# ------------------------------------------------------------------------------

actas_dir <- here::here("actas")
papers_dest <- fs::path(actas_dir, "papers")
fs::dir_create(papers_dest)

fs::file_copy(pdf_files, fs::path(papers_dest, fs::path_file(pdf_files)), overwrite = TRUE)
cat(glue("PDFs copiados a {papers_dest}\n"))

# ------------------------------------------------------------------------------
# 3. Renderizar el libro con Quarto
# ------------------------------------------------------------------------------

# El archivo _quarto.yml y los .qmd deben estar en actas/
quarto::quarto_render(input = actas_dir)

cat("\n✅ Libro de actas generado exitosamente.\n")
cat(glue("   Buscá el PDF en: {fs::path(actas_dir, '_book')}\n"))
