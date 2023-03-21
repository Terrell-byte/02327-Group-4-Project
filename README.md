# 02327-Group-4-Project
Add description here!

## Getting Started
To get started using this application, you will need to have java and Docker installed on your machine.

1. Clone the repository
```
git clone https://github.com/Terrell-byte/02327-Group-4-Project.git
```

2. Start the database using Docker
```
cd docker
docker-compose build
docker-compose up
```

# Adding new scripts to INIT

1. Create a new sql file in the same directory as Dockerfile and docker-compose.yml:
To ensure that your file is executed in the correct order, it's important that the file number matches the desired execution order. By following this simple guideline, you can avoid any potential errors or confusion that may arise from files being executed in the wrong order. So, be sure to check that your file numbers are in sync with your desired execution order before proceeding.

Example of file name:
```
01-createTable.sql
```

2. Make sure to add the file to the Dockerfile:
Adding the file to the Dockerfile is crucial to ensure that it's executed when the container starts. To achieve this, you need to include the file in the Dockerfile volumes section and end the line with '/docker-entrypoint-initdb.d/'. This copies the file to the /docker-entrypoint-initdb.d/ directory which docker uses as it starting point when starting. e.i everything in this directory gets run when the container starts.

here is an example:

```
# Copy SQL scripts
COPY 01-createTable.sql /docker-entrypoint-initdb.d/
```
