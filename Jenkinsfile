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
            if (isUnix()) {
                // Use 'sh' step to execute shell commands
                sh '''
                if [ ! -d ~/.nvm ]; then
                    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
                fi
                '''
            } else {
                // For non-Unix systems, you might need to provide appropriate commands
                echo 'Non-Unix system, skipping Node.js installation.'
            }
         sh '''
         node -v
         '''
        }
}
}




        stage('Install NVM and Node.js') {
            steps {
                script {
                    '''
                    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

                    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
                    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

                    source ~/.bashrc

                    nvm -v

                    nvm install 14

                    node -v
                    
                    '''
                }
            }
        }

     
        
}
}
