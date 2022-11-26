FROM python:alpine3.7
COPY requirements.txt /
RUN pip3 install -r /requirements.txt
COPY app.py .
CMD ["gunicorn"  , "-b", "0.0.0.0:8888", "app:app"]