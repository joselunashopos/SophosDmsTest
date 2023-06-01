#!/bin/bash

# Nombre del stack de CloudFormation
stack_name="SKT-tst2"

# Ruta al archivo de plantilla de CloudFormation
#template_file="./Template.yaml"

# Parámetros opcionales de CloudFormation (si es necesario)
SCRIPT_DIR=$(dirname "$0")
template_file="$SCRIPT_DIR/Template.yml"

pDBSourceEngine=$(jq -r '.[] | select(.ParameterKey=="pDBSourceEngine") | .ParameterValue' "$SCRIPT_DIR/parameters.json")
pDBSourcePort=$(jq -r '.[] | select(.ParameterKey=="pDBSourcePort") | .ParameterValue' "$SCRIPT_DIR/parameters.json")
pDBSourceName=$(jq -r '.[] | select(.ParameterKey=="pDBSourceName") | .ParameterValue' "$SCRIPT_DIR/parameters.json")
pDBSourceSecretFolder=$(jq -r '.[] | select(.ParameterKey=="pDBSourceSecretFolder") | .ParameterValue' "$SCRIPT_DIR/parameters.json")
pDMSSchemaFilter=$(jq -r '.[] | select(.ParameterKey=="pDMSSchemaFilter") | .ParameterValue' "$SCRIPT_DIR/parameters.json")
pDMSTableFilter=$(jq -r '.[] | select(.ParameterKey=="pDMSTableFilter") | .ParameterValue' "$SCRIPT_DIR/parameters.json")

parameters="ParameterKey=pDBSourceEngine,ParameterValue=$pDBSourceEngine "\
"ParameterKey=pDBSourcePort,ParameterValue=$pDBSourcePort "\
"ParameterKey=pDBSourceName,ParameterValue=$pDBSourceName "\
"ParameterKey=pDBSourceSecretFolder,ParameterValue=$pDBSourceSecretFolder "\
"ParameterKey=pDMSSchemaFilter,ParameterValue=$pDMSSchemaFilter "\ 
"ParameterKey=pDMSTableFilter,ParameterValue=$pDMSTableFilter "
# Región de AWS donde se desplegará el stack
region="us-east-1"

# Comando para desplegar el stack utilizando la AWS CLI
aws cloudformation create-stack --stack-name "$stack_name" --template-body file://"$template_file" --parameters "$parameters" --region "$region"
