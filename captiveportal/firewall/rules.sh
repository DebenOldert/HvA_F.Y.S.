#Captive portal iptables rule script
#Copyright Deben Oldert
#This script handles the rules for the captive portal
#It is multifuncional
#Initialize the new rules (startup)
#Delete a rule for an ip to grand internet access
#Display statusses

#define version of the script
version="V1.2.56"

#load IPTables
IPTABLES=/sbin/iptables

#When it needs to initialize the rules, do this
if [ "$1" == "initialize" ]
then
  #Display startup message
  echo $version
  echo "Copy right: Deben Oldert"
  #Flush all existing rules
  $IPTABLES -F
  $IPTABLES -X
  #Allow forwarding
  echo 1 > /proc/sys/net/ipv4/ip_forward
  #Read all ips from ip file and make rule per ip
  #Each ip from the list will be redirected to the captive portal
  echo "These IP's will be redirected to the Captive Portal"
  #define 1 (ip counter) and set it to zero
  i=0
  #Read each line as $ip
  while read ip
    do
        #Shits getting serious now
        $IPTABLES -t nat -A PREROUTING -s "$ip" -p tcp -j DNAT --to-destination$
        #Print the ip
        echo $ip
        #Increment 1 on i
        ((i++))
    #Not the last line in file? Lets do is again!
    done < /users
  #Show the amount of ip's
  echo "Added $i IP's to rule list"
  echo "Done"
  fi

#If action is permitting acces to internet, delete rule to portal
if [ "$1" == "delete" ]
  then
    #check if $2 (ip adress) not empty
    if [[ ! -z "$2" ]]
    then
      #Delete the rule
      $IPTABLES -t nat -D PREROUTING -s $2 -p tcp -j DNAT --to-destin$
      #Tell the system its fine
      echo "SUCCES"
    else
      #Missing the $2 parameter
      echo "FAIL"
  fi
fi
#This is for debugging only
#$IPTABLES -t nat -L PREROUTING