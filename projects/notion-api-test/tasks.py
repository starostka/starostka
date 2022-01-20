from main import app
from updaters import JournalUpdater
from notion_client import Client

import os

@app.task#(queue='checker')
def check_task(database_id):
    notion = Client(auth=os.environ["NOTION_API_TOKEN"])
    
    query = notion.databases.query(
        **{
            "database_id": database_id,
            "filter": {
                "and": [
                    {
                        "property": "Name",
                        "text": {
                            "starts_with": "{{"
                        }
                    },
                    {
                        "property": "Name",
                        "text": {
                            "ends_with": "}}"
                        }
                    }
                ]
            }
        }
    )
    if 'results' in query and query['results']:
        for page in query['results']:
            update_page.delay(page)

@app.task
def guitar_day(database_id):
    # run this task each day and add a new page with guitar practice content such as suggested songs, scales, chords, riffs, techniques etc.
    notion = Client(auth=os.environ["NOTION_API_TOKEN"])

    # query database to ensure it's available
    query = notion.databases.query(
        **{
            'database_id': database_id,
            'filter': {

            }
        }
    )

    # create new page with guitar practice content

    page = query['result']

    # spawn new page ready for user to engage in
    update_page.delay(page)

@app.task#(queue='updater')
def update_page(page):
    print("Updater task called!")
    page = JournalUpdater(page) # one can add other pages here and in beat scheduler
    page.update()