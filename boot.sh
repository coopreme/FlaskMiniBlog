#!/bin/bash
. venv/bin/activate
while true; do
    flask db upgrade
    if [[ "$?" == "0" ]]; then
        break
    fi
    echo Upgrade command failed, retrying in 4 secs...
    sleep 4
done
flask translate compile
exec gunicorn -b :5000 --access-logfile - --error-logfile - miniblog:app