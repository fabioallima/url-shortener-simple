#!/bin/bash

set -e

LAMBDAS=("create_url")  # Adicione mais aqui conforme necessário

for LAMBDA in "${LAMBDAS[@]}"; do
  echo "Empacotando lambda: $LAMBDA"
  cd "src/lambdas/${LAMBDA}"
  zip -r "../../../infra/lambdas/${LAMBDA}/lambda.zip" .
  cd - > /dev/null
done

echo "Todas as lambdas foram empacotadas com sucesso!"
