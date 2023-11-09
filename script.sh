#!/bin/bash

# Construye la ruta completa a la carpeta de clonación de Git
WORK_DIR="$(pwd)"

# Verificar si existe la carpeta "MinecraftData"
if [ ! -d "$WORK_DIR" ]; then
    # Si no existe, hacer un clon del repositorio de Git
    git clone https://github.com/Nellyth/Minecraft.git "$WORK_DIR"
fi

# Moverse a la carpeta del repositorio clonado
cd $WORK_DIR

# Dar la opción de hacer "push" o "pull"
echo "Seleccione una opción:"
echo "1. Hacer 'push' al repositorio"
echo "2. Hacer 'pull' desde el repositorio"
read -p "Opción (1/2): " option

if [ "$option" -eq 1 ]; then  
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

    # Lee todas las líneas del archivo "server.config" en una matriz
    readarray -t server_lines < "$WORK_DIR/server.config"

    # Itera a través de las líneas almacenadas en la matriz
    for server in "${server_lines[@]}"; do
        # Haces lo que necesites con cada línea, por ejemplo:
    if [ ! -d "$server" ]; then
            echo "No se encuentra la carpeta de Minecraft del Servidor."
        else
            rm -rf "$server/mods"
            
            cp -r "$WORK_DIR/mods" "$server/mods"
            cp -r "$WORK_DIR/CustomSkinLoader" "$server/CustomSkinLoader"
            cp -r "$WORK_DIR/server.properties" "$server/server.properties"
            cp -r "$WORK_DIR/server-icon.png" "$server/server-icon.png"
            cp -r "$WORK_DIR/world" "$server/world"
            cp -r "$WORK_DIR/config" "$server/config"
            sudo chmod 777 -R $server
       fi
    done
else
    echo "Opción no válida. Saliendo."
fi

read -p "Presiona Enter para continuar..."