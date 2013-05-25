#! /usr/bin/env python

#Runaway.py
#Written by Peter Gicking (Swook)

import os
import socket
import subprocess

class Machine():
	def __init__(self, name):
		self.name = name
		self.ldavg = self.avgavg()
		

	def avgavg(self):  #this will add up the 3 load averages and get the average of the averages
		ldavg = os.getloadavg()
		self.total = 0
		for i in ldavg: #gets the 3 load averages
			self.total += i  #iteration
		self.total /= 3 #divison
		return self.total #return

#class defining color codes for messages. 
class bcolors():
    TOOHIGH = '\033[31m'
    MEDIUM = '\033[33m'
    OKGREEN = '\033[32m'
    ENDC = '\033[37m'

    def disable(self):
        self.TOOHIGH = ''
        self.MEDIUM = ''
        self.OKGREEN = ''
        self.ENDC = ''


if __name__ == "__main__":   #This means, if we run this script, run everything under it. 
	MachineName = (socket.gethostbyaddr(socket.gethostname()))
    #python function from the OS library. Gets machine info. 

	myMachine = Machine(MachineName)

#Take the load averages calculated earlier and compares them against arbitrary values.
	if (myMachine.ldavg > 8.0):
		message = "too high\n"
	elif (myMachine.ldavg > 5.0): 
		message = "Medium Load\n"
	elif (myMachine.ldavg < 2.0):
		message = "All is good\n"

# print os.system("free -m | head -2 | tail -1 | awk '{print \"Used: \" $3 \" Free: \" $4}'")
# The above will print the computer memory in format Used: XXXX Free: XXXX

# Gets how much memory is in use and assigns a level accordingly
if (os.system("free -m | head -2 | tail -1 | awk '{$3}'") > 3800):
	level = 3
	memory = "Something might be eating memory"
elif (os.system("free -m | head -2 | tail -1 | awk '{$3}'") > 3000):
        level = 2
        memory = "Memory use slightly above normal"
elif (os.system("free -m | head -2 | tail -1 | awk '{$3}'") < 2500):
	level = 1
        memory = "Memory use is at normal levels"


if (myMachine.ldavg > 8.0):
	print bcolors.TOOHIGH + message
	print myMachine.name, " has a loadaverage of: ",  myMachine.ldavg
		
		# Prints in red/yellow/green depending on memory in use
	if (level == 3):
		print bcolors.TOOHIGH + memory
	elif (level == 2):
		print bcolors.MEDIUM + memory
	elif (level == 1):
		print bcolors.OKGREEN + memory
 
	print bcolors.ENDC

elif (myMachine.ldavg > 5.0):
	print bcolors.MEDIUM + message
	print myMachine.name, " has a loadaverage of: ",  myMachine.ldavg
		
		# Prints in red/yellow/green depending on memory in use
	if (level == 3):
       	        print bcolors.TOOHIGH + memory
       	elif (level == 2):
               	print bcolors.MEDIUM + memory
       	elif (level == 1):
               	print bcolors.OKGREEN + memory

	print bcolors.ENDC

elif (myMachine.ldavg < 2.0):
	print bcolors.OKGREEN + message
	print myMachine.name, " has a loadaverage of: ",  myMachine.ldavg
	
		# Prints in red/yellow/green depending on memory in use
	if (level == 3):
       	        print bcolors.TOOHIGH + memory
       	elif (level == 2):
       	        print bcolors.MEDIUM + memory
       	elif (level == 1):
        	        print bcolors.OKGREEN + memory

	print bcolors.ENDC
#The ENDC at the end of print colors is important, if it not there everything you type
# will be in green after the script runs. 
	
#	print bcolors.OKGREEN + message # + bcolors.ENDC

