#!/bin/bash

  while IFS= read -r line
  do
   line=($line)
   name=${line[0]}
   if [[ "$line" != *web* ]] && [[ "$line" != *app* ]] && [[ "$line" != *sysad* ]]; then
    sudo userdel -r "$name"
    if grep -q "$name" /home/admin/mentors/*/*/allocatedMentees.txt; then
     sed -i "/$name/d" "/home/admin/mentors/*/*/allocatedMentees.txt"
     sudo rm -rf /home/admin/mentors/*/*/submittedTasks/task{1..3}/"$name"
    fi
   fi
  done < /home/admin/mentees_domain.txt 
   for domain in web app sysad; do
    if grep -q "$name" /home/admin/mentors/"$domain"/*/allocatedMentees.txt; then
     sed -i "/$name/d" "/home/admin/mentors/"$domain"/*/allocatedMentees.txt"
     sudo rm -rf /home/admin/mentors/"$domain"/*/submittedTasks/task{1..3}/"$name"
     rm /home/admin/mentors/$domain/*/submittedTasks/task{1..3}/"$name"
    fi    
   done
 
