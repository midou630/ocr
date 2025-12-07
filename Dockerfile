# استخدم صورة بايثون رسمية
FROM python:3.11-slim

# تثبيت Tesseract و اللغات
RUN apt-get update && \
    apt-get install -y tesseract-ocr tesseract-ocr-eng tesseract-ocr-ara && \
    rm -rf /var/lib/apt/lists/*

# مجلد العمل
WORKDIR /app

# نسخ ملفات المشروع أولاً (requirements.txt مهم أن يُنسخ قبل pip install)
COPY requirements.txt /app/

# تثبيت المكتبات
RUN pip install --no-cache-dir -r requirements.txt

# نسخ بقية ملفات المشروع
COPY . /app

# فتح المنفذ
EXPOSE 8080

# تشغيل التطبيق
CMD ["python", "app.py"]
