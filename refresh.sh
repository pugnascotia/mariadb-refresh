#!/bin/bash

set -eo pipefail

iso8601() {
  # GNU date supports --iso-date=... but BSD doesn't
  date -u '+%Y-%m-%dT%H:%M:%SZ'
}

dump_database_to() {
  local dump_name="$1"
  TIMEFORMAT="Dump of $FROM_DB on $FROM_HOST took %lR"
  time mysqldump --opt --hex-blob \
    --host="$FROM_HOST" --port="${FROM:-3306}" \
    --user="$FROM_USER" --password="$FROM_PASSWORD" \
    "$FROM_DB" \
    > "$dump_name"
}

restore_database_from() {
  local dump_name="$1"
  TIMEFORMAT="Restore into $TO_DB on $TO_HOST took %lR"
  time mysql -B \
    --host="$TO_HOST" --port="${TO:-3306}" \
    --user="$TO_USER" --password="$TO_PASSWORD" \
    "$TO_DB" \
    < "$dump_name"
}

main() {
  local dump_name=mysqldump_$(iso8601)

  dump_database_to "$dump_name"

  restore_database_from "$dump_name"
}

main "$@"
