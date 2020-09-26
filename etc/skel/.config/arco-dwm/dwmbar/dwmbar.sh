#!/usr/bin/env sh

dte(){
  dte="$(date +"%A, %B %d | 🕒 %H:%M%p")"
  echo -e "$dte"
}

mem(){
  mem=`free | awk '/Mem/ {printf "%d MiB/%d MiB\n", $3 / 1024.0, $2 / 1024.0 }'`
  echo -e "🖪 $mem"
}

vol(){
  vol=$(amixer get Master | awk -F'[]%[]' '/%/ {if ($7 == "off") { print "MM" } else { print $2 }}' | head -n 1)
  echo -e "🔊 $vol% vol"	
}

cpu(){
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e "💻 $cpu% cpu"
}

temp(){
  temp="$(sensors | awk '/Core 0/ {print $3}')"
  echo -e "$temp" 
}

wth(){
  curl -s v2.wttr.in | grep -e "Weather" | sed 's/C,.*/C/g; s/+//g; s/.*\[0m.//g; s/.//2'
}   

while true; do
     xsetroot -name "$(wth) | $(cpu) | $(temp) | $(vol) | $(mem) | $(dte)"
     sleep $DELAY;    # Update time every ten seconds
done &

