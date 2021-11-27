Using setup_project.sh: ./setup_project.sh -n <project_name> -d <db_name> -P <db_port> -u <db_user> -p <db_password> -s <db_server> -k <secret_key>

access to postgres cli: 
"docker-compose exec <db_container_name> psql -h <db_host> -U <db_user> --dbname=<db_name>"