#!/bin/bash

# Nombre del stack de CloudFormation
stack_name="SKT-tst2"

# Ruta al archivo de plantilla de CloudFormation
#template_file="./Template.yaml"

# Parámetros opcionales de CloudFormation (si es necesario)

aws s3 cp s3://sophos-dev-bucket/auto_files/params.json .

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
region="us-east-1"

# Comando para desplegar el stack utilizando la AWS CLI
aws cloudformation create-stack --stack-name "$stack_name" --template-body file://"$template_file" --parameters file://"$parameters" --region "$region" --capabilities CAPABILITY_IAM

rm params.json
