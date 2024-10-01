#!/bin/bash
echo "Starting Rasa server..."
echo "PORT: $PORT"
rasa run --enable-api --port $PORT --cors "*" --debug --log-file rasa.log