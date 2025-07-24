#!/bin/bash

BAT_PATH=""
for bat in /sys/class/power_supply/BAT*; do
    if [ -e "$bat/uevent" ]; then
        BAT_PATH="$bat"
        break
    fi
done

HAS_BATTERY=true
if [ -z "$BAT_PATH" ]; then
    HAS_BATTERY=false
    POWER_SUPPLY_CAPACITY=100
    POWER_SUPPLY_STATUS="Full"
fi

if [ "$HAS_BATTERY" = true ]; then
    source "$BAT_PATH/uevent"
fi

declare -A battery_icons_charging=(
    [100]="battery_charging_full"
    [90]="battery_charging_80"
    [80]="battery_charging_80"
    [70]="battery_charging_60"
    [60]="battery_charging_60"
    [50]="battery_charging_50"
    [40]="battery_charging_30"
    [30]="battery_charging_30"
    [20]="battery_charging_20"
    [10]="battery_charging_20"
    [0]="battery_charging_20"
)

declare -A battery_icons=(
    [100]="battery_full"
    [90]="battery_5_bar"
    [80]="battery_5_bar"
    [70]="battery_5_bar"
    [60]="battery_5_bar"
    [50]="battery_4_bar"
    [40]="battery_3_bar"
    [30]="battery_3_bar"
    [20]="battery_2_bar"
    [10]="battery_alert"
    [0]="battery_alert"
)

declare -A no_battery_icon=(
    [default]="power"
)

get_closest_battery_icon() {
    if [ "$HAS_BATTERY" = false ]; then
        echo "${no_battery_icon[default]}"
        return
    fi

    local level="$1"
    local charging="$2"
    local -n icons_array

    if [ "$charging" = "true" ]; then
        icons_array=battery_icons_charging
    else
        icons_array=battery_icons
    fi

    local levels=($(for key in "${!icons_array[@]}"; do echo "$key"; done | sort -nr))

    for threshold in "${levels[@]}"; do
        if [ "$level" -ge "$threshold" ]; then
            echo "${icons_array[$threshold]}"
            return
        fi
    done

    echo "${icons_array[${levels[-1]}]}"
}

icon() {
    if [ "$HAS_BATTERY" = false ]; then
        echo "${no_battery_icon[default]}"
        return
    fi

    local capacity="$POWER_SUPPLY_CAPACITY"
    local charging="false"

    if [[ "$POWER_SUPPLY_STATUS" == "Charging" || "$POWER_SUPPLY_STATUS" == "Full" ]]; then
        charging="true"
    fi

    get_closest_battery_icon "$capacity" "$charging"
}

status() {
    if [ "$HAS_BATTERY" = false ]; then
        echo "No battery found."
        return
    fi
    echo "$POWER_SUPPLY_CAPACITY%"
}

case $1 in
info) info ;;
icon) icon ;;
status) status ;;
*)
    echo "Usage: $0 {info|icon|status}"
    exit 1
    ;;
esac