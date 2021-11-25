#!/bin/bash

echo Hello, Bastard!

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
echo "Secret key is is ${secret_key}"
sed -i "s&MAIN_DB_USER.*&MAIN_DB_USER=$db_user&g" backend/.env.template
sed -i "s&MAIN_DB_PORT.*&MAIN_DB_PORT=$db_port&g" backend/.env.template
sed -i "s&MAIN_DB_SERVER.*&MAIN_DB_SERVER=$db_server&g" backend/.env.template
sed -i "s&MAIN_DB_PASSWORD.*&MAIN_DB_PASSWORD=$db_password&g" backend/.env.template
sed -i "s&MAIN_DB_NAME.*&MAIN_DB_NAME=$db_name&g" backend/.env.template
sed -i "s&SECRET_KEY.*&SECRET_KEY=$secret_key&g" backend/.env.template

rm backend/.env.template backend/.env

mv ../fast_api_default_project ../$project_name

sed -i "s&fast_api_default_project&$project_name&g" *

sed -i "s&react_default_app&$project_name&g" *

