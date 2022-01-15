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

    print("got database")
    if 'results' in query and query['results']:
        for page in query['results']:
            update_page.delay(page)

@app.task#(queue='updater')
def update_page(page):
    print("Updater task called!")
    page = JournalUpdater(page) # one can add other pages here and in beat scheduler
    page.update()