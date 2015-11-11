#!/bin/bash

set -eu

cd "$(dirname $0)"
SCRIPT_PATH="$(pwd)"

export PGDATA="$SCRIPT_PATH/data"
export PGPORT="19898"

rm -r "$PGDATA"
pg_ctl init
pg_ctl start -w
trap 'pg_ctl stop -w' EXIT
createdb

echo "create table test (id serial primary key, timestamp int not null, date_string varchar(255) not null);" | psql

TIMESTAMP="$(date +%s)"
DATE_STRING="$(date)"
TEST_SQL="
insert into test (timestamp, date_string) values 
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'),
('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING'), ('$TIMESTAMP','$DATE_STRING');
update test set date_string='$DATE_STRING updated';
delete from test;
"

for x in {0..400}; do
	echo "$TEST_SQL" | psql
done

echo "checkpoint;" | psql

echo "$TEST_SQL" | psql