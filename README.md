# SCM Backup Docker

This project sets up SCM backup in a Docker container using Docker Compose.

## Setup

1. Clone the repository and navigate to the project folder.
2. Create a `.env` file with your environment variables:
   TITLE1=title1
   TEAM1=team1
   TITLE2=title2
   TEAM2=team2
   BB_USER=your_bitbucket_username
   BB_PASSWORD=your_bitbucket_password
   LOCAL_BACKUP_DIRECTORY=/path/to/local/backup

3. Run Docker Compose:
   docker-compose up --build

## Volumes

Backups are stored in `${LOCAL_BACKUP_DIRECTORY}:/opt/scm-backup/backup`.
