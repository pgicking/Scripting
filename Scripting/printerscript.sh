#! /bin/bash
#TODO: 
echo "${USER}'s testpage" > testpage.txt
#Create a file called "testpage.txt, and put username on the testpage

date >> testpage.txt
#put date on the test page

echo '_printerinfo_' >> testpage.txt
#put printer info in test page to be replaced via sed later

head -c 4720 /dev/urandom | tr -c '[:print:]' '[\?*]' >> testpage.txt
#Get the first 4720 characters of /dev/urandom then
#using tr, we take out any unprintable characters in dev/urandom that could wreck the printer
# and replace it with question marks

#This allows you specify if you want to print to fab or eb printers
#You have to add "eb" or "fab" as a flag. Otherwise the script wont run
if [ $1 == fab ]
then
    printer_list="fab8201bw1 fab5517bw1 fab5517bw2 fab6001bw1 fab6019bw1"

elif [ $1 == eb ]
then
     printer_list="eb325bw1 eb325bw2 eb423bw1"

else 
    echo "Needs to run with 'eb' or 'fab'"
fi


for printer in $printer_list; do
#script will step through every printer in printer_list

	cp testpage.txt testpage-$printer.txt
#copy testpage.txt to testpage-the name of the printer we are printing to

	sed "s/_printerinfo_/printer:$printer/" -i testpage-$printer.txt
#replace _printerinfo_ wirh $printer

	echo printer is $printer >> testpage-$printer.txt
    #echo "printer is name_of_printer (i.e. fab8201bw1)" at the top of the testpage we are sending to the printer

	lpr -P $printer testpage-$printer.txt
#execute the print command to the printer and send the testpage

	rm testpage-$printer.txt
#remove the testpage and start over until every printer in printer_list has been printed to

done

rm testpage.txt
#removes testpage.txt
