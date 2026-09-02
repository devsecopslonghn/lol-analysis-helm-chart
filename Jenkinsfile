pipeline {
    agent any
    options {
        disableConcurrentBuilds(abortPrevious: true)
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timeout(time: 10, unit: 'MINUTES')
    }
    stages {
        stage('Validate Helm chart') {
            steps {
                sh 'helm lint .'
                sh 'helm template lol-analysis . --namespace lol-analysis > rendered.yaml'
                sh 'test "$(grep -c "^kind:" rendered.yaml)" -ge 5'
                sh '! grep -q "^kind: Ingress$" rendered.yaml'
            }
        }
        stage('Validate rendered resources') {
            steps {
                sh 'kubectl apply --dry-run=client -f rendered.yaml >/dev/null'
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'rendered.yaml', allowEmptyArchive: true
        }
    }
}
