#!/bin/bash
source /home/bpeake/.bashrc

#Sets the arguments needed for the perl script

#Set start date
day0=`date -d "0 day ago" +%Y%m%d`
day1=`date -d "1 day ago" +%Y%m%d`
day2=`date -d "2 day ago" +%Y%m%d`
day3=`date -d "3 day ago" +%Y%m%d`
day7=`date -d "7 day ago" +%Y%m%d`

day365=`date -d "365 day ago" +%Y%m%d`
day366=`date -d "366 day ago" +%Y%m%d`
day367=`date -d "367 day ago" +%Y%m%d`
day368=`date -d "368 day ago" +%Y%m%d`
day372=`date -d "372 day ago" +%Y%m%d`

mon=`date +%m`
yr=`date +%Y`
dy=`date +%d`

cd /home/bpeake/DEWS

perl DaysSincePcpn.pl $day365 $day0

perl DaysSincePcpn.pl $day366 $day1

perl DaysSincePcpn.pl $day367 $day2

perl DaysSincePcpn.pl $day368 $day3

perl DaysSincePcpn.pl $day372 $day7

cd DATA

cp $day0-DWOP.csv $day1-DWOP.csv $day2-DWOP.csv $day3-DWOP.csv $day7-DWOP.csv /home/mrcc/scriptInput/DWOP/
