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

        stage('Build') {
            steps {
                // Build your application here (e.g., compile, package, etc.)
                sh '''
                ls
               
                sudo apt install openjdk-17-jdk openjdk-17-jre -y              
                 
                wget https://dlcdn.apache.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.tar.gz

                tar -xvf apache-maven-3.8.8-bin.tar.gz

                sudo mv apache-maven-3.8.8 /opt/

                sudo cat <<EOF >> ~/.profile 
                          M2_HOME='/opt/apache-maven-3.8.8'
                          PATH="\$M2_HOME/bin:\$PATH"
                          export PATH
                           EOF

                source ~/.profile

                mvn -v

                '''
            }
        }

        stage('Test') {
            steps {
                // Run your tests (e.g., unit tests, integration tests)
                sh 'echo "In Test Step"'
            }
        }

        stage('Deploy') {
            steps {
                // Deploy your application to a target environment (e.g., staging, production)
                sh 'echo "Value of ENV Varaible is "$MY_ENV_VAR""'
            }
        }
    }

    post {
        success {
            // Actions to perform when the pipeline succeeds
            echo 'Pipeline succeeded!'
        }
        failure {
            // Actions to perform when the pipeline fails
            echo 'Pipeline failed!'
        }
    }
}
