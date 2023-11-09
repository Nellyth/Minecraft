#!/bin/bash

# Obtiene la ubicación actual del archivo de script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Construye la ruta completa a la carpeta de clonación de Git
WORK_DIR="$SCRIPT_DIR"

# Verificar si existe la carpeta "MinecraftData"
if [ ! -d "$WORK_DIR" ]; then
    # Si no existe, hacer un clon del repositorio de Git
    git clone https://github.com/Nellyth/Minecraft.git "$WORK_DIR"
fi

# Moverse a la carpeta del repositorio clonado
cd "$WORK_DIR"

# Dar la opción de hacer "push" o "pull"
echo "Seleccione una opción:"
echo "1. Hacer 'push' al repositorio"
echo "2. Hacer 'pull' desde el repositorio"
read -p "Opción (1/2): " option

pkill -f javaw.exe

if [ "$option" -eq 1 ]; then
    rm -f "$WORK_DIR/TLauncher.exe"
    
    # Realizar "push" al repositorio
    git checkout -b test
    git pull test
    git add .
    git commit -m "Actualización automática"
    git push --set-upstream origin test
    git checkout main
    git branch -D test
elif [ "$option" -eq 2 ]; then
    # Realizar "pull" desde el repositorio
    git checkout main
    git pull

    # Realizar "pull" desde el repositorio
    git checkout main
    git pull

    while IFS= read -r server; do
        SERVER="$server"
    done < "server.config"

    if [ ! -d "$SERVER" ]; then
        echo "No se encuentra la carpeta de Minecraft del Servidor."
    else
        rm -rf "$SERVER/mods"
        rm -rf "$SERVER/CustomSkinLoader"

        cp -r "$WORK_DIR/mods" "$SERVER/mods"
        cp -r "$WORK_DIR/CustomSkinLoader" "$SERVER/CustomSkinLoader"
        cp -r "$WORK_DIR/server.properties" "$SERVER/server.properties"
        cp -r "$WORK_DIR/server-icon.png" "$SERVER/server-icon.png"
        cp -r "$WORK_DIR/world" "$SERVER/world"
        cp -r "$WORK_DIR/config" "$SERVER/config"
    fi
else
    echo "Opción no válida. Saliendo."
fi

read -p "Presiona Enter para continuar..."