pipeline {
    agent any

   
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
    
    sudo perl -pi -e 's/localhost/18.207.199.10/g' EmployeeService.js
    
   
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
    pwd
    
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
        
}
}
