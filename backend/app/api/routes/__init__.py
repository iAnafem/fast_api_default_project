from fastapi import APIRouter, Depends
from app.db.repositories.base import BaseRepository
from app.api.dependencies.database import get_repository
from app.models.test_model import TestModel


router = APIRouter()


@router.get("/")
async def get_greeting_from_api() -> str:
    return "Hello, frontend! Nice to meet you!"


@router.get("/hello_db/")
async def get_greeting_from_db(
        base_repo: BaseRepository = Depends(get_repository(BaseRepository))
) -> str:
    test_model: TestModel = await base_repo.get_greeting_from_db()
    return test_model.msg
