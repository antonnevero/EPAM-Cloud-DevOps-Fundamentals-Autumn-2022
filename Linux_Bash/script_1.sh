#!bin/bash

ALL='The --all key displays the IP addresses and symbolic names of all hosts in the current subnet'
TARGET='The --target key displays a list of open system TCP ports.'
ip_sub=`ip -o -f inet addr show | awk '/scope global/ {print $4}'`


#--------------SHOW ALL POSSIBLE KEYS-------------
possible_keys () {
    echo $ALL
    echo $TARGET
}

#-------------SCANNING SUBNET VIA NMAP-----------
all_command () {
    sudo nmap -sn $ip_sub
    arp -a | awk '{print $1 $2}'
}

#----------------SCANNING OPEN TCP PORTS-----------
target_command () {
   sudo nmap -sT -O 127.0.0.1 | awk '$2 == "open" {print $1}'
}

#-----------------RUN FUNCTION DEPENDING OF THE USER'S ANSWER--------------
if [[ $1 == '--all' ]]; then
  all_command
elif [[ $1 == '--target' ]]; then
  target_command
else
  possible_keys
fi
