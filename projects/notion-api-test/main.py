from celery import Celery
from dotenv import load_dotenv
import os

# load local .env file
load_dotenv()

app = Celery('notion', 
    broker=os.getenv('CELERY_BROKER'),
    include=['tasks']
)

# cron jobs
app.conf.beat_schedule = {
    'check-journal-database-every-second': {
        'task': 'tasks.check_task',
        'schedule': 3.0,
        'args': ("18cd181265844b618c518a8cd5291d77",) # find id using share option in Notion 
    }
}

app.conf.timezone = 'UTC'