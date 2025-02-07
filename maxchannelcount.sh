#!/bin/bash

temp_file=$(mktemp)
logfile="/mq/script/MQ_max_channelcount_$(date +'Y%m%d_%H%M%S').txt"
queue_manager=$(dspmq | grep 
echo "------------------------------------" >> "$logfile"
echo "EMQ MAX Active Channel Connections count Summary report -$(date +'Y%m%d_%H%M%S')" >> "$logfile"
echo "------------------------------------" >> "$logfile"
for qmgr in $queue_manager;do
         channel_count=-0
channel_list=$(echo "DISPLAY CHL(*) 
