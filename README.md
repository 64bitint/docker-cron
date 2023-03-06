# docker-cron
Schedule docker commands in docker using cron.

## Usage

```sh
docker run -d \
    -e TZ="America/Vancouver" \
    -e HOURLY="echo 'runs every hour'" \
    -e DAILY="echo 'runs every day'" \
    -e WEEKLY="echo 'runs every week'" \
    -e MONTHLY="echo 'runs every month'" \
    -e T0645="echo \"It is 6:45 AM in $TZ\"" \
    -e T1620="echo \"It is 4:20 PM in $TZ\"" \
    --restart=always \
    --name=docker-cron \
    64bitint/cron
```

### Environment Variables

**TZ** [Timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List) to use when setting cron times

**HOURLY** Command to run every hour

**DAILY** Command to run every day

**WEEKLY** Command to run every week

**MONTHLY** Command to run every month

**THHMM** Command to run daily at time where **HH** is the hour between 00 to 23 and **MM** is the minutes between 00 and 55 in 5 minute incrementes. Example: **T2005** is the command to run at 8:05 PM

**CRON_HOURLY** Time to run the hourly command in crontab format (Default: ```17 *    * * *```)

**CRON_DAILY** Time to run the daily command in crontab format (Default: ```25 6    * * *```)

**CRON_WEEKLY** Time to run the weekly command in crontab format (Default: ```47 6    * * 0```)

**CRON_MONTHLY** Time to run the mothly command in crontab format (Default: ```52 6    1 * *```)

The environment variable ```CRON_NAME``` specifies the time in [crontab format](https://crontab.guru) to run the command in the ```NAME``` environment variable.

When the docker image starts it creates a cron tab by combining the ```CRON_NAME``` and ```NAME``` environment variables. Use any valid environment variable name instead of ```NAME```.

### Docker

To run docker commands map the docker socket to the docker container using ```-v /var/run/docker.sock:/var/run/docker.sock```

For exampe to prune docker images on the host every day at 1:15 AM.

```sh
docker run -d -e T0115="docker image prune -f" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --name image-prune \
    64bitint/cron
```

