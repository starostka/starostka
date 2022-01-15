import os
from notion_client import Client

class BaseUpdater():

    def __init__(self, page) -> None:
        self.page = page
    
    def update(self):
        raise NotImplementedError()

    def _retrieve(self):
        raise NotImplementedError()

class JournalUpdater(BaseUpdater):

    def __init__(self, page) -> None:
        super().__init__(page)
    
    def update(self):
        notion = Client(auth=os.environ["NOTION_API_TOKEN"])
        retrieved = self._retrieve()


        properties = {}

        properties['Name'] = {'title': retrieved['name']}
        properties['Feelings'] = { "multi_select": retrieved['feelings'] }

        notion.pages.update(
            **{
                'page_id': self.page['id'],
                'properties': properties,
                # 'cover': None
            }
        )

    def _retrieve(self):
        return {
            'name': self._get_name(),
            'feelings': self._get_feelings()
        }

    def _get_feelings(self):
        return [
            {'name': 'happy'},
            {'name': 'hopeful'},
            {'name': 'excited'}
        ]

    def _get_name(self):
            return [
                {
                    "type": "text",
                    "text": {
                        "content": 'Test title'
                    }
                }
            ]