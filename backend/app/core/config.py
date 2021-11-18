from databases import DatabaseURL
from starlette.config import Config
from starlette.datastructures import Secret


config = Config(".env")
PROJECT_NAME = "fast_api_default_project"
VERSION = "1.0.0"
API_PREFIX = "/api"
SECRET_KEY = config("SECRET_KEY", cast=Secret, default="DEFAULT_SECRET_KEY")
MAIN_DB_USER = config("MAIN_DB_USER", cast=str)
MAIN_DB_PASSWORD = config("MAIN_DB_PASSWORD", cast=Secret)
MAIN_DB_SERVER = config("MAIN_DB_SERVER", cast=str, default="db")
MAIN_DB_PORT = config("MAIN_DB_PORT", cast=str, default="5432")
MAIN_DB_NAME = config("MAIN_DB_NAME", cast=str)
DATABASE_URL = config(
  "DATABASE_URL",
  cast=DatabaseURL,
  default=f"postgresql://{MAIN_DB_USER}:{MAIN_DB_PASSWORD}@{MAIN_DB_SERVER}:{MAIN_DB_PORT}/{MAIN_DB_NAME}"
)
