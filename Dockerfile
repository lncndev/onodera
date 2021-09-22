FROM archlinux

RUN pacman -Syu redis crystal shards

WORKDIR /app
COPY . .

RUN crystal build