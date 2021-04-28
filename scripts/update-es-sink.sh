#!/bin/sh

curl -X PUT "http://localhost:28084/connectors/quickstart-elasticsearch-source/config" \
		-H "Content-Type: application/json" \
		-d '{ 
          "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",
          "connection.url":"http://elasticsearch:9200",
          "tasks.max": 1,
          "topics": "quickstart-mysql-topic",
          "poll.interval.ms": 1000
				}' 