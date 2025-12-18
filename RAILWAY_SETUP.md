# 🚂 Guia de Configuração no Railway

Este guia detalha passo a passo como fazer o deploy do n8n com PostgreSQL no Railway.

## 📝 Passo 1: Criar Projeto no Railway

1. Acesse [Railway.app](https://railway.app)
2. Faça login ou crie uma conta
3. Clique em "New Project"
4. Escolha "Deploy from GitHub repo"
5. Selecione este repositório

## 🗄️ Passo 2: Adicionar PostgreSQL

1. No seu projeto Railway, clique em "New"
2. Selecione "Database"
3. Escolha "Add PostgreSQL"
4. Aguarde o provisionamento do banco de dados

O Railway criará automaticamente estas variáveis:
- ✅ `DATABASE_URL`
- ✅ `PGHOST`
- ✅ `PGPORT`
- ✅ `PGUSER`
- ✅ `PGPASSWORD`
- ✅ `PGDATABASE`

## ⚙️ Passo 3: Configurar Variáveis de Ambiente do n8n

No serviço do n8n (não no PostgreSQL), adicione as seguintes variáveis:

### 🔑 OBRIGATÓRIA - Chave de Criptografia

```
N8N_ENCRYPTION_KEY
```

**Valor:** Uma string aleatória de pelo menos 32 caracteres

**Como gerar:**
```bash
# No Linux/Mac
openssl rand -base64 32

# Exemplo de resultado:
# kJ8N2mP9qR4sT5vW6xY7zA1bC2dE3fG4hI5jK6lM7nO8=
```

⚠️ **IMPORTANTE:** 
- Guarde esta chave em local seguro!
- Nunca compartilhe esta chave
- Se perder esta chave, perderá acesso às credenciais criptografadas

### 🌐 RECOMENDADAS - Configurações do App

```
WEBHOOK_URL=https://seu-app.railway.app
```
Substitua `seu-app` pelo nome real do seu app no Railway.

```
N8N_HOST=0.0.0.0
```

```
N8N_PORT=5678
```

```
N8N_PROTOCOL=https
```

```
GENERIC_TIMEZONE=America/Sao_Paulo
```

### 🔐 OPCIONAIS - Autenticação Básica

Para proteger o acesso ao n8n:

```
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=seu_usuario
N8N_BASIC_AUTH_PASSWORD=sua_senha_segura
```

## 🚀 Passo 4: Deploy

1. Após adicionar todas as variáveis, o Railway fará o deploy automaticamente
2. Aguarde o build e deploy (pode levar alguns minutos)
3. Quando o deploy terminar, clique em "View Logs" para verificar se está tudo OK
4. Clique em "Generate Domain" para obter a URL do seu app

## ✅ Passo 5: Verificar Instalação

1. Acesse a URL gerada: `https://seu-app.railway.app`
2. Se configurou autenticação básica, faça login
3. Crie sua conta de administrador no n8n
4. Pronto! Seu n8n está rodando com PostgreSQL

## 🔍 Verificação de Persistência

Para confirmar que está usando PostgreSQL:

1. Crie um workflow de teste no n8n
2. Adicione uma credencial de teste
3. Reinicie o serviço n8n no Railway (não o PostgreSQL!)
4. Aguarde o serviço voltar
5. Acesse novamente - seu workflow e credencial devem estar lá!

## 📊 O que é Persistido no PostgreSQL

✅ **Credenciais** - Todas as suas credenciais de APIs (criptografadas)
✅ **Workflows** - Todos os seus workflows e automações
✅ **Execuções** - Histórico de execuções dos workflows
✅ **Webhooks** - Todas as configurações de webhooks
✅ **Usuários** - Contas de usuário e permissões
✅ **Configurações** - Todas as configurações do sistema
✅ **Tags** - Tags de organização
✅ **Variáveis** - Variáveis de ambiente do n8n

## 🔧 Solução de Problemas

### Erro: "Cannot connect to database"

**Causa:** n8n não consegue conectar ao PostgreSQL

**Solução:**
1. Verifique se o PostgreSQL está rodando no Railway
2. Confirme que as variáveis `PGHOST`, `PGPORT`, `PGUSER`, `PGPASSWORD`, `PGDATABASE` existem
3. Verifique os logs do PostgreSQL para erros
4. Reinicie o serviço n8n

### Erro: "Encryption key is missing"

**Causa:** Variável `N8N_ENCRYPTION_KEY` não está configurada

**Solução:**
1. Adicione a variável `N8N_ENCRYPTION_KEY` com um valor seguro
2. O Railway reiniciará automaticamente o serviço

### n8n iniciou mas não aparece nada

**Causa:** Pode estar esperando o PostgreSQL inicializar

**Solução:**
1. Aguarde 1-2 minutos
2. Verifique os logs do n8n
3. Procure por "Editor is now accessible via"
4. Se não aparecer, reinicie o serviço n8n

### Perdi minha N8N_ENCRYPTION_KEY

**Situação:** Não há recuperação das credenciais antigas

**Solução:**
1. Gere uma nova `N8N_ENCRYPTION_KEY`
2. Atualize a variável no Railway
3. Você precisará reconfigurar todas as credenciais manualmente no n8n
4. Seus workflows serão preservados, mas sem as credenciais

### Erro ao fazer build

**Causa:** Problema com o Dockerfile ou imagem do n8n

**Solução:**
1. Verifique os logs de build no Railway
2. Confirme que o Dockerfile está correto
3. Tente fazer um novo deploy

## 📈 Próximos Passos

Após configurar com sucesso:

1. **Backup Regular**: Configure backups do PostgreSQL no Railway
2. **Monitoramento**: Configure alertas no Railway para downtime
3. **Escalabilidade**: Monitore o uso de recursos e ajuste conforme necessário
4. **Segurança**: 
   - Use autenticação básica ou OAuth
   - Mantenha a `N8N_ENCRYPTION_KEY` segura
   - Atualize o n8n regularmente

## 🔗 Links Úteis

- [Documentação do n8n](https://docs.n8n.io/)
- [Documentação do Railway](https://docs.railway.app/)
- [n8n Community Forum](https://community.n8n.io/)
- [Railway Discord](https://discord.gg/railway)

## 📝 Resumo de Variáveis

| Variável | Obrigatória | Descrição |
|----------|-------------|-----------|
| `N8N_ENCRYPTION_KEY` | ✅ Sim | Chave para criptografar credenciais |
| `WEBHOOK_URL` | ⚠️ Recomendada | URL do seu app Railway |
| `N8N_BASIC_AUTH_ACTIVE` | ❌ Opcional | Ativar autenticação básica |
| `N8N_BASIC_AUTH_USER` | ❌ Opcional | Usuário para login |
| `N8N_BASIC_AUTH_PASSWORD` | ❌ Opcional | Senha para login |
| `PGHOST` | ✅ Automática | Host do PostgreSQL (Railway) |
| `PGPORT` | ✅ Automática | Porta do PostgreSQL (Railway) |
| `PGUSER` | ✅ Automática | Usuário do PostgreSQL (Railway) |
| `PGPASSWORD` | ✅ Automática | Senha do PostgreSQL (Railway) |
| `PGDATABASE` | ✅ Automática | Nome do banco (Railway) |
