#!/bin/bash

echo "dump useful information"
ps -ax
echo "gdp -pid [PID OF PYTHON]" 

# gcore [PROC ID]
# strings core.1 | grep -B 3 -A 3 fake


echo "Trying it the internets way..."

grep rw-p /proc/$1/maps \
| sed -n 's/^\([0-9a-f]*\)-\([0-9a-f]*\) .*$/\1 \2/p' \
| while read start stop; do \
    gdb --batch --pid $1 -ex \
        "dump memory $1-$start-$stop.dump 0x$start 0x$stop"; \
done