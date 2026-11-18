pipeline {
    agent any

    parameters {
        string(name: 'IMAGE_TAG', defaultValue: '',
               description: 'Docker tag to push to nnsyed/ns_repo (empty = Jenkins build number)')
        booleanParam(name: 'PUSH_LATEST', defaultValue: true,
               description: 'Also tag and push nnsyed/ns_repo:latest')
        string(name: 'UBUNTU_VERSION', defaultValue: '',
               description: 'Ubuntu version for the image base (empty = same version as the Jenkins agent)')
    }

    options {
        timestamps()
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '20'))
    }

    environment {
        GITHUB_OWNER = 'nnsyed'
        GITHUB_REPO  = 'cicd'
        DOCKER_REPO  = 'nnsyed/ns_repo'
        APP_PORT     = '8001'                          // must match SERVER_PORT in the Dockerfile
        JAR_NAME     = 'helloworld-0.0.1-SNAPSHOT.jar'
        C_ARCHIVE    = 'src/c_code/target/utilities.tar.gz'
        DOCKER_BUILDKIT = '0'                          // Podman's Docker API has no BuildKit
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: "https://github.com/${GITHUB_OWNER}/${GITHUB_REPO}.git"
            }
        }

        stage('Prepare') {
            steps {
                // Fail early with a clear message if the agent is missing a tool
                sh '''
                    command -v java >/dev/null || { echo "ERROR: Java (JDK 17) is not installed on the Jenkins agent"; exit 1; }
                    command -v make >/dev/null || { echo "ERROR: make is not installed on the Jenkins agent"; exit 1; }
                    command -v gcc >/dev/null || command -v cc >/dev/null || { echo "ERROR: no C compiler (gcc) on the Jenkins agent"; exit 1; }
                    command -v docker >/dev/null || { echo "ERROR: docker CLI is not installed on the Jenkins agent"; exit 1; }
                    docker info >/dev/null 2>&1 || { echo "ERROR: Jenkins cannot talk to the Docker daemon (check /var/run/docker.sock mount and permissions)"; exit 1; }
                '''

                script {
                    // Image tag: parameter, or build number
                    def tag = (params.IMAGE_TAG ?: '').trim()
                    if (!tag) {
                        tag = env.BUILD_NUMBER
                    }
                    if (!(tag ==~ /[A-Za-z0-9_][A-Za-z0-9_.-]{0,127}/)) {
                        error "Invalid Docker tag '${tag}'. Use letters, digits, '_', '.', '-' (max 128 chars, not starting with '.' or '-')."
                    }
                    env.TAG = tag
                    env.PUSH_LATEST_TAG = (params.PUSH_LATEST == false) ? 'false' : 'true'

                    // Ubuntu base version: parameter, or match the Jenkins agent so the C binaries run
                    def ubuntu = (params.UBUNTU_VERSION ?: '').trim()
                    if (!ubuntu) {
                        def osId = sh(returnStdout: true, script: '. /etc/os-release && echo "$ID"').trim()
                        if (osId != 'ubuntu') {
                            error "The Jenkins agent is '${osId}', not Ubuntu. C binaries built here may not run on an Ubuntu image. " +
                                  "Build Jenkins on Ubuntu, or set the UBUNTU_VERSION parameter if you are sure it is compatible."
                        }
                        ubuntu = sh(returnStdout: true, script: '. /etc/os-release && echo "$VERSION_ID"').trim()
                    }
                    env.BASE_UBUNTU = ubuntu

                    echo "Image: ${env.DOCKER_REPO}:${env.TAG} (latest: ${env.PUSH_LATEST_TAG}) | Base: ubuntu:${env.BASE_UBUNTU}"
                }
            }
        }

        stage('Build & Test Java') {
            steps {
                sh 'chmod +x mvnw'
                sh './mvnw -B clean package'
                sh 'test -f "target/$JAR_NAME" || { echo "ERROR: target/$JAR_NAME was not produced"; exit 1; }'
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: 'target/surefire-reports/*.xml'
                }
            }
        }

        stage('Build C Utilities') {
            steps {
                dir('src/c_code') {
                    sh 'make clean && make'
                }
                sh '''
                    test -f "$C_ARCHIVE" || { echo "ERROR: $C_ARCHIVE was not produced by make"; exit 1; }
                    echo "Archive contents:"
                    tar -tzf "$C_ARCHIVE"
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build --pull \
                      --build-arg UBUNTU_VERSION="$BASE_UBUNTU" \
                      --build-arg JAR_FILE="target/$JAR_NAME" \
                      --build-arg C_ARCHIVE="$C_ARCHIVE" \
                      -t "$DOCKER_REPO:$TAG" .
                '''
            }
        }

        stage('Test Docker Image') {
            steps {
                sh '''
                    CID=$(docker run -d "$DOCKER_REPO:$TAG")
                    trap 'docker rm -f "$CID" >/dev/null 2>&1 || true' EXIT

                    echo '--- Java runtime ---'
                    docker exec "$CID" java -version

                    echo '--- C utilities in $HOME/bin ---'
                    docker exec "$CID" sh -c '
                        echo "HOME=$HOME"
                        ls -l "$HOME/bin"
                        [ -n "$(ls -A "$HOME/bin")" ] || { echo "ERROR: $HOME/bin is empty"; exit 1; }
                        rc=0
                        for f in "$HOME"/bin/*; do
                            [ -f "$f" ] && [ -x "$f" ] || continue
                            if ldd "$f" 2>&1 | grep -q "not found"; then
                                echo "ERROR: $f cannot run in this image (missing libraries or glibc version):"
                                ldd "$f" 2>&1 | grep "not found"
                                rc=1
                            fi
                        done
                        exit $rc
                    '

                    echo "--- Waiting for the app on port $APP_PORT ---"
                    for i in $(seq 1 30); do
                        if [ "$(docker inspect -f '{{.State.Running}}' "$CID")" != "true" ]; then
                            echo "ERROR: container exited. Logs:"
                            docker logs "$CID"
                            exit 1
                        fi
                        CODE=$(docker run --rm --network "container:$CID" docker.io/curlimages/curl \
                               -s -o /dev/null -w '%{http_code}' "http://localhost:$APP_PORT/" || true)
                        if [ -n "$CODE" ] && [ "$CODE" != "000" ]; then
                            echo "App responded with HTTP $CODE"
                            exit 0
                        fi
                        sleep 2
                    done

                    echo "ERROR: app did not respond within 60s. Logs:"
                    docker logs "$CID"
                    exit 1
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred',
                        usernameVariable: 'DOCKER_USR', passwordVariable: 'DOCKER_PSW')]) {
                    sh '''
                        echo "$DOCKER_PSW" | docker login -u "$DOCKER_USR" --password-stdin
                        docker push "$DOCKER_REPO:$TAG"
                        if [ "$PUSH_LATEST_TAG" = "true" ] && [ "$TAG" != "latest" ]; then
                            docker tag "$DOCKER_REPO:$TAG" "$DOCKER_REPO:latest"
                            docker push "$DOCKER_REPO:latest"
                        fi
                    '''
                }
            }
        }
    }

    post {
        always {
            sh '''
                docker logout >/dev/null 2>&1 || true
                # Untag the per-build image; keep :latest so the next build reuses cached layers
                if [ -n "$TAG" ] && [ "$TAG" != "latest" ]; then
                    docker rmi "$DOCKER_REPO:$TAG" >/dev/null 2>&1 || true
                fi
            '''
        }
        success {
            echo "Published ${env.DOCKER_REPO}:${env.TAG}"
        }
    }
}
