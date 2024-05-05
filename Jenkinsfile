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
                    // Define the NVM installation script URL
                    def nvmInstallScriptUrl = 'https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh'
                    
                    // Download and execute the NVM installation script
                    sh "curl -o- $nvmInstallScriptUrl | bash"
                    
                    // Source the NVM script into the current session
                    sh "source ~/.bashrc"
                    
                    // Verify NVM installation
                    sh "nvm --version"
                    
                    // Install Node.js version 14
                    sh "nvm install 14"
                    
                    // Verify Node.js installation
                    sh "node --version"
                    
                    // Set Node.js 14 as the default version
                    sh "nvm alias default 14"
                    
                    // Verify default Node.js version
                    sh "node --version"
                }
            }
        }
    


     
     
        
}
}
