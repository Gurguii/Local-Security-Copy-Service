
# Requisitos
Es necesario tener instalado rsync => sudo apt install rsync (para Ubuntu)

# ~ Guía rápida ~
# Descargar el repositorio
sudo git clone https://github.com/Gurguii/Servicio-para-hacer-CopiasDeSeguridad-Bash.git  

![imagen](https://user-images.githubusercontent.com/101645735/170832485-49150e5a-a7b6-494d-8921-4eb2a3dc9092.png)

# Entramos en el directorio descargado
cd Servicio-para-hacer-CopiasDeSeguridad-Bash/  

![imagen](https://user-images.githubusercontent.com/101645735/170832506-81228cd6-2b30-454c-b1af-18f61f3363fc.png)

# Ejecutamos el setup.sh con permisos de administrador
sudo bash setup.sh  

![imagen](https://user-images.githubusercontent.com/101645735/170832530-f6ab2ca5-c058-4568-8f83-2ace21d05ecb.png)

# Rellenamos los datos que nos pide
En el caso de las rutas, de no existir, el programa nos pregunta si queremos que cree dicha ruta (los directorios necesarios para que exista), asi que no es necesario tenerlas creadas.

![imagen](https://user-images.githubusercontent.com/101645735/171507719-fe878199-4067-41f6-ad99-6ea022eeb5eb.png)

# Resultado
Nos quedamos con los 4 ficheros para generar nuevos servicios y 3 directorios:  

eliminar_Servicios => Guarda un script para cada servicio creado. El script se encargará de eliminar los ficheros creados para el servicio y el propio servicio, aunque no eliminará la Copia de Seguridad.  

logs_Servicios => Dentro se creará un directorio por cada servicio creado. Cada directorio tendrá los logs de las copias que se vayan haciendo, en caso de elegir en setup.sh un máximo de 3 logs, el programa se encargará de, al tener ese máximo, eliminar el log más antiguo y añadir el nuevo.  

scripts_servicios => Dentro de este directorio se guardarán todos los scripts (1 por servicio) de los servicios creados.

![imagen](https://user-images.githubusercontent.com/101645735/171511536-5305b5b9-df9f-4150-be43-8c0e2f0d3bde.png)

De aqui en adelante, cuando queramos eliminar un servicio, vamos a la carpeta eliminar_Servicios y ejecutamos el script que lleve el nombre del servicio que queremos eliminar.
Cuando queramos añadir otro servicio ejecutaremos setup.sh y rellenaremos los datos.

# Cómo iniciar/parar el servicio
Imaginemos un servicio de nombre ~ prueba ~  
Iniciar: sudo systemctl start prueba  
Parar: sudo systemctl stop prueba  
Comprobar estado: sudo systemctl status prueba

que tengas un buen día :)
