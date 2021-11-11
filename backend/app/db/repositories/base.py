from databases import Database
from app.models.test_model import TestModel

GET_GREETING_FROM_DB = """
    SELECT * FROM test_table;
"""


class BaseRepository:
    def __init__(self, db: Database) -> None:
        self.db = db

    async def get_greeting_from_db(self) -> TestModel:
        msg = await self.db.fetch_one(query=GET_GREETING_FROM_DB)
        return TestModel(**msg)
