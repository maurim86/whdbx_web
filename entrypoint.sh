#!/bin/sh

cd /app
if [ ! -d _caches ]; then mkdir _caches; fi
if [ ! -d _caches/templates ]; then mkdir _caches/templates; fi
if [ ! -d _caches/prices ]; then mkdir _caches/prices; fi
if [ ! -d _caches/zkb ]; then mkdir _caches/zkb; fi

cd db
if [ ! -f eve.db ]; then
  if [ ! -f eve.db.bz2]; then
    wget https://www.fuzzwork.co.uk/dump/latest/eve.db.bz2
  fi
  
  if [ -f eve.db.bz2 ]; then
    bzip2 --decompress eve.db.bz2

    cd ../
    cd sqlite_sql
    ./update_database.sh
  fi
fi

cd ../

python3 ./main.py --host=0.0.0.0 --port=80
