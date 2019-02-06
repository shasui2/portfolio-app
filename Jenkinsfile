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
                                sshCommand remote: remote, command: "docker-compose down"
                            } catch (err) {
                                echo: 'caught error: $err'
                            }
                            sshCommand remote: remote, command: "git fetch && git checkout FETCH_HEAD -- docker-compose.yml"
                            sshCommand remote: remote, command: "docker-compose run start_dependencies"
                            sshCommand remote: remote, command: "docker-compose up -d web"
                            sshCommand remote: remote, command: "docker-compose run --rm web rake db:setup"
                            sshCommand remote: remote, command: "docker-compose run --rm web rake db:migrate"
                            sshCommand remote: remote, command: "docker system prune"
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
    I am using docker-compose rather than Kubernetes as the t2.micros only have 1GB of memory.
    Start dependencies will wait until the database is ready before proceeding so that migrations run successfully.
*/
