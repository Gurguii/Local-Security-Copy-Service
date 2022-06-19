
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

![imagen](https://user-images.githubusercontent.com/101645735/174480755-648cf46a-c767-46ec-8889-dd85cfafeddf.png)

.servicesScripts => This directory will be left hidden (notice the . right before the name). It will store the service script <ServiceName.sh>.

# How to start/stop/check status of a service
Given a service called <gurgui>  
sudo systemctl < start | stop | check > <ServiceName> 
Note: As long as I know you don't have to add .service
  sudo systemctl start gurgui.service == sudo systemctl start gurgui
