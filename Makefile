.PHONY: create-jdbc-connector
create-jdbc-connector:
	curl -X POST \
		-H "Content-Type: application/json" \
		--data '{ "name": "quickstart-jdbc-source", "config": { "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector", "tasks.max": 1, "connection.url": "jdbc:mysql://mysql:3306/connect_test", "connection.user": "root", "connection.password": "test", "mode": "incrementing", "incrementing.column.name": "id", "timestamp.column.name": "modified", "topics": "quickstart-mysql-topic", "poll.interval.ms": 1000 } }' \
		http://localhost:28083/connectors

.PHONY: create-elasticsearch-connector
create-elasticsearch-connector:
	curl -X POST \
		-H "Content-Type: application/json" \
		--data '{ "name": "quickstart-elasticsearch-source", "config": { "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector", "tasks.max": 1,  "topics": "quickstart-elasticsearch-topic", "poll.interval.ms": 1000 } }' \
		http://localhost:28084/connectors

.PHONY: check-mysql-status
check-mysql-status:
	curl -s -X GET http://localhost:28083/connectors/quickstart-jdbc-source/status

.PHONY: check-es-status
check-es-status:
	curl -s -X GET http://localhost:28084/connectors/quickstart-elasticsearch-source/status
