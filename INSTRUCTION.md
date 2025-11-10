# Django Todolist – Docker Compose Instructions

This document explains how to run and stop the MySQL database and the Django Todolist application using `docker-compose`.

## 1. Prerequisites

- Docker and Docker Compose installed

## 2. Services

The `docker-compose.yml` file defines two services:

- **db** – MySQL 8.0 database  
  - database: `app_db`  
  - user: `app_user`  
  - password: `1234`  
  - persistent volume: `mysql_data:/var/lib/mysql`
- **web** – Django Todolist app  
  - built from the local `Dockerfile`  
  - runs `python manage.py migrate` and then `python manage.py runserver 0.0.0.0:8080`

The application connects to MySQL using the host `db` passed via the `DB_HOST` environment variable.

## 3. Start the application

From the project root (where `docker-compose.yml` is located):

```bash
docker-compose up --build

http://localhost:8000

docker-compose down

docker-compose down -v

