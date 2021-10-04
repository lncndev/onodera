git fetch
shards install
crystal build src/onodera.cr
redis-server --daemonize yes
./onodera