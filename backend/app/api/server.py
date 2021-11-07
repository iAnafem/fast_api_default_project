from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware


def get_application():
    application = FastAPI(title="project_name", version="1.0.0")
    application.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )
    return application


app = get_application()
