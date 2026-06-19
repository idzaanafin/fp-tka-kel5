FROM python:3.12-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY requirements.txt .

RUN pip install \
--no-cache-dir \
-r requirements.txt \
gunicorn

COPY . .

EXPOSE 5001

CMD ["gunicorn", "-w", "4", "-k", "gthread", "--threads", "8", "-b", "0.0.0.0:5001", "app:app"]