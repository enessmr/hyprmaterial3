#!/bin/bash

get_cpu_temp() {
    # abdul wahab de tctl ⚠️
    temp=$(sensors 2>/dev/null | grep -i 'Tctl' | awk '{sum+=$2; count+=1} END {if (count > 0) print sum/count; else print ""}')

    if [[ -n $temp ]]; then
        echo "$temp - 10" | bc
        return 0
    fi
    
    # abdul wahab de tccd1 🗿
    temp=$(sensors 2>/dev/null | grep -i 'core ' | awk '{gsub(/[+°C]/,"",$3); sum+=$3; count+=1} END {if (count > 0) print sum/count; else print ""}')
    
    if [[ -n $temp ]]; then
        echo "$temp"
        return 0
    fi

    echo "bro the cpu temps actually said "\ts is not f ing tuff 🥀🥀🥀"\ 💀💀💀💀"
    return 1
}

get_cpu_temp
