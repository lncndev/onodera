FROM crystallang/crystal:1.1.1-alpine

RUN apk add redis

WORKDIR /app
RUN git clone https://github.com/onoderaproject/onodera .

RUN shards install
RUN crystal build src/onodera.cr

ENTRYPOINT entrypoint.sh