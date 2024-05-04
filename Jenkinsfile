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
                directory (react-hooks-frontend){
                    sh '''
                    ls
                     def nodeVersion = '14'

// Install NVM if not already installed
if (!new File("~/.nvm").exists()) {
    println("Installing NVM...")
    "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash".execute().waitFor()
    println("NVM installed.")
}

// Install Node.js version 14 using NVM
println("Installing Node.js version ${nodeVersion}...")
def nvmCommand = "/bin/bash -c '. ~/.nvm/nvm.sh && nvm install ${nodeVersion}'"
nvmCommand.execute().waitFor()
println("Node.js version ${nodeVersion} installed.")

       '''
           }
          }
    }
}
}
