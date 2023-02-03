node {

    def cur_tag

    stage("Git checkout"){
        git branch: 'main', credentialsId: 'cb208ab1-526c-455d-8eae-bc29a33f79ee', url: 'git@github.com:keqpup232/app-diplom.git'
        script {
          cur_tag=sh(returnStdout: true, script: "git describe --abbrev=0 --tags").trim()
        }
        println cur_tag
    }

    stage("Sample define secret_check"){
        secret_check=true
    }

    stage("Build image"){
        sh("docker buildx build --platform linux/amd64 -f ./Dockerfile -t nginx .")
    }

    stage('Test image') {
        sh("docker stop nginx${cur_tag}")
        sh("docker rm nginx${cur_tag}")
        sh("docker run --name nginx${cur_tag} -d -p 80:80 keqpup232/nginx:${cur_tag}")
        script {
            final String url = "http://localhost:80/index.html"
            final String code = sh(script: "curl -s -o /dev/null -w '%{http_code}' $url", returnStdout: true).trim()
            echo "HTTP response status code: $code"
            if (code != "200") {
                echo "Error! status code: $code"
            }
        }
    }

    stage('Login Push Logout') {
        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
           sh ("docker login -u=${USERNAME} -p=${PASSWORD}")
           sh ("docker push keqpup232/nginx:${cur_tag}")
           sh ("docker logout")
        }
    }

    stage('Deploy App') {
          sh 'kubectl apply -f kube_deploy.yml -n prod'
    }
}