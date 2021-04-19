FROM python:3.8-slim-buster

RUN adduser miniblog

WORKDIR /home/miniblog

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip install gunicorn

COPY app app
COPY migrations migrations
COPY miniblog.py config.py boot.sh ./
RUN chmod +x boot.sh

ENV FLASK_APP miniblog.py

RUN chown -R miniblog:miniblog ./
USER miniblog

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]



