#!/bin/sh

curl -X PUT "http://localhost:28084/connectors/quickstart-elasticsearch-sink/config" \
		-H "Content-Type: application/json" \
		-d @"es-connect-config.json"

curl -X PUT "http://localhost:28083/connectors/quickstart-mysql-source/config" \
		-H "Content-Type: application/json" \
		-d @"mysql-connect-config.json"