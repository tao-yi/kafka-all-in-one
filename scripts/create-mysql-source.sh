#!/bin/sh

curl -X "POST" "http://localhost:28083/connectors" \
		-H "Content-Type: application/json" \
		-d '{ 
          "name": "quickstart-jdbc-source",  
          "config": {
            "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector", 	
            "tasks.max": 1, 
            "connection.url": "jdbc:mysql://mysql:3306/connect_test", 
            "connection.user": "root", 
            "connection.password": "test", 
            "mode": "incrementing", 
            "incrementing.column.name": "id", 
            "timestamp.column.name": "modified", 
            "topics": "quickstart-mysql-topic", 
            "poll.interval.ms": 1000
          }
				}' 