#!/bin/bash

set -e

LAMBDAS=("create_url")

for LAMBDA in "${LAMBDAS[@]}"; do
  echo "📦 Iniciando empacotamento da Lambda: $LAMBDA"

  LAMBDA_DIR="src/lambdas/${LAMBDA}"
  PACKAGE_DIR="${LAMBDA_DIR}/package"

  # Caminho absoluto do zip
  ZIP_PATH="$(pwd)/infra/lambdas/${LAMBDA}/lambda_${LAMBDA}.zip"

  # Verifica se o caminho do zip está correto
  if [ -z "$ZIP_PATH" ]; then
    echo "❌ Caminho do arquivo .zip não está definido corretamente!"
    exit 1
  fi

  # Garantir que o diretório do ZIP exista
  ZIP_DIR="$(dirname "$ZIP_PATH")"
  if [ ! -d "$ZIP_DIR" ]; then
    echo "📂 Criando diretório de saída: $ZIP_DIR"
    mkdir -p "$ZIP_DIR"
  fi

  echo "➡️ Acessando diretório da lambda: $LAMBDA_DIR"
  cd "$LAMBDA_DIR"

  echo "🧹 Removendo diretório package anterior (se existir)..."
  rm -rf package

  echo "📁 Criando diretório package..."
  mkdir -p package

  echo "📦 Instalando dependências do requirements.txt..."
  pip install -r requirements.txt --target package

  echo "📂 Copiando arquivos .py para dentro do package..."
  find . -maxdepth 1 -type f -name "*.py" -exec cp {} package/ \;

  echo "🗜️ Compactando arquivos em: $ZIP_PATH"
  cd package
  echo "🗜️ Compactando com Python zipfile..."
  python -m zipfile -c "$ZIP_PATH" .

  cd - > /dev/null

  echo "✅ Lambda $LAMBDA empacotada com sucesso!"
  echo "------------------------------------------"
done

echo "🎉 Todas as lambdas foram empacotadas com sucesso!"
