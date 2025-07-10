pipeline {
    agent any
    environment {
        public_ip = sh(script: 'curl -s http://ifconfig.me/ip', returnStdout: true).trim()
        }
   
    stages {
        stage('Checkout') {
            steps {
                script {
                    // Clone the Git repository's master branch
                    def gitRepoUrl = 'https://github.com/vignesh-0002/EMS-ops.git'

                    checkout([$class: 'GitSCM', 
                        branches: [[name: '*/phase-0']], 
                        userRemoteConfigs: [[url: gitRepoUrl]], 
                        extensions: [[$class: 'CleanBeforeCheckout'], [$class: 'CloneOption', noTags: false, shallow: true, depth: 1]]
                    ])
                }
            }
        }
   stage ('nvm installation') {
      steps {
script {
            sh '''   
            
         sudo apt update
         sudo systemctl stop unattended-upgrades
         sudo apt install npm -y
         sudo npm cache clean -f
         sudo npm install -g n
         sudo n 14
         node -v
    '''
        }
}
}
              stage ('npm build') {
steps {
    script {
        sh '''
         cd react-hooks-frontend/src/services 
    public_ip=$(curl -s http://ifconfig.me/ip)
    sudo perl -pi -e 's/localhost/13.234.10.17/g' EmployeeService.js
    
    npm install
    npm run build
    ls
        '''
    }
}
          
      }  
 stage ('daemonizing') {
steps {
    script {
        sh'''
    ls
    sudo npm install -g serve 
    ls
    sudo mkdir /opt/react-frontend
    cd react-hooks-frontend
    sudo cp -r build /opt/react-frontend
    
sudo touch /etc/systemd/system/reactapp_ems.service

sudo touch /etc/systemd/system/reactapp_ems.service
echo "[Unit]
      Description=StudentsystemApplication React service
      After=syslog.target network.target

      [Service]
      SuccessExitStatus=143
      User=ubuntu 
     Type=simple
      Restart=on-failure
      RestartSec=10

      WorkingDirectory=/opt/react-frontend/
      ExecStart=serve -s build
     ExecStop=/bin/kill -15 $MAINPID

      [Install]
      WantedBy=multi-user.target" yes | sudo tee -a /etc/systemd/system/reactapp_ems.service
    
    cat /etc/systemd/system/reactapp_ems.service
    
    sudo systemctl daemon-reload
    sudo systemctl start reactapp_ems.service
    sudo systemctl status reactapp_ems.service
        '''
    }
}
 }
     stage('my-sql-db-creation'){
         steps {
    script {
        sh '''
        sudo apt install mysql-client-core-8.0 -y
        sudo mysql -h database-1.cdco6ac0ygle.ap-south-1.rds.amazonaws.com -u admin -padmin123 <<eof
        Create database ems;
        GRANT ALL PRIVILEGES ON ems.* TO 'admin'@'%' WITH GRANT OPTION;
        FLUSH PRIVILEGES;
        exit
        eof
        '''
        }
        }
        }

  stage('updating_RDS_name_in_application_properties'){
         steps {
    script {
        sh '''
        cd springboot-backend/src/main/resources
        ls
        sudo sed -i 's/password/admin123/2' application.properties
        sudo sed -i 's/app_user/admin/' application.properties  
        sudo sed -i 's/localhost/database-1.cdco6ac0ygle.ap-south-1.rds.amazonaws.com/' application.properties
        pwd
        '''
        }
        }
        }

 stage('mvn-install') {
        
        steps {
    script {
        sh '''
        ls
        cd springboot-backend
        sudo apt update
sudo apt install openjdk-17-jdk openjdk-17-jre -y
wget https://downloads.apache.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.tar.gz
sudo tar xf apache-maven-3.8.8-bin.tar.gz -C /opt
touch ~/.bashrc
echo "export M2_HOME=/opt/apache-maven-3.8.8
export MAVEN_HOME=/opt/apache-maven-3.8.8
export PATH=${M2_HOME}/bin:${PATH}" yes | sudo tee -a ~/.bashrc
export PATH=/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/snap/bin:/opt/apache-maven-3.8.8/bin

         mvn -v

         mvn clean 

         mvn install

         cd target

         sudo mkdir /opt/java-backend

         sudo cp -r springboot-backend-0.0.1-SNAPSHOT.jar /opt/java-backend

        '''
        }
        }
        }

        stage('deamon'){
         steps {
    script {
        sh '''
sudo touch /etc/systemd/system/app_ems.service

echo "[Unit]
Description=StudentsystemApplication Java service
After=syslog.target network.target

[Service]
SuccessExitStatus=143
User=ubuntu
Type=simple
Restart=on-failure
RestartSec=10

WorkingDirectory=/opt/java-backend/
ExecStart=/usr/bin/java -jar springboot-backend-0.0.1-SNAPSHOT.jar
ExecStop=/bin/kill -15 $MAINPID

[Install]
WantedBy=multi-user.target" yes | sudo tee -a /etc/systemd/system/app_ems.service

    sudo systemctl daemon-reload
    sudo systemctl start app_ems.service
    sudo systemctl status app_ems.service
        '''
        }
        }
        }


           stage ('Docker installation') {
      steps {
script {
            sh '''   
                sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
                curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
                echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                sudo apt update
                sudo apt install docker-ce docker-ce-cli containerd.io -y
                sudo usermod -aG docker $USER 
                sudo systemctl enable docker
                sudo systemctl start docker
                docker --version
                ls
                pwd
                sudo apt-get update
                sudo apt-get install docker-compose-plugin
                sudo groupadd docker
                sudo usermod -aG docker $USER
                sudo newgrp docker
                sudo docker network create ems-ops
                sudo docker-compose up -d
    '''
        }
}
}


        
}
}
