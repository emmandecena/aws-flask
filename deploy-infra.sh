#!/bin/bash

STACK_NAME=aws-flask-stack
REGION=us-east-1
CLI_PROFILE=aws-flask
EC2_INSTANCE_TYPE=t2.micro

AWS_ACCOUNT_ID=`aws sts get-caller-identity --profile aws-flask \
    --query "Account" --output text`
CODEPIPELINE_BUCKET="$STACK_NAME-$REGION-codepipeline-$AWS_ACCOUNT_ID"

# Deploys static resources
echo -e "\n\n=========== Deploying setup.yaml ===========" 
aws cloudformation deploy \
--region $REGION \
--profile $CLI_PROFILE \
--stack-name $STACK_NAME-setup \
--template-file setup.yaml \
--no-fail-on-empty-changeset \
--capabilities CAPABILITY_NAMED_IAM \
--parameter-overrides \
CodePipelineBucket=$CODEPIPELINE_BUCKET 

# Deploys the CloudFormation template
echo -e "\n\n=========== Deploying main.yaml ===========" 
aws cloudformation deploy \
--region $REGION \
--profile $CLI_PROFILE \
--stack-name $STACK_NAME \
--template-file main.yaml \
--no-fail-on-empty-changeset \
--capabilities CAPABILITY_NAMED_IAM \
--parameter-overrides \
EC2InstanceType=$EC2_INSTANCE_TYPE

 # If the deploy succeeded, show the DNS name of the created instance
if [ $? -eq 0 ]; then
    aws cloudformation list-exports \
    --profile aws-flask \
    --query "Exports[?Name=='InstanceEndpoint'].Value"
fi

