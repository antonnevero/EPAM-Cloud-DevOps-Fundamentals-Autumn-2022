#!bin/bash

read -p "Enter name and path to the file: " file_path

echo "-------------1. From which ip were the most requests?----------"
awk '{print $1}' $file_path | sort | uniq -c | sort -nr | head -n 1 | awk 'BEGIN {print "Count IP"}{print}' | column -t
echo ""


echo "#-------------2. What is the most requested page?----------------"
awk '{print $7}' $file_path  | sort | uniq -c | sort -nr | head -n 1 | awk 'BEGIN {print "Count Page"}{print}' | column -t
echo ""


echo "#-------------3. How many requests were there from each ip?------------"
awk '{print $1}' $file_path  | sort | uniq -c | sort -nr |\
 awk 'BEGIN {print "Count IP"}{print} {n=n+$1} END{print "-", "ИТОГО", n}' | column -t 
echo ""


echo "#-------------4. What non-existent pages were clients referred to?-------" 
awk '$9 == "404" {print $7}' $file_path | sort | uniq -c | sort -nr | awk 'BEGIN {print "Count Page"}{print}' | column -t
echo ""


echo "#------------------5. What time did site get the most requests? ----------------"
awk '{print $4}' $file_path | sort | uniq -c | sort -nr | head -n 1|\
 awk 'BEGIN {print "Count Time"}{print}' | column -t
echo ""


echo "#------------------6. What search bots have accessed the site? ----------------"
awk '/Googlebot|bingbot/{print $13 $14 $15 $16}' $file_path | sort | uniq -c| sort -nr |\
 head -n 3 | awk 'BEGIN {print "Count Bot"}{print}' | column -t

