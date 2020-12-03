pipeline {
    agent {
        label "devops && packer"
    }
    stages {
      stage('Checkout Packer Dockerfile repo') {
            steps {
                dir("docker-packer"){
                    git(
                        branch: 'master',
                        credentialsId: 'jenkins_bitbucket_token',
                        url: 'https://code.tatar.ru/scm/platform/docker-image-packer.git')
                    }
            }
        }
        stage("Run packer"){
            agent{
                dockerfile {
                    filename 'docker-packer/Dockerfile'
                    args "--volume=/etc/passwd:/etc/passwd:ro \
                          --volume=/etc/shadow:/etc/shadow:ro \
                          --volume=/etc/group:/etc/group:ro \
                          --mount type=tmpfs,destination=${HOME}/.ansible"
                      reuseNode true
                }
            }
            stages {
                stage('Packer build image') {
                  steps {
                      withVault(vaultSecrets:
                          [[path: 'secret/_common/jenkins_master',
                              secretValues: [
                                  [envVar: 'JENKINS_USERNAME', vaultKey: 'username'],
                                  [envVar: 'JENKINS_PASSWORD', vaultKey: 'password']
                              ]
                          ]]
                      ){
                        sshagent(['git-bitbucket-private']) {
                          sh "env"
                          sh "GIT_SSH_COMMAND=\"ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no\" \
                              packer build jenkins-agent-image.json"
                        }
                      }
                  }
                }
            }
        }
    }
}
