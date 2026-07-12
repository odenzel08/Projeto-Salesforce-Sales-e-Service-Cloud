# Sales & Service Cloud — Lead-to-Case

Projeto Salesforce desenvolvido para simular o processo completo de chegada de um novo cliente à empresa: desde a captura do Lead via formulário web até o fechamento da venda e abertura automática de um processo de onboarding, integrando **Sales Cloud** e **Service Cloud** em um único fluxo de negócio.

---

## 🎯 Objetivo

Demonstrar na prática como o Salesforce pode gerenciar o ciclo de vida completo de um cliente, eliminando trabalho manual e garantindo que cada etapa do processo aconteça de forma automática, padronizada e rastreável.

---

## 🔄 Fluxo do Projeto

```
Formulário Web (HTML/CSS/JS)
        ↓
   Lead criado via Web-to-Lead
        ↓
   Lead Assignment Rule → Fila por Setor
        ↓
   Flow: Set Rating (Hot / Warm / Cold)
        ↓
   Processo de vendas → Oportunidade
        ↓
   Closed Won → Trigger acionado
        ↓
   Case de Onboarding criado
   Onboarding Checklist criado
   Entitlement Process atribuído (Standard ou Premium)
        ↓
   Case Assignment Rule → Fila Standard ou Premium
```

---

## ⚙️ Funcionalidades

### 🟦 Sales Cloud

**Captura de Leads**
- Formulário web desenvolvido em HTML, CSS e JavaScript
- Envio via **Web-to-Lead** nativo do Salesforce
- Página de retorno customizada após o envio

**Distribuição automática de Leads**
- **Lead Assignment Rules** distribuem o Lead para a fila correta de acordo com o setor informado no formulário

**Qualificação automática com Flow Builder**
- Flow do tipo *Record-Triggered* acionado na criação do Lead
- Elemento de Decisão **Set Rating** avalia o setor do Lead e atribui o Rating automaticamente:

| Setor | Rating |
|---|---|
| Finance ou Tech | 🔴 Hot |
| Health ou Retail | 🟡 Warm |
| Demais setores | 🔵 Cold |

![Flow de Rating](./assets/flow-set-rating.png)

---

### 🟧 Service Cloud

**Criação automática do Onboarding pós-venda**
- Trigger acionado quando uma Oportunidade é fechada como **Closed Won**
- Cria automaticamente um **Case de Onboarding** vinculado à Oportunidade
- Cria um registro no objeto customizado **Onboarding Checklist**, padronizando as tarefas de integração do novo cliente

**Níveis de atendimento dinâmicos**
- Dois **Entitlement Processes** configurados e atribuídos automaticamente com base no valor da Oportunidade:

| Valor da Oportunidade | Entitlement Process |
|---|---|
| Acima de R$ 50.000 | ⭐ Premium |
| Abaixo de R$ 50.000 | Standard |

- **Case Assignment Rules** roteiam o Case para a fila correspondente (Standard ou Premium)

---

## 🗂️ Objetos Utilizados

| Objeto | Tipo | Descrição |
|---|---|---|
| Lead | Standard | Captura e qualificação do potencial cliente |
| Account | Standard | Criada na conversão do Lead |
| Contact | Standard | Criado na conversão do Lead |
| Opportunity | Standard | Gerenciamento do processo de venda |
| Case | Standard | Processo de onboarding pós-venda |
| Onboarding Checklist | **Customizado** | Rastreabilidade das etapas de onboarding |

---

## 🛠️ Tecnologias e Recursos Salesforce

- **Flow Builder** — Record-Triggered Flow com Decision Elements
- **Web-to-Lead** — Integração nativa de formulário web
- **Lead Assignment Rules** — Distribuição automática por setor
- **Case Assignment Rules** — Roteamento por nível de atendimento
- **Entitlements** — SLA e processo de atendimento pós-venda
- **Apex Triggers** — Automação de criação de Case e Onboarding Checklist
- **Objeto Customizado** — Onboarding Checklist
- **HTML / CSS / JS** — Formulário de captura de Lead

---