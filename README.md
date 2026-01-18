 [![WinPatch QA CI](https://github.com/Gabriel-belisario-dev/windows-patch-automation-qa/actions/workflows/ci.yml/badge.svg)](https://github.com/Gabriel-belisario-dev/windows-patch-automation-qa/actions/workflows/ci.yml)

# 🛡️ WinPatch QA Suite

> Automação de Patch Management inteligente com validação de qualidade (QA) integrada.

Este projeto demonstra uma abordagem de **Engenharia de Qualidade** aplicada a operações de TI (IT Ops). Ele simula um agente de atualização para Windows que consulta uma API de conformidade antes de aplicar correções, garantindo que apenas máquinas vulneráveis sejam alteradas.

## 🚀 Tecnologias Utilizadas

* **PowerShell**: Scripting do lado do cliente (Client-side automation).
* **Pester 5**: Framework de testes para validação de lógica e Mocks.
* **Python (FastAPI)**: API REST para controle de versões homologadas.
* **Git**: Controle de versão.

## ⚙️ Arquitetura da Solução

1.  **O Agente (PowerShell)**: Coleta dados do SO e consulta a API.
2.  **A API (Python)**: Verifica se a versão instalada contém CVEs (Vulnerabilidades) conhecidas.
3.  **O Teste (QA)**: Uma suíte de testes que simula as respostas da API para garantir que o script de atualização só seja acionado quando estritamente necessário (Idempotência).

## 🧪 Como Rodar os Testes (QA)

Para validar a lógica do script sem alterar o sistema operacional:

```powershell
# Instale as dependências
Install-Module Pester -Force -SkipPublisherCheck

# Execute a suíte de testes
Invoke-Pester ./tests/Update-DotNet.tests.ps1 -Output Detailed