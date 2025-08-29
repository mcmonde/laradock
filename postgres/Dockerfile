ARG POSTGRES_VERSION=alpine
FROM postgres:${POSTGRES_VERSION}

##just uncomment this if you want to enable postgis
#RUN apt-get update && \
#    apt-get install -y postgis postgresql-15-postgis-3 && \
#    rm -rf /var/lib/apt/lists/* \

CMD ["postgres"]

EXPOSE 5432
