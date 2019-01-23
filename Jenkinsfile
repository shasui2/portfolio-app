def remote = [:]
remote.name = 'prod'
remote.host = '172.31.29.212'
remote.allowAnyHosts = true
pipeline {
    agent any
    stages {
        stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    app = docker.build("shasui2/portfolio-app")
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('Deploy To Production') {
            when {
                branch 'master'
            }
            steps {
                input 'Deploy to Production?'
                milestone(1)
                withCredentials([sshUserPrivateKey(credentialsId: 'sshUser', keyFileVariable: 'identity', usernameVariable: 'userName')]) {
                    script {
                        if (isUnix()) {
                            remote.user = userName
                            remote.identityFile = identity
                            sshCommand remote: remote, command: "docker pull shasui2/portfolio-app:${env.BUILD_NUMBER}"
                            try {
                                sshCommand remote: remote, command: "docker stop portfolio-app"
                                sshCommand remote: remote, command: "docker rm portfolio-app"
                            } catch (err) {
                                echo: 'caught error: $err'
                            }
                            sshCommand remote: remote, command: "docker run --name portfolio-app -p 80:3000 -d --network portfolio shasui2/portfolio-app:${env.BUILD_NUMBER}"
                        }
                        else {
                            bat 'echo You are on Windows!'
                        }
                    }
                }
            }
        }
    }
}


/*
Test Kubernetes deployment.

stage('DeployToProduction') {
            when {
                branch 'master'
            }
            steps {
                input 'Deploy to Production?'
                milestone(1)
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'kube-deploy.yml',
                    enableConfigSubstitution: true
                )
            }
        }
*/