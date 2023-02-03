pipeline {
    agent {
        label 'centos8stream'
    }

    stages {
        stage('get repo vector-role with tag 1.1.0') {
            steps {
                checkout changelog: false, poll: false, scm: [$class: 'GitSCM', branches: [[name: '1.0.1']], extensions: [], userRemoteConfigs: [[credentialsId: '2844bee6-94bf-4c3b-ad15-f48b41ddc99a', url: 'git@github.com:keqpup232/vector-role.git']]]
            }
        }
        stage('install molecule and m_docker') {
            steps {
                sh '''pip3 install "molecule==3.4.0" "molecule_docker"
                molecule --version'''
            }
        }
        stage('molecule test') {
            steps {
                sh 'molecule test'
            }
        }
    }
}