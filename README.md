# ⚡ Lambda URL Shortener com Terraform e GitHub Actions

Este projeto implementa um encurtador de URLs **serverless** utilizando **AWS Lambda**, **DynamoDB** e **Terraform** para infraestrutura como código. O processo de deploy é automatizado via **GitHub Actions**.

---

## 🚀 Funcionalidades

* 🧠 **AWS Lambda**: Função em Python para gerar URLs curtas.
* 🗃️ **DynamoDB**: Armazena o mapeamento entre URLs curtas e longas.
* 🛠️ **Terraform**: Gerencia a infraestrutura na AWS.
* 🤖 **GitHub Actions**: Automatiza o empacotamento e deploy.
* 📦 **S3 Backend**: Armazena o estado do Terraform com versionamento.
* 🔒 **DynamoDB Lock**: Garante exclusividade nas operações do Terraform.

---

## 📋 Pré-requisitos

1. Conta AWS com acesso programático.
2. [Terraform](https://www.terraform.io/downloads) instalado.
3. Python 3.11 ou superior.
4. Adicione os **secrets** no repositório GitHub:

   * `AWS_ACCESS_KEY_ID`
   * `AWS_SECRET_ACCESS_KEY`

---

## 🧾 Estrutura do Projeto

```
.
├── build.sh
├── infra/                         # Arquivos Terraform
│   ├── main.tf                    # Configuração principal
│   ├── s3.tf                      # Configuração do backend S3
│   ├── dynamodb.tf                # Configuração do DynamoDB
│   └── ...
├── src/
│   └── lambdas/
│       └── create_url/           # Função Lambda em Python
│           ├── lambda_function.py
│           └── requirements.txt
└── .github/
    └── workflows/
        ├── deploy.yml            # Pipeline de deploy
        └── init-infra.yml        # Pipeline de inicialização do backend
```

---

## 🔧 Configuração do Backend Terraform

O projeto utiliza um backend remoto no S3 com bloqueio de estado no DynamoDB:

### Recursos Criados

1. **Bucket S3** (`url-shortener-terraform-state-dev`):
   - Armazena o estado do Terraform
   - Versionamento habilitado
   - Criptografia server-side
   - Acesso público bloqueado

2. **Tabela DynamoDB** (`terraform-state-lock-dev`):
   - Gerencia o bloqueio do estado
   - Evita conflitos em operações simultâneas
   - Modo de cobrança sob demanda

### Inicialização do Backend

Para criar a infraestrutura do backend:

1. Vá para a aba "Actions" no GitHub
2. Selecione o workflow "Initialize Terraform Infrastructure"
3. Clique em "Run workflow"

O workflow vai:
- Verificar se os recursos já existem
- Criar o bucket S3 e a tabela DynamoDB se necessário
- Configurar o backend do Terraform

### Configuração no Terraform

O backend é configurado em `infra/main.tf`:

```hcl
terraform {
  backend "s3" {
    bucket         = "url-shortener-terraform-state-dev"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock-dev"
    encrypt        = true
  }
}
```

---

## 💻 Como Executar Localmente

### 1. Clone o Repositório

```bash
git clone https://github.com/<seu-usuario>/<seu-repositorio>.git
cd <seu-repositorio>
```

### 2. Instale as Dependências Python

```bash
cd src/lambdas/create_url
pip install -r requirements.txt
```

### 3. Empacote a Lambda

```bash
bash build.sh
```

> Isso irá gerar o arquivo `lambda_create_url.zip` usado pelo Terraform.

### 4. Deploy com Terraform

```bash
cd ../../../../infra
terraform init
terraform plan
terraform apply
```

---

## ⚙️ Deploy Automatizado (CI/CD)

Após o push para a branch `main`, a pipeline do GitHub Actions será executada automaticamente:

1. Empacota a função Lambda.
2. Executa o Terraform para provisionar ou atualizar a infraestrutura.

Arquivo: `.github/workflows/deploy.yml`

---

## 🧠 Como Funciona

* **Lambda**: Cria URLs curtas.
* **DynamoDB**: Guarda os mapeamentos entre URLs curtas e longas.
* **Terraform**: Gerencia Lambda, DynamoDB, IAM e outras dependências.
* **GitHub Actions**: Automatiza o deploy completo.
* **S3 Backend**: Armazena o estado do Terraform com versionamento.
* **DynamoDB Lock**: Garante exclusividade nas operações.
* **Secrets**: AWS_ACCESS_KEY_ID e AWS_SECRET_ACCESS_KEY são usados para autenticação.
* **Build**: O script `build.sh` empacota a função Lambda e suas dependências em um arquivo ZIP.
* **Deploy**: O Terraform aplica as mudanças na infraestrutura, criando ou atualizando os recursos necessários.

---

## 🧹 Limpeza de Recursos

Para destruir todos os recursos criados:

```bash
cd infra
terraform destroy
```

> ⚠️ **Atenção**: O bucket S3 e a tabela DynamoDB do backend não serão destruídos por padrão para proteger o estado do Terraform.

---

## 📌 Observações

* Certifique-se de que os **secrets da AWS** estão configurados corretamente no GitHub.
* Para customizar a região AWS ou caminho do ZIP, edite `infra/variables.tf`.
* O arquivo `build.sh` deve ter permissão de execução. Use `chmod +x build.sh` se necessário.
* O arquivo `lambda_create_url.zip` deve ser atualizado sempre que houver mudanças na função Lambda.
* O DynamoDB tem custos associados. Monitore o uso e limpe os recursos quando não forem mais necessários.
* O estado do Terraform é versionado no S3, permitindo rollback se necessário.
* O bloqueio de estado no DynamoDB evita conflitos em operações simultâneas.