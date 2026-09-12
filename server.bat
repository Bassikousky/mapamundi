@echo off
cd /d "D:\Documentos\PROYECTOS\mapaTierra"
echo Servidor iniciado en http://localhost:8080
echo Pulsa Ctrl+C para detener
python -m http.server 8080
