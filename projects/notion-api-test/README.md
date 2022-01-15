**Start task worker**
celery -A main worker --loglevel=INFO

**Start beat scheduler**
celery -A main beat --loglevel=INFO

**Both worker and beat**
celery -A main worker --loglevel=INFO -B