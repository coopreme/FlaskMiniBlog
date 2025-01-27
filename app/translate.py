from app import current_app
import json
import requests
from flask_babel import _


def translate(text, source_language, dest_language):
    if 'TRANS_KEY' not in current_app.config or \
            not current_app.config['TRANS_KEY']:
        return _('Error: the translation service is not configured.')
    auth = {
        'Ocp-Apim-Subscription-Key': current_app.config['TRANS_KEY'],
        'Ocp-Apim-Subscription-Region': 'westus2'}
    r = requests.post(
        'https://api.cognitive.microsofttranslator.com'
        '/translate?api-version=3.0&from={}&to={}'.format(
            source_language, dest_language), headers=auth, json=[
                {'Text': text}])
    if r.status_code != 200:
        return _('Error: the translation service failed.')
    return r.json()[0]['translations'][0]['text']