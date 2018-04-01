#!/bin/bash
# System Innformation

result=$(pwd)/"task4_1.out"

CPU=$(dmidecode -s processor-version)
RAM=`cat /proc/meminfo  | grep MemTotal | awk '{print $2" KB"}'`
      if [ -z "${RAM// /}" ] ; then RAM="Unknown" ; fi
MB="$(dmidecode -s baseboard-manufacturer) $(dmidecode -s baseboard-product-name)"
      if [ $(SSN=$(dmidecode -s system-serial-number)) -z ]; then SSN="Unknown"; fi
OS_Dist=`lsb_release -d --short`
Kernel_Ver=$(uname --kernel-release)
Inst_Date=$(ls -alct /|tail -1 | awk '{print $6, $7, $8}')
HostName=$(hostname)
UpTime=`uptime -p | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}'`
Proc_Run=`ps -e | wc -l`
User_Logged_In=$(who | wc -l)

echo "--- Hardware ---" > $result
echo "CPU: $CPU" >> $result
echo "RAM: $RAM" >> $result
echo "Motherboard: $MB" >> $result
echo "System Serial Number: $SSN" >> $result
echo "--- System ---" >> $result
echo "OS Distribution: $OS_Dist" >> $result
echo "Kernel version: $Kernel_Ver" >> $result
echo "Installation date: $Inst_Date" >> $result
echo "Hostname: $HostName" >> $result
echo "Uptime: $UpTime" >> $result
echo "Processes running: $Proc_Run" >> $result
echo "User logged in: $User_Logged_In" >> $result
echo "--- Network ---" >> $result

for Interface in $(ip addr list | grep "UP" | awk '{print $2}' | cut -d ":" -f 1 | cut -d "@" -f 1)
   do
	IP=`ip addr list $Interface | grep "inet " | awk '{print $2}'`
	if [ -z "${IP// /}" ] ; then IP="-"; fi
echo "$Interface: $IP"  >> $result

   done
