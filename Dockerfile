FROM python:3.9

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY filestore.py .

EXPOSE 5000

CMD ["python", "filestore.py"]
