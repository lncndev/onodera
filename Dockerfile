FROM crystallang/crystal:1.1.1-alpine

RUN apk add redis

WORKDIR /app
COPY . .

RUN shards install
RUN crystal build src/onodera.cr

ENTRYPOINT ./entrypoint.sh