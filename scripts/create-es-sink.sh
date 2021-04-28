#!/bin/sh

curl -X "POST" "http://localhost:28084/connectors" \
		-H "Content-Type: application/json" \
		-d @"es-sink.json"