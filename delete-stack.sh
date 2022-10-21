STACK_NAME=aws-flask-stack
REGION=us-east-1
CLI_PROFILE=aws-flask
EC2_INSTANCE_TYPE=t2.micro

# Deleting stack
echo -e "\n\n=========== Deleting stack: $STACK_NAME ===========" 
aws cloudformation delete-stack \
--profile $CLI_PROFILE \
--stack-name $STACK_NAME