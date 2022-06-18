
# Requisitos
Es necesario tener instalado rsync => sudo apt install rsync (para Ubuntu)

# ~ Guía rápida ~
# Download the repository
sudo git clone https://github.com/Gurguii/Servicio-para-hacer-CopiasDeSeguridad-Bash.git  

![imagen](https://user-images.githubusercontent.com/101645735/170832485-49150e5a-a7b6-494d-8921-4eb2a3dc9092.png)

# Get into the repo directory
cd Servicio-para-hacer-CopiasDeSeguridad-Bash/  

![imagen](https://user-images.githubusercontent.com/101645735/170832506-81228cd6-2b30-454c-b1af-18f61f3363fc.png)

# Execute setup.sh with privileges
sudo bash setup.sh  
If you forget it's all good, the script will let you know :)  

![imagen](https://user-images.githubusercontent.com/101645735/170832530-f6ab2ca5-c058-4568-8f83-2ace21d05ecb.png)

# Give necessary info
If a given path does not exist, the script will ask before creating missing directories

![imagen](https://user-images.githubusercontent.com/101645735/171507719-fe878199-4067-41f6-ad99-6ea022eeb5eb.png)

# Result
We are now left with 2 visible directories and the setup.sh file:  

eliminar_Servicios => Guarda un script para cada servicio creado. El script se encargará de eliminar los ficheros creados para el servicio y el propio servicio, aunque no eliminará la Copia de Seguridad.  

logs_Servicios => Dentro se creará un directorio por cada servicio creado. Cada directorio tendrá los logs de las copias que se vayan haciendo, en caso de elegir en setup.sh un máximo de 3 logs, el programa se encargará de, al tener ese máximo, eliminar el log más antiguo y añadir el nuevo.  

scripts_servicios => Dentro de este directorio se guardarán todos los scripts (1 por servicio) de los servicios creados.

![imagen](https://user-images.githubusercontent.com/101645735/171511536-5305b5b9-df9f-4150-be43-8c0e2f0d3bde.png)

From now on, whenever you want to delete a service, go to delete_Services directory and execute the script whose name is the same as the service you want to delete.
Whenever you feel like adding a new service you can just execute setup.sh and give info asked.

# How to start/stop/check status of a service
Given a service called <gurgui>  
Start: sudo systemctl start gurgui  
Stop: sudo systemctl stop gurgui  
Check status: sudo systemctl status gurgui

Have a good day :)
