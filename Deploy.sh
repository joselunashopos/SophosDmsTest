#!/bin/bash

# Nombre del stack de CloudFormation
stack_name="SKT-tst2"

# Ruta al archivo de plantilla de CloudFormation
template_file="./Template.yaml"

# Parámetros opcionales de CloudFormation (si es necesario)
parameters="ParameterKey=DBSourceName,ParameterValue=testgitbucket"


# Región de AWS donde se desplegará el stack
region="us-east-1"

# Comando para desplegar el stack utilizando la AWS CLI
aws cloudformation create-stack --stack-name "$stack_name" --template-body "$template_file" --parameters "$parameters" --region "$region"
