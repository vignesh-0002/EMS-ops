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
    
    sudo perl -pi -e 's/localhost/3.219.6.4/g' EmployeeService.js
    
    npm install
    npm run build
    ls
        '''
    }
}
          
      }  
}
}
