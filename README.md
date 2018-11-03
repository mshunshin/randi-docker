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

```
docker run --name=randi-db -d -v randi-db-data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=MASTER_PG_PASSWORD_CHANGE_ME --network randi-net postgres:9.5
```

### 3 Create RANDI Database
Thid makes the database for RANDI and sets a password

```
docker exec randi-db su postgres -c $'psql -c "CREATE ROLE randi LOGIN ENCRYPTED PASSWORD \'RANDI2_DB_PASSWORD_CHANGE_ME\' SUPERUSER NOINHERIT NOCREATEDB NOCREATEROLE" && psql -c "CREATE DATABASE randi WITH ENCODING=\'UTF8\' OWNER=randi" && echo "host all  randi    0.0.0.0/0  md5" >> $PGDATA/pg_hba.conf && /usr/lib/postgresql/$PG_MAJOR/bin/pg_ctl reload -D $PGDATA'
```

### 4 Get the RANDI docker

```
git clone https://github.com/mshunshin/randi-docker.git
```

Then fix the env.list

```
#Tomcat
TOMCAT_PASS=TOMCAT_PASSWORD_CHANGE_ME
LOG_LEVEL=INFO
TZ=UTC-1
```

### 5 Build the RANDI Container

```
docker build -t randi .
```

### 6 Run the OpenClinica Container

```
docker run --name=randi -d -v randi-data:/tomcat/randi.data -p 82:8080 --env-file ./env.list --network randi-net randi
```

### 7 Access Openclinica

Goto http://ip_address:82/randi



