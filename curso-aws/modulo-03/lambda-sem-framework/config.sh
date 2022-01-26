#!bin/bash

# 1 configuração de role e criação de log
aws iam create-role \
    --role-name lambda-example \
    --assume-role-policy file://security-policy.json \
    | tee logs/roles.log

# 2 zip do arquivo de código fonte 
zip handler.zip index.js

# 3 criação da lambda na aws (precisa atualizar o arn da role ao criar uma nova role no passo 1)
aws lambda create-function  --function-name greeting-cli \
    --zip-file fileb://handler.zip \
    --handler index.handler --runtime nodejs14.x \
    --role arn:aws:iam::022753863279:role/lambda-example  \
    | tee logs/lambda.log

# 4 invocação de lambda
aws lambda invoke  \
    --function-name greeting-cli \
    --log-type Tail \
    logs/lambda-exec.log

# 5 (opcional) atualização de 
#zip handler.zip index.js
#aws lambda update-function-code  --function-name greeting-cli \
#    --zip-file fileb://handler.zip \
#    --publish  \
#    | tee logs/lambda-update.log

# 6 (opcional) remoção da infra

# 6.1 remoção da function
aws lambda delete-function \
    --function-name greeting-cli

# 6.2 remoção da role
aws iam delete-role \
    --role-name lambda-example






