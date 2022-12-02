ARG alpine_version=3.17.0

FROM alpine:${alpine_version}
RUN apk update && apk add --no-cache docker-cli bash tzdata
ENV TZ=America/Toronto


                # .---------------- minute (0 - 59)
                # |  .------------- hour (0 - 23)
                # |  |  .---------- day of month (1 - 31)
                # |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
                # |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
                # |  |  |  |  |
                # *  *  *  *  * 

ENV  CRON_HOURLY="17 *    * * *"
ENV   CRON_DAILY="25 6    * * *"
ENV  CRON_WEEKLY="47 6    * * 7"
ENV CRON_MONTHLY="52 6    1 * *"

ENV CRON_T0000="0 0 * * *"
ENV CRON_T0100="0 1 * * *"

COPY entry.sh .

ENTRYPOINT ["/entry.sh"]
