# 1. Usar uma imagem base oficial do Python.
# python:3.10-slim é uma boa escolha por ser leve e estar alinhada com o readme do projeto.
FROM python:3.13.4-alpine3.22

# 2. Definir o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 3. Copiar o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Se o código mudar, mas as dependências não, esta camada não será reconstruída.
COPY requirements.txt .

# 4. Instalar as dependências.
# --no-cache-dir desabilita o cache do pip para manter a imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar o restante do código da aplicação para o diretório de trabalho.
COPY . .

# 6. Expor a porta em que a aplicação será executada.
EXPOSE 8000

# 7. Definir o comando para iniciar a aplicação.
# --host 0.0.0.0 é essencial para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
