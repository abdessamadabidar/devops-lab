#!/bin/sh

if [ $# -eq 0 ]; then
    echo "Usage: $0 <logs_file>"
    echo "Error: No logs file specified"
    exit 1
fi

LOGS_FILE="$1"

if [ ! -f "$LOGS_FILE" ]; then
    echo "Error: Logs file '$LOGS_FILE' not found"
    exit 1
fi



filter_logs() {
	sed -E '/^[0-9.]+ - - \[.*\] ".*" [1-5][0-9]{2} [0-9]+ ".*" ".*"$/!d' "$@"
}

echo "Top 5 IP addresses with the most requests:"
# Process IP addresses

filter_logs "$LOGS_FILE" \
	| awk '{ print $1 }' \
	| sort | uniq -c | sort -nr | head -5 \
	| awk '{ printf "%s - %s requests\n", $2, $1 }'

echo

echo "Top 5 most requested paths:"

filter_logs "$LOGS_FILE" \
	| awk '{ print $7 }' \
	| sort | uniq -c | sort -nr | head -5 \
	| awk '{ printf "%s - %s requests\n", $2, $1 }'

echo

echo "Top 5 response status codes:"

filter_logs "$LOGS_FILE" \
	| awk '$9 ~ /^[1-5][0-9]{2}$/ { print $9 }' \
	| sort | uniq -c | sort -nr | head -5 \
	| awk '{ printf "%s - %s requests\n", $2, $1 }'


