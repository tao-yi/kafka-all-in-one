#!/bin/sh
curl -s -X GET http://localhost:28083/connectors/quickstart-jdbc-source/status

curl -s -X GET http://localhost:28084/connectors/quickstart-elasticsearch-source/status