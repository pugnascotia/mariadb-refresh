FROM mariadb

MAINTAINER Rory Hunter <roryhunter2@gmail.com>

ADD mantra /usr/local/bin
ADD refresh.sh /

ENV REFRESH_SCHEDULE="0 * * * * *"

CMD mantra "$REFRESH_SCHEDULE" /refresh.sh
