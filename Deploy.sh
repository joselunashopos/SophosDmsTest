#!/bin/bash

# Nombre del stack de CloudFormation
stack_name="SKT-tst"

# Ruta al archivo de plantilla de CloudFormation
template_file="./template.yaml"

# Parámetros opcionales de CloudFormation (si es necesario)
# Ejemplo: parameters="ParameterKey=KeyPairName,ParameterValue=my-key"
parameters=""

# Región de AWS donde se desplegará el stack
region="us-east-1"

# Comando para desplegar el stack utilizando la AWS CLI
aws cloudformation create-stack --stack-name "$stack_name" --template-body file://"$template_file" --parameters "$parameters" --region "$region"
