#!/bin/bash

# Determine current user's home directory
echo "shell script starting"
notify-send "My name is bash and I rock da house"

USER_HOME=$(getent passwd $(whoami) | cut -d: -f6)

# Define an array of scripts and their respective log files
declare -A SCRIPTS_LOGS=(
    ["$USER_HOME/code/read-dropbox/read_and_post.py"]="$USER_HOME/code/read-dropbox/read_and_post.log"
    ["$USER_HOME/code/read-dropbox/another_script.py"]="$USER_HOME/code/read-dropbox/another_script.log"
    # Add more scripts and their log files here
)

# Get current date and time in the desired format
current_datetime=$(date "+%Y-%m-%d %H:%M:%S")


# Function to reverse log entries
log_reverse() {
    local log_file=$1
    { echo "$current_datetime: Script executed"; cat "$log_file"; } > "$log_file.new" && mv "$log_file.new" "$log_file"
}

# Function to run a Python script
run_python_script() {
    local script_path=$1
    local log_file=$2
    $script_path >> "$log_file" 2>&1 &
    log_reverse "$log_file"
}

# Check if the system is in sleep or hibernate state
SYSTEM_STATE=$(systemctl is-system-running)

if [ "$SYSTEM_STATE" == "degraded" ]; then
    # System is in sleep/hibernate, set wake-up time and suspend

    # Run all scripts after wake-up
    for script_path in "${!SCRIPTS_LOGS[@]}"; do
        run_python_script "$script_path" "${SCRIPTS_LOGS[$script_path]}"
    done
 
else
    # System is sleeping, poke it!
    WAKEUP_TIME=$(date -d "+1 minute" +%Y-%m-%d %H:%M:%S)
    sudo rtcwake -m mem --date "$WAKEUP_TIME"

    # System is now active, run all scripts
    for script_path in "${!SCRIPTS_LOGS[@]}"; do
        run_python_script "$script_path" "${SCRIPTS_LOGS[$script_path]}"
    done
fi