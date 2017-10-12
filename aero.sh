#!/bin/bash


###########################
##     AeroDecaptcher    ##
##                       ##
##     Author: sudoc     ##
##                       ##
##    Check readme for   ##
##   further assistance  ##
##                       ##
## WARNING THIS SOFTWARE ##
## IS PROVIDED AS IS FOR ##
## TESTING PURPOSES ONLY ##
## USE AT YOUR OWN RISK! ##
###########################

##overrun protection##
main_pid=$$
pid_loc="main_pid"

if [ -e $pid_loc ] ; then
	exit 0
fi
echo $main_pid > $pid_loc

##include config files##
. $(dirname "$0")/aero.conf


##check for internet##
ping google.com -n 2 > $temp_file
check=`cat $temp_file | grep -i "ttl"`
rm $temp_file
if [ "$check" != "" ] ; then
	rm $pid_loc
	exit 0
fi

##initialize variables##
origin='Origin: '$aero_url''
referer='Referer: '$aero_url''
success="false"
main_counter=0

function cleanup
{
	rm $temp_file
	rm $captcha_file
} 

##obtain captcha image##
curl $aero_url -H '$origin' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.8' -H 'Upgrade-Insecure-Requests: 1' -H 'Cache-Control: max-age=0' -H '$referer' -H 'Connection: keep-alive' --data 'viewForm=true' --compressed --connect-timeout 5 > $temp_file

while [ "$success" != "true" ] ; do

	##check answer##
	captcha_url=`cat $temp_file | grep getCaptcha | head -n 1 | tail -c 68 | head -c -16`
	if [ "$captcha_url" = "" ] ; then
		echo "Error occured exiting..."
		rm $pid_loc
		exit 1
	fi

	rm $temp_file

	sessionID=`echo $captcha_url | head -n 1 | tail -c 37 | head -c -1`
	captcha_url=$aero_url$captcha_url

	curl $captcha_url -H 'Accept: image/webp,image/apng,image/*,*/*;q=0.8' -H 'Connection: keep-alive' -H 'Accept-Encoding: gzip, deflate' -H '$referer' -H 'Accept-Language: en-US,en;q=0.8' --compressed > $captcha_file

	echo "waiting for captcha..."
	#sleep 60
	#read captcha
	#captcha="ldsa133"
	
	
	### 2captcha ###
	
	exec /bin/perl $vpnoverdns_loc -X -F &
	pid=$!;
	echo $pid
	sleep 2
	
	curl -i -X POST -x $proxy_address:$proxy_port -H "Content-Type: multipart/form-data" -F "method=post" -F "key=$apikey" -F "file=@$captcha_file" -F "min_len=8" -F "max_len=8" http://2captcha.com/in.php > $temp_file
	response=`cat $temp_file | grep "OK|" | head -c 2`
	if [ "$response" != "OK" ] ; then
		echo "Error occured see $temp_file"	
		kill -9 $pid
		rm $pid_loc
		exit 1
	fi
	captchaID=`cat $temp_file | grep "OK|" | cut -c 4-`
	echo "captchaID=$captchaID"
	rm $temp_file
	
	sleep 10
	
	data="http://2captcha.com/res.php?key=$apikey&action=get&id=$captchaID"
	curl $data -x $proxy_address:$proxy_port > $temp_file
	response=`cat $temp_file | grep "OK|" | head -c 2`
	if [ "$response" != "OK" ] ; then
		echo "Something goes wrong with 2captcha"	
		sleep 15
		echo "retrying..."
		counter=0
		while [ "$response" != "OK" ] ; do
			counter=[$counter+1]
			curl $data -x $proxy_address:$proxy_port > $temp_file
			response=`cat $temp_file | grep "OK|" | head -c 2`
			if [ "$response" != "OK" ] ; then
				if [ "$counter" = "16" ] ; then
					echo "captcha not ready."
					rm $pid_loc
					kill -9 $pid
					exit 1
				fi
				sleep 6
			fi
		done
	fi
	kill -9 $pid
	captcha=`cat $temp_file | grep "OK|" | cut -c 4-`
	echo $captcha
	
	### end 2captcha ###
	
	data=$sessionID'&viewForm=true&captcha='$captcha
	
	curl $aero_url -H '$origin' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.8' -H 'Upgrade-Insecure-Requests: 1' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H '$referer' -H 'Connection: keep-alive' --data $data --compressed > $temp_file
	
	success=`cat $temp_file | grep Niepoprawna`
	#echo $success
	if [ "$success" = "" ] ; then
		success="true"
		echo "Success exiting"
	else
		echo "Error occured wrong captcha retrying..."
		sleep 20
	fi
	
	main_counter=$[main_counter+1]
	if [ "$main_counter" = "3" ] ; then
		echo "Unknown error"
		kill -9 $pid
		rm $pid_loc
		exit 1
	fi
	
done

rm $temp_file
rm $captcha_file
rm $pid_loc