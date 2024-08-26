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

# Lee todas las líneas del archivo "server.config" en una matriz
readarray -t server_lines < "$WORK_DIR/server.config"

# Itera a través de las líneas almacenadas en la matriz
for server in "${server_lines[@]}"; do
	# Haces lo que necesites con cada línea, por ejemplo:
	if [ ! -d "$server" ]; then
		echo "No se encuentra la carpeta de Minecraft del Servidor."
	else
		rm -rf "$server/mods"
		
		cp -ru "$WORK_DIR/mods" "$server/mods"
		cp -ru "$WORK_DIR/CustomSkinLoader" "$server/CustomSkinLoader"
		cp -ru "$WORK_DIR/server.properties" "$server/server.properties"
		cp -ru "$WORK_DIR/server-icon.png" "$server/server-icon.png"
		cp -ru "$WORK_DIR/world" "$server/world"
		cp -ru "$WORK_DIR/config" "$server/config"
		sudo chmod 777 -R $server
   fi
done

read -p "Presiona Enter para continuar..."