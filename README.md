# RANDI

## How to get RANDI running under docker

### 1 Create the user network and a volume for the RANDI Database and RANDI Data

```
docker network create --driver bridge randi-net
docker volume create randi-db-data
docker volume create randi-data
```

### 2 Get Postgres running

We hook it up to the randi-db-data and the randi-net
Must be postgres 9.5
Make sure you change the password in this command.

```
docker run --name=randi-db -d -v randi-db-data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=MASTER_PG_PASSWORD_CHANGE_ME --network randi-net postgres:9.5
```

### 3 Create RANDI Database
Thid makes the database for RANDI and sets a password
Make sure you change the password in this command.

```
docker exec randi-db su postgres -c $'psql -c "CREATE ROLE randi LOGIN ENCRYPTED PASSWORD \'RANDI2_DB_PASSWORD_CHANGE_ME\' SUPERUSER NOINHERIT NOCREATEDB NOCREATEROLE" && psql -c "CREATE DATABASE randi WITH ENCODING=\'UTF8\' OWNER=randi" && echo "host all  randi    0.0.0.0/0  md5" >> $PGDATA/pg_hba.conf && /usr/lib/postgresql/$PG_MAJOR/bin/pg_ctl reload -D $PGDATA'
```

### 4 Get the RANDI docker

```
git clone https://github.com/mshunshin/randi-docker.git
```

### 5 Build the RANDI Container

```
docker build -t randi .
```

### 6 Run the RANDI Container

```
docker run --name=randi -d -v randi-data:/randi.data -p 82:8080 --network randi-net randi
```

### 7 Access RANDI

Goto http://ip_address:82/randi

### 8 Answer the questions to set up the server
The server address (which you enter on the 1st and 2nd page): randi-db
Database type: postgres (not mysql).
The database: randi
The user: randi
The pass: What you set it to.


Fill in junk for the mail server (unless you have one).
Make sure you set up a user (it lets you skip it, but I can't then see how to add one).




