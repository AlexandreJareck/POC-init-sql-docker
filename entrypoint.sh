#!/bin/bash
# entrypoint.sh

# Aguarda o inicio do SQL Server e executa o script init.sql
# Loop até que o sqlservr esteka disponivel

set -e

# Inicia o SQL Serve em background
/opt/mssql/bin/sqlservr &

# Agurda a inicialização do SQL Server
until /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -d master -Q 'SELECT 1'; do
    echo "SQL Server ainda não está disponivel..."
    sleep 5
done

echo "SQL Server iniciado."

# Executa o script SQL
echo "Executando o script 'init.sql'..."
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -d master -i /docker-entrypoint-initdb.d/init.sql

echo "Script 'init.sql' executado com sucesso!!!"

# Mantém o processo em foreground para que o Docker possa gerencia-lo
wait