FROM python:3.10-slim
WORKDIR /home/mca043/Desktop/webapp-test/app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["python","app.py"]
