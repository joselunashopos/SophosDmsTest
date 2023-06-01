#!/bin/bash

# Nombre del stack de CloudFormation
stack_name="SKT-tst2"

# Ruta al archivo de plantilla de CloudFormation
#template_file="./Template.yaml"

# Parámetros opcionales de CloudFormation (si es necesario)
SCRIPT_DIR=$(dirname "$0")
template_file="$SCRIPT_DIR/Template.yml"


$BucketName=$(sed -e 's/^"//' -e 's/"$//' <<<"$(jq '.[] | select(.ParameterKey=="pBucketName") | .ParameterValue' $DIRNAME/parameters.json)")

parameters="ParameterKey=pTeamName,ParameterValue=$BucketName"
# Región de AWS donde se desplegará el stack
region="us-east-1"

# Comando para desplegar el stack utilizando la AWS CLI
aws cloudformation create-stack --stack-name "$stack_name" --template-body file://"$template_file" --parameters "$parameters" --region "$region"
