
# Requirements
You must have rsync installed => sudo apt install rsync (Ubuntu)

# ~ Quick guide ~
# Download the repository
sudo git clone https://github.com/Gurguii/Local-Security-Copy-Service  

# Get into the repo directory
cd Local-Security-Copy-Service  

![imagen](https://user-images.githubusercontent.com/101645735/174479659-133ace4c-be76-40e7-b1d4-ab2224faba2c.png)


# Execute setup.sh with privileges and give necessary info about the service
sudo bash setup.sh  

![imagen](https://user-images.githubusercontent.com/101645735/174479735-6becbe25-1eff-4236-84f4-95c6f36fe756.png)

# Result
We are now left with 2 visible directories and the setup.sh file (not counting README and LICENSE):   

deleteServices => Has a script for each service <ServiceName.sh>. By executing it, every file created for that service will be deleted.

servicesLogs => Has a directory for each created service which will store the service's logs. Each log file has the $date of the copy and some info about the copy made.  
![imagen](https://user-images.githubusercontent.com/101645735/174480607-70d3d598-87ba-472d-95c8-ce821acf0b06.png)

.servicesScripts => This directory will be left hidden (notice the . right before the name). It will store the service script <ServiceName.sh>.

![imagen](https://user-images.githubusercontent.com/101645735/171511536-5305b5b9-df9f-4150-be43-8c0e2f0d3bde.png)

From now on, whenever you want to delete a service, go to delete_Services directory and execute the script whose name is the same as the service you want to delete.
Whenever you feel like adding a new service you can just execute setup.sh and give info asked.

# How to start/stop/check status of a service
Given a service called <gurgui>  
sudo systemctl <start | stop | check> <ServiceName> 
Note: As long as I know you don't have to add .service
