#!/bin/bash

# Start MySQL service
service mysql start

# Wait for MySQL to be fully ready
echo "Waiting for MySQL to be ready..."
until mysqladmin ping --silent; do
    sleep 2
done

# Initialize the database with init.sql
echo "Initializing database..."
mysql -u root -e "source /docker-entrypoint-initdb.d/init.sql"

# Start Flask application
echo "Starting Flask application..."
flask run --host=0.0.0.0 --port=5000