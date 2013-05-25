#!/bin/sh
username=gickingp


fname=/u/gickingp/Documents/Documents/linux-login-sys.txt
 
#top | sort -nr +9

exec<$fname
rm boxen.txt
echo `date` > boxen.txt

while read line
do
	ssh -n -o ConnectTimeout=5 $line -l $username $hostname "bash /u/gickingp/Documents/web/status.sh" >> boxen.txt
# top -c -b -d 1 -n 1 | head -8 | tail -2
done

cp boxen.txt ~/public_html
