#!/bin/bash

# add CRON_T0000 to CRON_T2355 daily times
for hr in {00..23} 
do
    for mn in {00..59..5}
    do
        export CRON_T$hr$mn="$mn $hr    * * *"
    done
done


# clear existing crontabs
echo "" > /etc/crontabs/root

# Read cron periods defined in env vars starting with CRON_
# ex CRON_T7AM="0 7 * * *"
env | grep ^CRON_ | while read line
do
    name=${line%=*}
    name=${name#CRON_}
    period=${line#*=}
    env | grep "^$name" | \
        sed -E "s/^${name}_?([^=]*)=/# $name \1\n$period /" >> /etc/crontabs/root
done

echo "Created crontabs:"
cat /etc/crontabs/root
echo ---
echo "Starting crond ..."
crond -f -d 8
