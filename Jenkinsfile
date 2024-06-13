pipeline {
    parameters {
        booleanParam(name: 'autoApprove', defaultValue: true, description: 'Automatically run apply after generating plan?')
    } 
    // environment {
    //     AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
    //     AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    // }

    agent any
    stages {

        // stage('Fetch_Cred') {
        //     steps {
        //         withCredentials([[
        //         $class: 'AmazonWebServicesCredentialsBinding',
        //         credentialsId: 'aws_credentials',
        //         accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        //         secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        //         ]]) 
        //         {
        //             // Now you can use AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY as environment variables
        //             sh 'echo $AWS_ACCESS_KEY_ID'
        //             sh 'echo $AWS_SECRET_ACCESS_KEY'
        //         }
        //     }
        // }
        
        stage('Checkout') {
            steps {
                script {
                    dir("terraform") {
                        git "https://github.com/mayur0319/Terraform_Jenkins.git"
                    }
                }
            }
        }

        // stage('Check AWS Credentials') {
        //     steps {
        //         script {
        //             sh 'aws sts get-caller-identity'
        //         }
        //     }
        // }

        stage('Plan') {
            steps {
                withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'aws_credentials',
                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh 'pwd; cd terraform/ ; terraform init'
                    sh 'pwd; cd terraform/ ; terraform plan -out tfplan'
                    sh 'pwd; cd terraform/ ; terraform show -no-color tfplan > tfplan.txt'
                }
            }
        }

        // stage('Approval') {
        //     when {
        //         not {
        //             equals expected: true, actual: params.autoApprove
        //         }
        //     }
        //     steps {
        //         script {
        //         withCredentials([[
        //             $class: 'AmazonWebServicesCredentialsBinding',
        //             credentialsId: 'aws_credentials',
        //             accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        //             secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        //         ]]){
        //                 def plan = readFile 'terraform/tfplan.txt'
        //                 input message: "Do you want to apply the plan?",
        //                 parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
        //            }
        //         }
        //     }
        // }

        stage('Apply') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws_credentials',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh 'pwd; cd terraform/ ; terraform apply -input=false tfplan'
                }
            }
        }
    }
}
