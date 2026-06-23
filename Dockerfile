# Используем официальный образ SQL Server Express
FROM mcr.microsoft.com/mssql/server:2022-latest AS sql

# Переменные для SQL Server (пароль должен быть сложным!)
ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD=YourStrong!Passw0rd
ENV MSSQL_PID=Express

# Создаём папку для приложения
WORKDIR /app

# Копируем ваш исполняемый файл (или исходники)
# Сначала скопируйте ваш скомпилированный бинарник (например, app)
COPY app /app/app

# Создаём скрипт для запуска SQL Server и приложения
RUN echo '#!/bin/bash\n\
/opt/mssql/bin/sqlservr & \n\
sleep 30 \n\
/app/app' > /app/start.sh && chmod +x /app/start.sh

# Открываем порты для SQL Server и приложения
EXPOSE 1433
EXPOSE 10000

# Запускаем скрипт
CMD ["/app/start.sh"]