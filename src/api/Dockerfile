FROM python:3.12-slim

WORKDIR /app
ENV PYTHONUNBUFFERED=1

COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt gunicorn

COPY api.py .

EXPOSE 8080
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "api:app"]
