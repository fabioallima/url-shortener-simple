#!/bin/bash

set -e

LAMBDAS=("create_url")

for LAMBDA in "${LAMBDAS[@]}"; do
  echo "Empacotando lambda: $LAMBDA"
  cd "src/lambdas/${LAMBDA}"
  rm -rf package
  mkdir -p package
  pip install -r requirements.txt --target package
  cp -r . package/
  cd package
  zip -r "../../../../infra/lambdas/${LAMBDA}/lambda.zip" .
  cd - > /dev/null
done

echo "Todas as lambdas foram empacotadas com sucesso!"