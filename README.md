
# Local security copy service

[Linux] - Creates a service which will make a copy of a given file/directory into desired path. Along with some logs with the date of the copy and what's being copied

## Requirements
rsync: lets you transfer files and directories to local and remote destinations.  






## Run locally

Clone the project

```bash
  sudo git clone https://github.com/Gurguii/Local-Security-Copy-Service
```
Go to the project directory
```bash
    cd Local-Security-Copy-Service
```
Run the setup script with sudo privileges
```bash
    sudo bash setup.sh
```
You will be asked a few questions about the service such as paths to copy from/to.  
In case path doesn't exist, the script is able to create those missing directories, you will be asked before creating any directory.
## File explanation
If you have ran setup.sh at least once you will notice 2 new directories: servicesLogs & deleteServices.  
- servicesLogs: stores a directory for each service created whose content will be an incremental file list
- deleteServices: stores a script for each service created which will delete every file created by setup.sh for that service.
# Testing it
### Running the script and filling asked info
```bash
    sudo bash setup.sh
```

### Check copy from & copy to paths before starting the service
```bash
    ls /home/hack/copiar; ls /home/hack/pegar
```

### Start service and check its' status
```bash
    sudo systemctl start gurgui  
    sudo systemctl status gurgui
```
### Check copy from & copy to paths after starting the service
```bash
    ls /home/hack/copiar; ls /home/hack/pegar
```
