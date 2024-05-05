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


stage ('nvm installation'){
    steps {
    
    scritp{ 
    
    
     // Define the NVM installation script URL
def nvmInstallScriptUrl = 'https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh'

// Execute the shell command to download and execute the NVM installation script
def process = "curl -o- $nvmInstallScriptUrl | bash".execute()

// Wait for the process to finish and capture the exit code
def exitCode = process.waitFor()

// Check if the installation was successful
if (exitCode == 0) {
    println "NVM installation successful."
} else {
    println "NVM installation failed. Exit code: $exitCode"
}

// Source the NVM script into the current session
def sourceNvmScript = "source ~/.bashrc".execute()
sourceNvmScript.waitFor()

// Verify NVM installation
def nvmVersion = "nvm --version".execute().text.trim()
println "NVM version: $nvmVersion"

// Install Node.js version 14
def installNode14 = "nvm install 14".execute()
installNode14.waitFor()

// Verify Node.js installation
def node14Version = "node --version".execute().text.trim()
println "Node.js version 14 installed. Version: $node14Version"

// Set Node.js 14 as the default version
def setDefaultNode14 = "nvm alias default 14".execute()
setDefaultNode14.waitFor()

// Verify default Node.js version
def defaultNodeVersion = "node --version".execute().text.trim()
println "Default Node.js version set to 14. Version: $defaultNodeVersion"

     
     }
     }
     }
     
     
        
}
}
