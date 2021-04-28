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

### Kafka Connect

Kafka Connect provides scalable and reliable way to move the data in and out of Kafka.

As it uses plugins for specific plugins for connectors and it is run by only configuration (without writing code) it is an easy integration point.

### Download Connector Library

Download the Kafka Connect JDBC plugin from Confluent hub and extract the zip file to the Kafka Connect's plugins path.

- `https://www.confluent.io/hub/confluentinc/kafka-connect-jdbc`


### Selecting Schema and Tables To Copy
We can use `catalog.pattern` or `schema.pattern` to filter the schemas to be copied.

By default, all tables are queried to be copied. However, we include or exclude the list of tables by `table.whitelist` and `table.blacklsit` configurations.

- `table.whitelist`: "Users,Address,City"
- `table.blacklist`: "Groups"

### Query modes

- `bulk`: connector will load all the selected tables in each iteration. If the iteration interval is set to some small number (5 seconds default) it wont make much sense to load all the data as there will be duplicate data. It can be useful if a periodical backup, or dumping the entire database.
- `incrementing`: uses a single column that is unique for each row, ideally auto incremented primary keys to detect the changes in the table. If new row with new ID is added it will be copied to Kafka. However this mode lacks the capability of catching update operation on the row as it will not change the ID. incrementing.column.name is used to configure the column name. 
  - `incrementing.column.name` is used to configure the column name.
- `timestamp`: Uses a single column that shows the last modification timestamp and in each iteration queries only for rows that have been modified since that time. As timestamp is not unique field, it can miss some updates which have the same timestamp. 
  - `timestamp.column.name` is used to configure the column name.    
- `timestamp+incrementing`: Most robust and accurate mode that uses both a unique incrementing ID and timestamp. Only drawback is that it is needed to add modification timestamp column on legacy tables.
- `query`: The connector supports using custom queries to fetch data in each iteration. It is not very flexible in terms of incremental changes. It can be useful to fetch only necessary columns from a very wide table, or to fetch a view containing multiple joined tables. If the query gets complex, the load and the performance impact on the database increases.

### Incremental Querying with Timestamp

Using only unique ID or timestamp has pitfalls as mentioned above. It is better approach to use them together.

```json
{
    "name": "jdbc_source_connector_postgresql_02",
    "config": {
        "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
        "connection.url": "jdbc:postgresql://localhost:5432/demo-db",
        "connection.user": "postgres",
        "connection.password": "root",
        "topic.prefix": "postgres-02-",
        "table.whitelist": "store,tag,category,address,city",
        "mode":"timestamp+incrementing",
        "timestamp.column.name": "last_modified_date",
        "validate.non.null": false,
        "db.timezone": "Europe/Warsaw"
    }
}
```
Note the `validate.non.null` is used because connector requires the timestamp column to be NOT NULL, we can either set these columns NOT NULL or we can disable this validation with setting validate.not.null false.

While using the timestamp column timezone of the database system matters. There might be different behaviour because of time mismatches so it can be configure by `db.timezone`.

It is mentioned above that using incrementing mode without timestamp causes not capturing the UPDATE operations on the table. With the timestamp+incrementing mode update operations are captured as well.

### Drawbacks of JDBC connector

1. It needs to constantly run queries, so it generates some load on the physical database. To not cause performance impacts, queries should be kept simple, and scalability should not be used heavily.
2. As the incremental timestamp is mostly needed, working on legacy datastore would need extra work to add columns. There can be also cases that it is not possible to update the schema.
3. JDBC Connector can not fetch DELETE operations as it uses SELECT queries to retrieve data and there is no sophisticated mechanism to detect the deleted rows. You can implement your solution to overcome this problem.

### Kafka Connect REST interface

```shell
# get a list of active connectors
$ curl -X GET localhost:28083/connectors

# get plugin list
$ curl -X GET localhost:28083/connector-plugins

# update connector configs
$ curl -X PUT /connectors/(string:name)/config -d '{"config": {"topics":"quickstart-mysql-topic"} }'
```


### Start the JDBC connector
```shell
$ curl -d @"jdbc-source.json" \
-H "Content-Type: application/json" \
-X POST http://localhost:8083/connectors
```
`jdbc-source.json`
```json
{
    "name": "jdbc_source_connector_postgresql_01",
    "config": {
        "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
        "connection.url": "jdbc:postgresql://localhost:5432/demo",
        "connection.user": "postgres",
        "connection.password": "root",
        // create kafka topic per table. Topics are named with the topic.prefix + <table_name>
        "topic.prefix": "postgres-01-",
        // data is retrieved from database with the interval specified by poll.interval.ms
        "poll.interval.ms" : 3600000,
        // Bulk mode is used to load all the data
        "mode":"bulk"
    }
}
```

By default all tables are queried to be copied.


---
## References
- https://turkogluc.com/kafka-connect-jdbc-source-connector/
- https://turkogluc.com/apache-kafka-basics/
- https://turkogluc.com/apache-kafka-connect-introduction/