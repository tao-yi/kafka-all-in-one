.PHONY: create-jdbc-connector
create-jdbc-connector:
	curl -X POST \
		-H "Content-Type: application/json" \
		--data '{ "name": "quickstart-jdbc-source", "config": { "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector", "tasks.max": 1, "connection.url": "jdbc:mysql://mysql:3306/connect_test", "connection.user": "root", "connection.password": "test", "mode": "incrementing", "incrementing.column.name": "id", "timestamp.column.name": "modified", "topic.prefix": "quickstart-jdbc-", "poll.interval.ms": 1000 } }' \
		http://localhost:28083/connectors

.PHONY: check-status
check-status:
	curl -s -X GET http://localhost:28083/connectors/quickstart-jdbc-source/status
