# n8n Docker - Railway

Este projeto configura o n8n com PostgreSQL para deploy no Railway.

## 🚀 Características

- **n8n versão 2.1.1** (versão estável mais recente)
- **Persistência com PostgreSQL** - Mantém credenciais, workflows e APIs
- **Configuração otimizada para Railway**
- **Fuso horário**: America/Sao_Paulo

## 📋 Pré-requisitos para Railway

1. Conta no Railway
2. Projeto Railway com PostgreSQL provisionado

## ⚙️ Configuração no Railway

### 1. Adicionar Banco de Dados PostgreSQL

No seu projeto Railway:
1. Clique em "New" → "Database" → "Add PostgreSQL"
2. O Railway criará automaticamente as variáveis de ambiente necessárias

### 2. Configurar Variáveis de Ambiente

O Railway já fornece automaticamente:
- `PGHOST` - Host do PostgreSQL
- `PGPORT` - Porta do PostgreSQL (geralmente 5432)
- `PGUSER` - Usuário do PostgreSQL
- `PGPASSWORD` - Senha do PostgreSQL
- `PGDATABASE` - Nome do banco de dados

**Você precisa adicionar manualmente:**

#### Obrigatória:
- `N8N_ENCRYPTION_KEY` - Chave para criptografar credenciais no banco
  - Exemplo: `mysecurekey123456789012345678901234567890`
  - **IMPORTANTE**: Use uma chave de pelo menos 32 caracteres e guarde-a em local seguro!

#### Opcionais (mas recomendadas):
- `WEBHOOK_URL` - URL do seu app no Railway
  - Exemplo: `https://seu-app.railway.app`
- `N8N_BASIC_AUTH_ACTIVE` - Ativar autenticação básica: `true`
- `N8N_BASIC_AUTH_USER` - Usuário para login
- `N8N_BASIC_AUTH_PASSWORD` - Senha para login

### 3. Deploy

1. Conecte este repositório ao Railway
2. O Railway detectará o Dockerfile automaticamente
3. Aguarde o build e deploy
4. Acesse seu n8n em: `https://seu-app.railway.app`

## 🔒 Segurança

### N8N_ENCRYPTION_KEY

A chave de criptografia (`N8N_ENCRYPTION_KEY`) é **extremamente importante**:

- Protege suas credenciais armazenadas no PostgreSQL
- Credenciais incluem: senhas de APIs, tokens, chaves OAuth, etc.
- **NUNCA compartilhe esta chave**
- **NUNCA commite esta chave no código**
- Se perder esta chave, perderá acesso às credenciais criptografadas

### Como gerar uma chave segura:

```bash
# Linux/Mac
openssl rand -base64 32

# Ou use um gerador online confiável
```

## 🧪 Teste Local com Docker Compose

Para testar localmente antes de fazer deploy:

```bash
# Build e iniciar os serviços
docker-compose up -d

# Ver logs
docker-compose logs -f n8n

# Parar os serviços
docker-compose down

# Parar e remover volumes (apaga dados do banco)
docker-compose down -v
```

Acesse: `http://localhost:8080`

## 📊 Persistência de Dados

Com PostgreSQL, os seguintes dados são persistidos automaticamente:

- ✅ **Credenciais** - Todas as credenciais de APIs e serviços
- ✅ **Workflows** - Todos os seus workflows e automações
- ✅ **Execuções** - Histórico de execuções
- ✅ **Webhooks** - Configurações de webhooks
- ✅ **Configurações** - Todas as configurações do n8n

## 🔄 Migração de Dados

Se você já tinha um n8n rodando com SQLite ou outro banco:

1. Use a [ferramenta de exportação/importação do n8n](https://docs.n8n.io/hosting/installation/server-setups/docker-compose/#data-persistence)
2. Exporte seus workflows do n8n antigo
3. Configure o novo n8n com PostgreSQL
4. Importe os workflows no novo n8n

## 🆘 Solução de Problemas

### n8n não inicia

1. Verifique se o PostgreSQL está rodando no Railway
2. Confirme que todas as variáveis de ambiente estão configuradas
3. Verifique os logs do Railway para mensagens de erro

### Erro de conexão com banco de dados

1. Verifique se as variáveis `PGHOST`, `PGPORT`, `PGUSER`, `PGPASSWORD`, `PGDATABASE` existem
2. Confirme que o serviço PostgreSQL está ativo no Railway

### Perdi minhas credenciais

Se você perdeu a `N8N_ENCRYPTION_KEY`:
- Não há como recuperar as credenciais antigas
- Você precisará reconfigurá-las manualmente no n8n

## 📚 Recursos

- [Documentação do n8n](https://docs.n8n.io/)
- [n8n Community](https://community.n8n.io/)
- [Railway Docs](https://docs.railway.app/)

## 📝 Notas de Versão

### v2.1.1
- Versão estável mais recente do n8n
- Melhorias de performance e segurança
- Suporte completo ao PostgreSQL
