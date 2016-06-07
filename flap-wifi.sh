#! /usr/bin/env bash 
DNS=(208.67.222.222 208.67.220.220 8.8.8.8 8.8.4.4)
PORT=en0
count=0
delay=5
starttime=$(date +%s)
while true; do
  ssid=$(airport -I | grep ' SSID' | awk -F": " '{print $2}')
  echo "$ssid: $(date "+%H:%M:%S"): ${DNS[count]}: delay $delay" 
  dig @${DNS[count]} +tries=1 +time=3 google.com | \
          grep 'Query time' | \
          cut -d ' ' -f 4 -f 5
  if [ ${PIPESTATUS[0]} -ne 0 ] ; then
     echo "Flapping port $PORT after $(($(date +%s) - $starttime)) seconds"
     sudo ifconfig $PORT down
     sudo ifconfig $PORT up
     starttime=$(date +%s)
     delay=5
  fi
  count=$(( $count + 1 ))
  if [ $count -gt "3" ]; then 
     count=0
     if [ $delay -lt "120" ]; then 
        delay=$(( $delay + 5 ))
     fi
  fi
  if read -t $delay -rsn1 ; then
     delay=5
  fi
done
