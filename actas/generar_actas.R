# ==============================================================================
# Script para generar el Libro de Actas LatinR 2022
# Estrategia:
#   1. Quarto renderiza las páginas del libro (intro, equipo, índice) como PDF
#   2. pdftools combina ese PDF con los papers individuales
# ==============================================================================

# --- Instalar paquetes si hacen falta ---
pkgs <- c("quarto", "fs", "pdftools", "glue", "here")
nuevos <- pkgs[!sapply(pkgs, requireNamespace, quietly = TRUE)]
if (length(nuevos) > 0) install.packages(nuevos)

library(quarto)
library(fs)
library(pdftools)
library(glue)
library(here)

# ------------------------------------------------------------------------------
# 1. Paths
# ------------------------------------------------------------------------------

raiz      <- here::here()
papers_dir <- fs::path(raiz, "papers")
actas_dir  <- fs::path(raiz, "actas")
book_dir   <- fs::path(actas_dir, "_book")

# PDF final de salida
output_pdf <- fs::path(raiz, "actas_LatinR2022.pdf")

# ------------------------------------------------------------------------------
# 2. Renderizar el libro Quarto (portada + intro + equipo + índice)
# ------------------------------------------------------------------------------

cat("Renderizando libro Quarto...\n")
quarto::quarto_render(input = actas_dir)

# Buscar el PDF generado por Quarto
quarto_pdf <- fs::dir_ls(book_dir, glob = "*.pdf")

if (length(quarto_pdf) == 0) {
  stop("No se encontró el PDF generado por Quarto en ", book_dir)
}
quarto_pdf <- quarto_pdf[1]
cat(glue("PDF del libro generado: {quarto_pdf}\n"))

# ------------------------------------------------------------------------------
# 3. Listar los PDFs de papers en orden numérico
# ------------------------------------------------------------------------------

pdf_papers <- fs::dir_ls(papers_dir, glob = "*.pdf")

# Ordenar por número de propuesta (extraído del nombre de archivo)
numeros <- as.integer(gsub(".*propuesta_(\\d+)\\.pdf", "\\1", fs::path_file(pdf_papers)))
ordenes <- order(numeros)
pdf_papers_ordenados <- pdf_papers[ordenes]

cat(glue("Se incluirán {length(pdf_papers_ordenados)} papers\n"))

# ------------------------------------------------------------------------------
# 4. Combinar todos los PDFs en uno solo
# ------------------------------------------------------------------------------

todos_los_pdfs <- c(as.character(quarto_pdf), as.character(pdf_papers_ordenados))

cat("Combinando PDFs...\n")
pdftools::pdf_combine(input = todos_los_pdfs, output = as.character(output_pdf))

cat(glue("\n✅ Libro de actas generado exitosamente:\n   {output_pdf}\n"))
cat(glue("   Páginas totales: {pdftools::pdf_length(as.character(output_pdf))}\n"))
