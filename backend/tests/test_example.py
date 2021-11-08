import pytest
from httpx import AsyncClient
from fastapi import FastAPI


pytestmark = pytest.mark.asyncio


def test_example(app: FastAPI, client: AsyncClient) -> None:
    assert True


class TestExample:
    async def test_example(self, app: FastAPI, client: AsyncClient) -> None:
        assert True

