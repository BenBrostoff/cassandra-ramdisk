Inspired [by this great article on Planet Cassandra](http://www.planetcassandra.org/blog/reduce-integration-test-time-by-94-by-using-ramdisk/). The authors report a 94% reduction in test time; I saw the same (actually greater) results when using ramdisk.

Example with docker-compose:

Setup:
```
cassandra-ramdisk:
  # Needs to be run in priviliged
  # mode to mount ramdisk
  privileged: true
  image: benbrostoff/cassandra-ramdisk
  # you can pass in a ramdisk size in MBs
  environment:
    - RAMDISK_SIZE=2000
  ports:
    - "9160"
    - "9042"
    - "7199"
```

Usage:
```
docker-compose up -d cassandra-ramdisk; sleep 10
docker-compose run --rm cassandra-ramdisk cqlsh cassandra-ramdisk

Connected to Test Cluster at cassandra-ramdisk:9042.
[cqlsh 5.0.1 | Cassandra 3.3 | CQL spec 3.4.0 | Native protocol v4]
Use HELP for help.
cqlsh>
``` 