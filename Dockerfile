FROM n8nio/n8n:2.1.1

# Configurações do n8n
ENV N8N_PROTOCOL=https
ENV WEBHOOK_URL=https://your-app-name.railway.app

# Configurações do PostgreSQL
# As variáveis DATABASE_URL, PGHOST, PGPORT, PGUSER, PGPASSWORD, PGDATABASE 
# serão injetadas automaticamente pelo Railway
ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_HOST=${PGHOST}
ENV DB_POSTGRESDB_PORT=${PGPORT}
ENV DB_POSTGRESDB_USER=${PGUSER}
ENV DB_POSTGRESDB_PASSWORD=${PGPASSWORD}
ENV DB_POSTGRESDB_DATABASE=${PGDATABASE}
ENV DB_POSTGRESDB_SCHEMA=public

# Chave de criptografia para proteger credenciais
# IMPORTANTE: Defina N8N_ENCRYPTION_KEY no Railway com um valor único e seguro
ENV N8N_ENCRYPTION_KEY=${N8N_ENCRYPTION_KEY}

EXPOSE 8080
