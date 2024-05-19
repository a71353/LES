

import os
import sys
import site
from django.core.wsgi import get_wsgi_application

# Add the site-packages of the chosen virtualenv to work with
site.addsitedir('C:/Users/tomas/OneDrive/Documentos/grupo13/env/Lib/site-packages')

# Add the app's directory to the PYTHONPATH
sys.path.append('C:/inetpub/wwwroot/DAUALG/grupo1_6')
sys.path.append('C:/inetpub/wwwroot/DAUALG/grupo13/dia_aberto')

os.environ['DJANGO_SETTINGS_MODULE'] = 'dia_aberto.settings'
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "dia_aberto.settings")

application = get_wsgi_application()
