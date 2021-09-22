FROM archlinux

RUN pacman -Syu redis crystal shards

WORKDIR /app
COPY . .

RUN crystal build src/onodera.cr

WORKDIR /
ENTRYPOINT /app/onodera