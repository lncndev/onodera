git pull
shards install
crystal build src/onodera.cr
redis-server --daemonize yes
./onodera