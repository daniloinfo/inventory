#!/bin/bash
#
#
#               innventory.sh -- Script para extrair informaçs de uma lista de roteadores
#
#
## Ser behaviour
public="public"
workingdir="/home/g0038248/inventory"
#
LOG=$workingdir/RESULT.csv
infile=$workingdir/RTR_LIST
snmp="/usr/bin/snmpwalk -v2c -c $public"
#
while read device
do
        $snmp $device 1.3.6.1.2.1.1.5 > /dev/null
        if [ "$?" = "0" ] ; then
                rtr=`$snmp $device .1.3.6.1.4.1.9.2.1.3.0 | cut -f2 -d\" `
                type2=` $snmp $device .1.3.6.1.4.1.9.9.25.1.1.1.2.3 | cut -f2 -d$ `
                ios=` $snmp $device .1.3.6.1.4.1.9.9.25.1.1.1.2.5 | cut -f2 -d$ `
                prot=` $snmp $device .1.3.6.1.4.1.9.9.25.1.1.1.2.4 | cut -f2 -d$ `
                echo "$device, $rtr, $type2, $ios, $prot" >> $LOG
        fi
done < $infile
