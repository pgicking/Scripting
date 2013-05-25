#!/bin/sh

#runawaycheck.sh
#Written by Peter Gicking (Swook)

#Works in conjuction with Runaway.py
#This ssh's into every computer in linux-login-sys.txt and 
#runs a python script to get machine information. 

username=gickingp


fname=linux-login-sys.txt

exec<$fname

#removes previous Results.txt
rm Results.txt
echo `date` > Results.txt

#This loop is the heart of the script
#While reading linux-login-sys.txt, it tries to connect to each computer in the file
# with a timeout of 5 seconds.
# -n means do not read from stdin, this flag must be used if ssh is being run in the background
# -o flag means "options" which allows the ConnectTimeout
#-l means login with public/private key authentication, this script cannot be run without it. 
# 
while read line
do
	ssh -n -o ConnectTimeout=5 $line -l $username $hostname "python /u/gickingp/Documents/Documents/Python/Runaway.py" >> Results.txt
done

cat Results.txt
#Print the results to the screen. Recommend you use "more" to view
#the output, because "less" will break the color coding. 

