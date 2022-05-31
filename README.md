
# Requisitos
Es necesario tener instalado rsync => sudo apt install rsync (para Ubuntu)

# ~ Guía rápida ~
# Descargar el repositorio
![imagen](https://user-images.githubusercontent.com/101645735/170832485-49150e5a-a7b6-494d-8921-4eb2a3dc9092.png)

# Entramos en el directorio descargado
![imagen](https://user-images.githubusercontent.com/101645735/170832506-81228cd6-2b30-454c-b1af-18f61f3363fc.png)

# Ejecutamos el setup.sh con permisos de administrador
![imagen](https://user-images.githubusercontent.com/101645735/170832530-f6ab2ca5-c058-4568-8f83-2ace21d05ecb.png)

# Rellenamos los datos que nos pide
![imagen](https://user-images.githubusercontent.com/101645735/171176950-52b99af6-c766-41c1-a5c5-351312b7e40c.png)

# Resultado
Nos queda un directorio con los ficheros necesarios para crear nuevos servicios y dos directorios más, en ~ eliminar_Servicios ~ se guardarán los scripts para borrar los servicios creados. En ~ logs_Servicios ~ habrá un directorio por cada servicio creado, éste tendrá dentro los ficheros de cambios o logs o como quieras llamarlo.

![imagen](https://user-images.githubusercontent.com/101645735/170833579-d19eb087-fb06-460d-b6f0-3143e15c06fd.png)

De aqui en adelante, cuando queramos eliminar un servicio, vamos a la carpeta eliminar_Servicios y ejecutamos el script que lleve el nombre del servicio que queremos eliminar.
Cuando queramos añadir otro servicio ejecutaremos setup.sh y rellenaremos los datos.

# Cómo iniciar/parar el servicio
Imaginemos un servicio de nombre ~ prueba ~  
Iniciar: sudo systemctl start prueba  
Parar: sudo systemctl stop prueba  
Comprobar estado: sudo systemctl status prueba

que tengas un buen día :)
