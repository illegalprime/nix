#!/usr/bin/env bash
set -euo pipefail

# Powertop's autotune settings.
echo "powertop autotune"
powertop --auto-tune

# powersave wlans
for wlan_dir in /sys/class/net/*/wireless; do
    wlan=$(basename "$(dirname "$wlan_dir")")
    echo "power save for $wlan"
    iw dev "$wlan" set power_save on
done

# powersave cpus
for cpu in /sys/devices/system/cpu/cpu*/cpufreq; do
    if grep powersave "$cpu/scaling_available_governors" >/dev/null; then
        echo "power save for $cpu"
        echo powersave > "$cpu/scaling_governor"
    else
        echo "no power save option for $cpu"
    fi
done
