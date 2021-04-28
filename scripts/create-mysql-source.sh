#!/bin/sh

curl -X "POST" "http://localhost:28083/connectors" \
		-H "Content-Type: application/json" \
		-d @"mysql-source.json"