#!/bin/bash


if [ $# -lt 1 ]; then
    echo "You need to pass log file path as argument"
    exit 1
fi

TOPIPS=$(awk '{print $1}' $1 | sort | uniq -c | sort -nr | head -n 5 | awk '{printf "%-30s %-6s requests\n", $2, $1}')

TOPPATHS=$(awk '{print $7}' $1 | sort | uniq -c | sort -nr | head -n 5 | awk '{printf "%-30s %-6s requests\n", $2, $1}')

TOPRESCODES=$(awk '{if ($9 == "\"-\"") {
                                print $7; # Rare case where column 9 is isnt the response code
                                } else {
                                print $9; # Default case
                                }
                            }' $1 | sort | uniq -c | sort -nr | head -n 5 | awk '{printf "%-30s %-6s requests\n", $2, $1}')

TOPUSERAGENTS=$(awk -F'"' '{print $6}' $1 | sort | uniq -c | sort -nr | head -n 5 | awk '{printf "%-6s requests for User-Agent: %s\n", $1, substr($0, index($0,$2))}')

echo -e "Top 5 IP addresses with the most requests:\n$TOPIPS"
echo -e "\nTop 5 most requested paths:\n$TOPPATHS"
echo -e "\nTop 5 response status codes:\n$TOPRESCODES"
echo -e "\nTop 5 user-agents:\n$TOPUSERAGENTS"
