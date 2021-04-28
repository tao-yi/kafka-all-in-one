## Start

```shell
$ docker-compose up -d
```

- kibana: `localhost:5601`
- mysql: `localhost:3306`
- elasticsearch: `localhost:9200`
- zookeeper: `localhost:2181`
- kafdrop: `localhost:9000`
- mysql-connector: `localhost:28083`
- elasticsearch-connector: `localhost:28084`

### Kafka Connect REST interface

```shell
# get a list of active connectors
$ curl -X GET localhost:28083/connectors

# update connector configs
$ curl -X PUT /connectors/(string:name)/config -d '{"config": {"topics":"quickstart-mysql-topic"} }'
```
