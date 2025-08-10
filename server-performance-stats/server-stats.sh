#!/bin/sh


top -bn1 | grep '%Cpu' | cut -d ',' -f 4 | awk '{print "Total CPU Usage: " 100 - $1 "%"}'

echo

free | grep 'Mem' | awk '{usedm = ($3 * 100) / $2; freem = ($4 * 100) / $2; print "Total memory: " $2 "\tUsed memory: " usedm "%\tFree memory: " freem "%"}'

echo

df -h | grep "/" -w | awk '{
	gsub(/G/, "", $4);
	gsub(/G/, "", $2);
	avd = $4 + 0;
	totd = $2 + 0;
	percentavd = (avd * 100) / totd;
	printf "Total disk: %sG\tAvailable: %.2f%%\tUsed: %s\n", totd, percentavd, $5;
	}'
echo

echo "Top 5 processes by CPU usage"

ps aux --sort -%cpu | head -6 | awk 'NR>1 {print $1 " -> " $2}'

echo

echo "Top 5 processes by memory usage" 

ps aux --sort -%mem | head -6 | awk 'NR>1 {print $1 " -> " $2}'
