#!/bin/bash


mem=$(grep MemTotal /proc/meminfo | awk '{print $2}')  #get total memory in KB


#Umem=$(grep MemFree /proc/meminfo | awk '{print $2}') #get Free memory in KB
#UmemMB=$(($Umem / 1024)) #convert free memory into MB

TMb=$(($mem / 1024)) #convert Total memory into MB

# print os.system("free -m | head -2 | tail -1 | awk '{print \"Used: \" $3 \" Free: \" $4}'")

UsedMem=$(free -m | head -2 | tail -1 | awk '{print $3}')


#UMB=$(($TMB - $UmemMB)) #Get used memory in MB by minusing freememory from total memory
#UMB=$(($UmemMB - $TMB)) 

host=$(uname -n)

ldavg=$(uptime | awk '{print $10 $12}') #$10 for 1 minute ldavg, $12 for 15 minute ldavg

memD=$(echo "$UsedMem / $TMb" | bc -l ) 
memP=$(echo "$memD * 100" | bc -l | cut -d '.' -f1) #cut off the decimals



#echo "$host $UsedMem/$TMb Mb $memP% ldavg: $ldavg" 

echo "$host MemUse: $memP% ldavg: $ldavg" 
