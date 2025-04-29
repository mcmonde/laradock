FROM mcr.microsoft.com/mssql/server:2019-latest
#FROM mcr.microsoft.com/azure-sql-edge:latest

ENV MSSQL_PID=Express
ENV MSSQL_DATABASE=$MSSQL_DATABASE
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=$MSSQL_PASSWORD

VOLUME /var/opt/mssql

EXPOSE 1433
