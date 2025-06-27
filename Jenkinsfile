pipeline {
    agent any

    stages {
        stage('Build Imagem de Build') {
            steps {
                echo 'Construindo imagem do estágio de build...'
                sh '''
                    docker build --target build -t minha-imagem-build "
                        echo '--- DENTRO DO CONTAINER DE BUILD ---';
                        echo 'Hostname:'; hostname;
                        echo 'Usuário:'; whoami;
                        echo 'Diretório atual:'; pwd;
                        echo 'Arquivos disponíveis:'; ls -l;
                    "
                '''
            }
        }

        stage('Build Imagem de Teste') {
            steps {
                echo 'Construindo imagem do estágio de testes...'
                sh 'docker build --target test -t minha-imagem-test .'
            }
        }

        stage('Test') {
            steps {
                echo 'Executando os testes no container de testes...'
                sh '''
                    docker run --rm minha-imagem-test sh -c "
                        echo '--- DENTRO DO CONTAINER DE TESTE ---';
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
