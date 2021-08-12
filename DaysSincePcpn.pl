#!/bin/env perl

use JSON;


$startDate=$ARGV[0];
$endDate=$ARGV[1];
$threshold=$ARGV[2];


$params = 'params={"state":"wi","sdate":"'.$startDate.'","edate":"'.$endDate.'","elems":[{"name":"pcpn","interval":"dly","duration":"dly","add":"f"}]}';

$json = `curl --data '$params' http://data.rcc-acis.org/MultiStnData`;

$data = decode_json($json);

$data = $$data{"data"}; #For Multi-station calls, all data is saved in an overarching "data" pointer, hence the self referencing point

$meta1 = $$data[0]; #Points to the first station

$meta2 = $$meta1{"meta"}; #Points to the metadata part of the first station

$uid = $$meta2{"uid"}; #Points Directly to the UID

$StnCnt=0;#Allows us to count how many stations there are and progress through the while loop.

while ($uid ne "") #If there's a station still remaining in the list, the loop will take a look at it. Use a while loop because we don't know how many stations there are
{ #BEGIN WHILE LOOP

		$pcpn=${${$$data[$StnCnt]}{"data"}}[0][0];
		$i=0;
		
		while ($pcpn ne "")
		{
			if ($pcpn < $threshold){$daysWithout++;}
			else {$daysWithout=0;}
			$pcpn=${${$$data[$StnCnt]}{"data"}}[$i][0];
			$i++;
		}
		print "$uid,$daysWithout;";
		
        $StnCnt++; #Update the counter so we can find the next UID
        $uid = ${${$$data[$StnCnt]}{"meta"}}{"uid"}; #redefine the UID to the next station in the while loop


} #END WHILE LOOP