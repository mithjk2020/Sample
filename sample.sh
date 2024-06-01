#!/bin/bash

# Specify the directory containing the users
directory="/home/admin/mentors/sysad"

# Iterate over the list of users in the directory
for user in "$directory"/*; do
    if [ -d "$user" ]; then  # Check if the entry is a directory
        username=$(basename "$user")  # Extract the username from the directory path
        sudo userdel -r "$username"  # Delete the user and their home directory
    fi
done
