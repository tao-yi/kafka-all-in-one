#!/bin/sh

curl -X "POST" "http://localhost:28084/connectors" \
		-H "Content-Type: application/json" \
		-d '{ 
          "name": "quickstart-elasticsearch-source",  
          "config": {
            "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",
            "connection.url":"http://elasticsearch:9200",
						"tasks.max": 1,
            "topics": "quickstart-mysql-topic",
            "poll.interval.ms": 1000
						}
				}' 