# Moodle Docker

Custom Docker image for Moodle 4.1

## Requirements
- Docker Desktop (Windows / Linux / Mac)
- Git
- At least 2GB RAM

## How to run

### Step 1: Start database
```bash
docker run -d --name moodle_db -e MYSQL_ROOT_PASSWORD=rootpass -e MYSQL_DATABASE=moodle -e MYSQL_USER=moodle -e MYSQL_PASSWORD=moodlepass mariadb:10.6
