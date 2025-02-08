#!/bin/bash

temp_file=$(mktemp)
logfile="/mq/script/MQ_max_channelcount_$(date +'Y%m%d_%H%M%S').txt"
queue_manager=$(dspmq | grep 
echo "------------------------------------" >> "$logfile"
echo "EMQ MAX Active Channel Connections count Summary report -$(date +'Y%m%d_%H%M%S')" >> "$logfile"
echo "------------------------------------" >> "$logfile"
for qmgr in $queue_manager;do
         channel_count=-0
channel_list=$(echo "DISPLAY CHL(*) " | runmqsc $qmgr | grep -v AMQ8414I | grep -i channel | awk -F "[()]" '{print$2}')
  for a in $channel_list; do
           count=$(echo "DISPLAY CHSSTATUS(${a})" | runmqsc $qmgr | grep 'AMQ8417'| wc -l)
           echo $(date +%F_%H:%M:%S),$qmgr,$a=$count >> "$temp_file"
           channel_count=$((channel_count + count))
  done
  echo "Total Active Channels for Queue Manager: $qmgr - $channel_count" >> "$logfile"
 echo "------------------------------------------------" >> "$logfile"
done
sort -t= -k2,2nr "$temp_file" | awk -F'[=,]' '!seen[$3]++'  >> "$logfile"
rm "$temp_file"


#echo "</body<>/html>"

echo "MAX_Channel_Count_Summary_report" | mailx -s "MAX_Channel_Count_Summary_Report" -a "$logfile" -S smtp=smtp.bankfab.com -r servermailid  akhil.kotla@gamil.com  <<EOF
Hi Everyone,

Please find attached Max Channel Count Summary Report.
Kindly check the abnormalities if any, and take the action accordingly.

Thanks & Regards ,
Akhil

