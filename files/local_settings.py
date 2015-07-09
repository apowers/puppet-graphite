# Edit this file to override the default graphite settings, do not edit settings.py

# Turn on debugging and restart apache if you ever see an "Internal Server Error" page
#DEBUG = True

# Set your local timezone (django will try to figure this out automatically)
TIME_ZONE = 'UTC'

## ----
# Customized from CentOS Defaults
##
# Root directory for storage, etc.
GRAPHITE_ROOT = '/opt/graphite'
STORAGE_DIR = '/opt/graphite/storage'
CONF_DIR = '/etc/graphite-web'
CONTENT_DIR = '/usr/share/graphite/webapp/content'

## Data directories
# NOTE: If any directory is unreadable in DATA_DIRS it will break metric browsing
WHISPER_DIR = '/opt/graphite/storage/whisper'
RRD_DIR = '/opt/graphite/storage/rrd'
INDEX_FILE = '/opt/graphite/storage/index'  # Search index file
DATA_DIRS = [WHISPER_DIR, RRD_DIR] # Default: set from the above variables
LOG_DIR = '/var/log/graphite-web/'
## ----

# Local Database
DATABASES = {
    'default': {
        'NAME': '/opt/graphite/storage/graphite.db',
        'ENGINE': 'django.db.backends.sqlite3',
        'USER': '',
        'PASSWORD': '',
        'HOST': '',
        'PORT': ''
    }
}

