#!/bin/bash

echo Hello! Nice to meet you!

while getopts ":n:d:P:u:p:s:k:" opt; do
  case "${opt}" in
    n ) project_name="${OPTARG}";;
    d ) db_name="${OPTARG}";;
    P ) db_port="${OPTARG}";;
    u ) db_user="${OPTARG}";;
    p ) db_password="${OPTARG}";;
    s ) db_server="${OPTARG}";;
    k ) secret_key="${OPTARG}";;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      ;;
      
  esac
done
shift $((OPTIND -1))
echo "Project name is ${project_name}"
echo "Database name is ${db_name}"
echo "Database server is ${db_server}"
echo "Database port is ${db_port}"
echo "Database user is ${db_user}"
echo "Database password is ${db_password}"
echo "Secret key is ${secret_key}"
sed -i "s&POSTGRES_USER.*&POSTGRES_USER=$db_user&g" backend/.env.template
sed -i "s&POSTGRES_PORT.*&POSTGRES_PORT=5432&g" backend/.env.template
sed -i "s&POSTGRES_SERVER.*&POSTGRES_SERVER=$db_server&g" backend/.env.template
sed -i "s&POSTGRES_PASSWORD.*&POSTGRES_PASSWORD=$db_password&g" backend/.env.template
sed -i "s&POSTGRES_DB.*&POSTGRES_DB=$db_name&g" backend/.env.template
sed -i "s&SECRET_KEY.*&SECRET_KEY=$secret_key&g" backend/.env.template

mv backend/.env.template backend/.env

sed -i "s&db_port:5432&$db_port:5432&g" docker-compose.yml
sed -i "s&db_server&$db_server&g" docker-compose.yml
sed -i "s&- db_server&- $db_server&g" docker-compose.yml


mv ../fast_api_default_project ../$project_name

grep -rli 'fast_api_default_project' * | xargs -i@ sed -i "s/fast_api_default_project/$project_name/g" @

grep -rli 'react_default_app' * | xargs -i@ sed -i "s/react_default_app/$project_name/g" @


cd frontend
npm install

cd ../ && python3.10 -m venv backend/venv
source backend/venv/bin/activate
pip install --upgrade pip
pip install -r backend/requirements.txt

echo Run containers

docker-compose -f docker-compose.dev.yml up --build -d

docker exec -i "${project_name}_backend_1" bash -c "alembic revision -m 'init_revision'"

migrations_path=backend/app/db/migrations
suffix=_init_revision.py

file_name=$(find ${migrations_path}/versions/ -type f -name "*${suffix}")

revision_id="${file_name#${migrations_path}/versions/}"
revision_id="${revision_id%_init*}"

echo "Revision id is ${revision_id}"

sed -i "s/revision_id/${revision_id}/g" "${migrations_path}/migrations_template.py"

rm -f "${file_name}"

mv "${migrations_path}/migrations_template.py" "${migrations_path}/versions/${revision_id}${suffix}"

docker exec -i "${project_name}_backend_1" bash -c "alembic upgrade head"

echo Done!