#!/bin/bash

# Nombre del stack de CloudFormation
stack_name="Dms--Task"

# Ruta al archivo de plantilla de CloudFormation
#template_file="./Template.yaml"

# Parámetros opcionales de CloudFormation (si es necesario)

account_id=$(aws sts get-caller-identity --query "Account" --output text)

bucket="s3://bucket-dms-excel-$account_id/cf_file_out/taskparams.json"

aws s3 cp "$bucket"

SCRIPT_DIR=$(dirname "$0")
template_file="$SCRIPT_DIR/template.yml"
parameters="$SCRIPT_DIR/taskparams.json"
# Región de AWS donde se desplegará el stack

region=$(aws configure get region)

# Comando para desplegar el stack utilizando la AWS CLI
aws cloudformation create-stack --stack-name "$stack_name" --template-body file://"$template_file" --parameters file://"$parameters" --region "$region" --capabilities CAPABILITY_IAM

rm taskparams.json
