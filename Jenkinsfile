pipeline {
    agent any

    stages {
        stage('Build Image de Build') {
            steps {
                echo 'Construindo a imagem para build...'
                sh 'docker build --target build -t minha-imagem-build .'
            }
        }

        stage('Test') {
            steps {
                echo 'Executando os testes dentro do container build...'
                sh '''
                    docker run --rm minha-imagem-build sh -c "
                        echo '--- DENTRO DO CONTAINER ---';
                        echo 'Hostname:'; hostname;
                        echo 'Usuário:'; whoami;
                        echo 'Diretório atual:'; pwd;
                        echo 'Arquivos disponíveis:'; ls -l;
                        echo 'Executando os testes...';
                        python -m unittest discover -s tests
                    "
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline executado com sucesso!'
        }
        failure {
            echo 'Pipeline falhou!'
        }
    }
}
