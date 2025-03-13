FROM python:3.8

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY . /app

RUN chmod +x run_app.sh

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install -r requirements.txt

CMD /app/run_app.sh

