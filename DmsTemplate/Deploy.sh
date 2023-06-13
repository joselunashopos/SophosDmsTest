#!/bin/bash

# Nombre del stack de CloudFormation
stack_name="STK--Dms"

# Ruta al archivo de plantilla de CloudFormation
#template_file="./Template.yaml"

# Parámetros opcionales de CloudFormation (si es necesario)

account_id=$(aws sts get-caller-identity --query "Account" --output text)

bucket="s3://bucket-dms-excel-$account_id/cf_file_out/params.json"

aws s3 cp "$bucket" .

SCRIPT_DIR=$(dirname "$0")
template_file="$SCRIPT_DIR/template.yml"

pDBSourceEngine=$(jq -r '.[] | select(.ParameterKey=="pDBSourceEngine") | .ParameterValue' "$SCRIPT_DIR/parameters.json")
pDBSourcePort=$(jq -r '.[] | select(.ParameterKey=="pDBSourcePort") | .ParameterValue' "$SCRIPT_DIR/parameters.json")
pDBSourceName=$(jq -r '.[] | select(.ParameterKey=="pDBSourceName") | .ParameterValue' "$SCRIPT_DIR/parameters.json")
pDBSourceSecretFolder=$(jq -r '.[] | select(.ParameterKey=="pDBSourceSecretFolder") | .ParameterValue' "$SCRIPT_DIR/parameters.json")
pDMSSchemaFilter=$(jq -r '.[] | select(.ParameterKey=="pDMSSchemaFilter") | .ParameterValue' "$SCRIPT_DIR/parameters.json")
pDMSTableFilter=$(jq -r '.[] | select(.ParameterKey=="pDMSTableFilter") | .ParameterValue' "$SCRIPT_DIR/parameters.json")
parameters="$SCRIPT_DIR/params.json"
# Región de AWS donde se desplegará el stack

region=$(aws configure get region)

# Comando para desplegar el stack utilizando la AWS CLI
aws cloudformation create-stack --stack-name "$stack_name" --template-body file://"$template_file" --parameters file://"$parameters" --region "$region" --capabilities CAPABILITY_IAM

rm params.json
