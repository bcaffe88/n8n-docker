FROM n8nio/n8n:latest

# Configurações do n8n
ENV N8N_PROTOCOL=https
ENV WEBHOOK_URL=https://your-app-name.railway.app
EXPOSE 8080
