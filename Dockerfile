FROM python:3.10-slim

WORKDIR /app

# Устанавливаем необходимые системные зависимости
RUN apt-get update && apt-get install -y gcc libpq-dev

# Копируем файл зависимостей и устанавливаем их
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Копируем файл .env и все остальные файлы проекта
COPY .env .
COPY . .

# Копируем скрипт wait-for-it.sh и делаем его исполняемым
COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

# Запускаем приложение с ожиданием доступности БД,
# подставляя переменные окружения из .env
CMD /wait-for-it.sh ${DB_HOST}:${DB_PORT} -- uvicorn main:app --host 0.0.0.0 --port 8000 --reload
