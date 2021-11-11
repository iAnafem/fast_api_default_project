from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware
from app.core import config, tasks
from app.api.routes import router as api_router


def get_application():
    application = FastAPI(title="project_name", version="1.0.0")

    application.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    application.add_event_handler("startup", tasks.create_start_app_handler(application))
    application.add_event_handler("shutdown", tasks.create_stop_app_handler(application))

    application.include_router(api_router, prefix="/api")

    return application


app = get_application()
