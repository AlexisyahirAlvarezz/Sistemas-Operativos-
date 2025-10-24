#!/bin/bash
# === Script de respaldos automáticos ===
# Autor: Alexis
# Fecha: 09/OCT/2025

# === Directorios base ===
DIR1="$HOME/canny/dir1"
DIR2="$HOME/canny/dir2"
DIR3="$HOME/canny/dir3"
BACKUP_DIR="$HOME/canny/backups"

# === Fecha y hora actuales ===
DATE=$(date +"%Y-%m-%d_%H-%M")

# === Crear carpeta de backups si no existe ===
mkdir -p "$BACKUP_DIR"

echo "==============================" >> "$BACKUP_DIR/backup.log"
echo "$(date): Iniciando respaldo automático" >> "$BACKUP_DIR/backup.log"

# === DIRECTORIO 1: respaldo cada 8 horas, 2 días consecutivos ===
tar -czf "$BACKUP_DIR/dir1_backup_$DATE.tar.gz" "$DIR1"
echo "$(date): Respaldo de DIR1 completado" >> "$BACKUP_DIR/backup.log"

# === DIRECTORIO 2: crear dos carpetas diferentes y eliminar una cada 6 horas ===
CARPETA_A="$DIR2/carpetaA_$DATE"
CARPETA_B="$DIR2/carpetaB_$DATE"

mkdir -p "$CARPETA_A" "$CARPETA_B"
echo "$(date): Carpetas A y B creadas en DIR2" >> "$BACKUP_DIR/backup.log"

# Eliminar carpetas con más de 6 horas de antigüedad
find "$DIR2" -type d -mmin +360 -exec rm -rf {} \;
echo "$(date): Carpetas viejas (>6h) eliminadas en DIR2" >> "$BACKUP_DIR/backup.log"

# === DIRECTORIO 3: respaldo y eliminar el más viejo (1 día) ===
tar -czf "$BACKUP_DIR/dir3_backup_$DATE.tar.gz" "$DIR3"
find "$BACKUP_DIR" -name "dir3_backup_*.tar.gz" -mtime +1 -exec rm {} \;
echo "$(date): Respaldo de DIR3 completado y limpieza de archivos >1 día" >> "$BACKUP_DIR/backup.log"

echo "$(date): Tarea finalizada" >> "$BACKUP_DIR/backup.log"
echo "==============================" >> "$BACKUP_DIR/backup.log"
