# ⚡ Lambda URL Shortener com Terraform e GitHub Actions

Este projeto implementa um encurtador de URLs **serverless** utilizando **AWS Lambda**, **DynamoDB** e **Terraform** para infraestrutura como código. O processo de deploy é automatizado via **GitHub Actions**.

---

## 🚀 Funcionalidades

* 🧠 **AWS Lambda**: Função em Python para gerar URLs curtas.
* 🗃️ **DynamoDB**: Armazena o mapeamento entre URLs curtas e longas.
* 🛠️ **Terraform**: Gerencia a infraestrutura na AWS.
* 🤖 **GitHub Actions**: Automatiza o empacotamento e deploy.

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
│   ├── main.tf
│   └── ...
├── src/
│   └── lambdas/
│       └── create_url/           # Função Lambda em Python
│           ├── lambda_function.py
│           └── requirements.txt
└── .github/
    └── workflows/
        └── deploy.yml            # Pipeline GitHub Actions
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

---

## 🧹 Limpeza de Recursos

Para destruir todos os recursos criados:

```bash
cd infra
terraform destroy
```

---

## 📌 Observações

* Certifique-se de que os **secrets da AWS** estão configurados corretamente no GitHub.
* Para customizar a região AWS ou caminho do ZIP, edite `infra/variables.tf`.

---

Se quiser, posso gerar também um badge de status da pipeline no topo do README. Deseja isso?
