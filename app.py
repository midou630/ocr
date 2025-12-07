import os
from flask import Flask, render_template, request, send_file
from PIL import Image
import pytesseract
from fpdf import FPDF

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/process", methods=["POST"])
def process():
    img = request.files["image"]
    image_path = "captured.jpg"
    img.save(image_path)

    # OCR استخراج النص
    text = pytesseract.image_to_string(Image.open(image_path), lang="ara+eng")

    # إنشاء PDF
    pdf = FPDF()
    pdf.add_page()
    pdf.set_auto_page_break(auto=True, margin=10)
    pdf.set_font("Arial", size=12)

    for line in text.split("\n"):
        pdf.multi_cell(0, 10, txt=line)

    output_path = "output.pdf"
    pdf.output(output_path)

    return send_file(output_path, as_attachment=True, download_name="document.pdf")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
