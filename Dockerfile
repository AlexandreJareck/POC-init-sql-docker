# Imagem oficial do SQL Server como base
FROM mcr.microsoft.com/mssql/server:2019-latest

# Define usuario
USER root
# Define os argumentos e forneçe valores padrão.
ARG USERNAME=usuario-default
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Use os argumentos para configurar um susário não root.
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID --create-home --shell /bin/bash $USERNAME \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME

USER usuario-default

# Define varoáveis de ambiente necessária para configurar o SQL Server
# Aceite a EULA, defina a senha do SA e defina o tipo de edição do SQL Server
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=YourStrong!Passw0rd
ENV MSSQL_PID=Express

# Copia o script SQL que você deseja executar após a criação do contêiner para o filesystem do contêiner
COPY setup.sql /docker-entrypoint-initdb.d/

# Copia o script shell para executar o script SQL

# Copia o script shell para executar o script SQL
COPY --chmod=755 entrypoint.sh /usr/src/app/entrypoint.sh
ENTRYPOINT ["bash", "/usr/src/app/entrypoint.sh"]

# Define o comando padrão a ser executado pelo contêiner (neste caso, iinicia o SQL Server
CMD ["/opt/mssql/bin/sqlservr"]
