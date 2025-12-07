# استخدم صورة بايثون رسمية خفيفة
FROM python:3.11-slim

# تثبيت Tesseract و اللغة العربية و الإنجليزية
RUN apt-get update && \
    apt-get install -y tesseract-ocr tesseract-ocr-eng tesseract-ocr-ara && \
    rm -rf /var/lib/apt/lists/*

# تحديد مجلد العمل
WORKDIR /app

# نسخ كل ملفات المشروع
COPY . /app

# تثبيت المكتبات المطلوبة
RUN pip install --no-cache-dir -r requirements.txt

# فتح المنفذ
EXPOSE 8080

# تشغيل التطبيق
CMD ["python", "app.py"]
