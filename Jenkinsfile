pipeline {
    agent any

    stages {
        stage('Build Imagem de Build') {
            steps {
                echo 'Construindo imagem do estágio de build...'
                sh 'docker build --target build -t minha-imagem-build .'

                echo 'Executando container de build'
                sh '''
                    docker run --rm minha-imagem-build sh -c "
                        echo '--- DENTRO DO CONTAINER DE BUILD ---';
                        echo 'Preparando os arquivos...';
                        ls -l;
                        echo 'Build completo';
                    "
                '''
            }
        }

        stage('Imagem de Teste') {
            steps {
                echo 'Construindo imagem do estágio de testes...'
                sh 'docker build --target test -t minha-imagem-test .'
            }
        }

        stage('Test') {
            steps {
                echo 'Executando os testes no container de testes...'
                script {
                    def resultado = sh (
                        script: '''
                            docker run --rm minha-imagem-test sh -c "
                                echo '--- DENTRO DO CONTAINER DE TESTE ---';
                                python -m unittest discover -s tests
                            "
                        ''',
                        returnStatus: true
                    )
                    if (resultado != 0) {
                        currentBuild.result = 'UNSTABLE'
                        echo '⚠️ Testes falharam! Build marcado como INSTÁVEL.'
                    } else {
                        echo '✅ Todos os testes passaram com sucesso.'
                    }
                }
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline executado com sucesso!'
        }
        unstable {
            echo '⚠️ Pipeline concluído, mas com problemas nos testes.'
        }
        failure {
            echo '❌ Pipeline falhou completamente.'
        }
    }
}