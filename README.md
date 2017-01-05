# mariadb-refresh

A tool for refreshing a MariaDB database on one host with the contents of
one on another host.

## Use Case

Say you have a production database and a test database, both running in
Docker. Periodically, you want to refresh your test database with the
contents of the production database. This tool makes that easy.

## Building

Simple:

    make

## Testing

Less simple. First make sure you have the latest image by following the
steps under 'Building', above. Then, under `test/`, use `docker-compose` to
start two databases:

    docker-compose up -d db1 db2

Wait a while for them both to come up. You can check progress with:

    docker-compose logs

Then start and monitor the refresh process with:

    docker-compose up refresh

Hit `Control-C` when you're done. Lather, rinse and repeat.

## Usage

Run the container with the environment variables below.

| Name               | Description                   | Default |
|--------------------|-------------------------------|---------|
| `FROM_HOST`        | Source database host          |         |
| `FROM_PORT`        | Source database port          | 3306    |
| `FROM_USER`        | Source database user          |         |
| `FROM_PASSWORD`    | Source database password      |         |
| `FROM_DB`          | Source database name          |         |
| `TO_HOST`          | Destination database host     |         |
| `TO_PORT`          | Destination database port     | 3306    |
| `TO_USER`          | Destination database user     |         |
| `TO_PASSWORD`      | Destination database password |         |
| `TO_DB`            | Destination database name     |         |
| `REFRESH_SCHEDULE` | The cron spec for regularly performing the dump.  Uses [mantra](https://github.com/pugnascotia/mantra) | `0 * * * * *` (every minute) |

## Example

Copy data between `dbhost1` and `dbhost2` at 1am every day.

    docker run mariadb-refresh \
        -e REFRESH_SCHEDULE="0 1 * * * *" \
        -e FROM_HOST=dbhost1 \
        -e FROM_PORT=3306 \
        -e FROM_USER=user1 \
        -e FROM_PASSWORD=password1 \
        -e FROM_DB=database1 \
        -e TO_HOST=dbhost2 \
        -e TO_PORT=3306 \
        -e TO_USER=user2 \
        -e TO_PASSWORD=password2 \
        -e TO_DB=database2
