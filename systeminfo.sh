#!/bin/bash

#Written By: Brandon Perry
#File grabs a report of a bunch of different system info and puts it in an html file
fileName=System.html
#Functions are alphabetized
#This function checks to see if the root user is running the script, becuse the hardware wont' be found otherwise.
if [ "$EUID" != 0 ]; then
   echo "Script Failure: Not being ran as root"
   exit
fi
#This function shows all the storage connected to the system
drives(){
   echo "<p>Hard Drives & Other Storage</p><pre>"
    lsblk
    echo "</pre>"
}
#This function grabs the Ip address from the system
ip() {
   echo "<p>Ip Address</p>"
   echo "<pre>"
   hostname -I
   echo "</pre>"
}
#This function grabs the Kernel Info from the system
kernel() {
      echo "<p>Kernel</p><pre>"
         cat /proc/version
      echo "</pre>"
}
#This function shows how much RAM is available
memory(){
   echo "<p>Memory</p><pre>"
   free -h
   echo "</pre>"
}
#This function shows off all the Cpu information
processor(){
   echo "<p>Processor name, Core Count, etc.</p><pre>"
   lscpu
   echo "</pre>"
}
#This function displays all of the users, I couldn't figure out how to display the groups
users (){
   echo "<p>Users on the System</p><pre>"
   cat /etc/passwd
   echo "</pre>"
}
#This writes to the html file
cat > System.html <<- eof
   <!DOCTYPE html>
   <html>
      <head>
         <title>Report on your System</title>
      </head>
      <body>
         <p>$USER@$(uname -n) $(date)</p>
         <div>
            $(kernel)
            $(processor)
            $(memory)
            $(drives)
            $(users)
            $(ip)
         </div>
      </body>
   </html>
eof
