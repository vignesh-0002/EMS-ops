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
    
    sudo perl -pi -e 's/localhost/34.234.118.196/g' EmployeeService.js
    
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
        sh''
    ls
    sudo npm install -g serve 
  #  sudo mkdir /opt/react-frontend
    cd ../../
    ls
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
        
}
}
