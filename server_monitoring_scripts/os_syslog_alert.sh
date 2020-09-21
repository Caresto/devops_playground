#!/bin/bash

#Initialize variables

prev_count=0

count=$(grep -i "`date --date='today' '+%b %e'`" /var/log/syslog | egrep -wi 'warning|error|critical' | wc -l)

if [ "$prev_count" -lt "$count" ] ; then

# Create email

SUBJECT="WARNING: Errors found in log on "`date --date='today' '+%b %e'`""

MESSAGE="/tmp/logs.txt"

TO="Edit with receiver emails"

echo "ATTENTION: Errors are found in /var/log/syslog." >> $MESSAGE

echo  "Hostname: `hostname`" >> $MESSAGE

echo -e "\n" >> $MESSAGE

echo "+------------------------------------------------------------------------------------+" >> $MESSAGE

echo "Error messages in the log file as below" >> $MESSAGE

echo "+------------------------------------------------------------------------------------+" >> $MESSAGE

grep -i "`date --date='today' '+%b %e'`" /var/log/syslog | awk '{ $3=""; print}' | egrep -wi 'warning|error|critical' >>  $MESSAGE

mail -s "$SUBJECT" "$TO" < $MESSAGE

fi