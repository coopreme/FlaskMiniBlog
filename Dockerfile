FROM python:3.8-slim-buster

# make a user and perform root actions
RUN useradd --create-home --shell /bin/bash miniblog
WORKDIR /home/miniblog
COPY --chown=miniblog:miniblog boot.sh boot.sh
COPY --chown=miniblog:miniblog requirements.txt requirements.txt
RUN chmod +x boot.sh

#RUN chown -R miniblog:miniblog ./
USER miniblog

# Bring over other stuff after CHOWNing
#COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install --default-timeout=100 -r requirements.txt --no-cache-dir
RUN venv/bin/pip install --default-timeout=100 gunicorn pymysql --no-cache-dir

# rest of dockerfile
COPY --chown=miniblog:miniblog app app
COPY --chown=miniblog:miniblog migrations migrations
COPY --chown=miniblog:miniblog miniblog.py config.py ./
ENV FLASK_APP miniblog.py

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]
