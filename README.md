# Full Stack Web Application - Phase 1
In this section, we will learn how to build (ops) and deploy the web application developed by Dev Team.

This phase includes

- Follow the `Phase 0` : https://github.com/jumisa/ems-ops/tree/phase-0#readme 
- How ro daemonize the services

## Process As Service 
 ### 1. Java Backend
 #### Build File to `/opt` dir
- Create a folder : `mv /opt/java-backend`
- Copy the `*.jar` generated in `Phase 1` using `mvn clean install` to `/opt/java-backend`


 #### Create `SystemD` Service
 - Create a service file under `/etc/systemd/system/` ie `sudo vim /etc/systemd/system/app_ems.service`
 - Use the following to update the above created service file
 - Replace `User=homelab` with your OS username
  ```
        [Unit]
        Description=StudentsystemApplication Java service
        After=syslog.target network.target
        
        [Service]
        SuccessExitStatus=143
        User=homelab
        Type=simple
        Restart=on-failure
        RestartSec=10
        
        WorkingDirectory=/opt/java-backend/
        ExecStart=/usr/bin/java -jar springboot-backend-0.0.1-SNAPSHOT.jar
        ExecStop=/bin/kill -15 $MAINPID
        
        [Install]
        WantedBy=multi-user.target
  ```
  
 #### Daemon Reload & systemctl cmd
```
    sudo systemctl daemon-reload
    sudo systemctl start app_ems.service
    systemctl status app_ems.service
```  
 ### 2. React Front
 #### Build File to `/opt` dir
- Create a folder : `mv /opt/react-backend`
- Copy the `build` folder generated in `Phase 1` using `npm run build` to `/opt/react-frontend`


 #### Install `serve` node package
 - `npm install -g serve` to install the serve package globally

 #### Create `SystemD` Service
 - Create a service file under `/etc/systemd/system/` ie `sudo vim /etc/systemd/system/reactapp_ems.service`
 - Use the following to update the above created service file
 - Replace `User=homelab` with your OS username
  ```
        [Unit]
        Description=StudentsystemApplication React service
        After=syslog.target network.target
        
        [Service]
        SuccessExitStatus=143
        User=homelab
        Type=simple
        Restart=on-failure
        RestartSec=10
        
        WorkingDirectory=/opt/react-backend/
        ExecStart=serve -s build
        ExecStop=/bin/kill -15 $MAINPID
        
        [Install]
        WantedBy=multi-user.target
  ```
  
 #### Daemon Reload & systemctl cmd
```
    sudo systemctl daemon-reload
    sudo systemctl start reactapp_ems.service
    systemctl status reactapp_ems.service
```  
 