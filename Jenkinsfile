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
            steps{
               
                    sh '''
                    ls
                    cd react-hooks-frontend
                    pipeline {
    agent any

    stages {
        stage('Install Node.js') {
            steps {
                script {
                    // Check if NVM is installed, if not, install it
                    sh '''
                        if [ ! -d ~/.nvm ]; then
                            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
                        fi
                    '''
                    
                    // Use NVM to install Node.js version 14
                    sh '''
                        . ~/.nvm/nvm.sh
                        nvm install 14
                    '''
                }
            }
        }
        // Add more stages as needed
    }
}
                  
       '''
           
    }
}
}
}
