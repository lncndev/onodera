FROM archlinux

RUN pacman -Syu --noconfirm redis crystal shards

WORKDIR /app
COPY . .

RUN shards install
RUN crystal build src/onodera.cr

WORKDIR /
ENTRYPOINT /app/onodera