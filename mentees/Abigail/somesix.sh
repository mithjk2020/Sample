#!/bin/bash

name=$(whoami)
    read -p "Enter domain you want to deregister from: " domain
    if [[ grep -q "$domain" /home/admin/mentees/"$name"/domain_pref.txt ]]; then
        rm -r "/home/admin/mentees/$name/$domain"
        sed -i "s/$domain//g" "/home/admin/mentees/$name/domain_pref.txt"
        echo "You have successfully deregistered from $domain."
    else
        echo "You are not registered for $domain."
    fi

