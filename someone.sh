#!/bin/bash

sudo useradd -m admin
sudo mkdir -p /home/admin/mentors /home/admin/mentees
sudo chmod 755 /home/admin/mentors
sudo chmod 755 /home/admin/mentees
sudo mkdir /home/admin/mentors/web /home/admin/mentors/app /home/admin/mentors/sysad
create(){
  sudo useradd -m -d /home/admin/mentors/$1/"$men" "$men"
  sudo chown "$men":"$men" /home/admin/mentors/$1/"$men"
  sudo chmod 755 /home/admin/mentors/$1/"$men"
  echo "$men:deltaforce@2024" | sudo chpasswd
  sudo touch /home/admin/mentors/$1/"$men"/allocatedMentees.txt
  sudo touch /home/admin/mentors/$1/"$men"/cap.txt
  sudo chmod 777 /home/admin/mentors/$1/"$men"/cap.txt
  sudo sh -c "echo '$cap' > /home/admin/mentors/'$1'/'$men'/cap.txt"
  sudo mkdir -p /home/admin/mentors/$1/"$men"/submittedTasks/task{1..3}
}

while IFS= read -r line
do
   line=($line)
   name=${line[0]}
   sudo useradd -m -d /home/admin/mentees/"$name" "$name"
   sudo chown "$name":"$name" /home/admin/mentees/"$name"
   sudo chmod 755 /home/admin/mentees/"$name"
   echo "$name:deltaforce@2024" | sudo chpasswd
   sudo touch /home/admin/mentees/"$name"/domain_pref.txt
   sudo touch /home/admin/mentees/"$name"/task_completed.txt
   sudo touch /home/admin/mentees/"$name"/task_submitted.txt
   sudo chmod 777 /home/admin/mentees/"$name"/.bashrc
   sudo chmod 777 /home/admin/mentees/"$name"/domain_pref.txt
   sudo chmod 777 /home/admin/mentees/"$name"/task_completed.txt
   sudo chmod 777 /home/admin/mentees/"$name"/task_submitted.txt
   sudo tee /home/admin/mentees/"$name"/task_submitted.txt > /dev/null <<EOF
   sysAd:
    Task1: n
    Task2: n
    Task3: n
   web:
    Task1: n
    Task2: n 
    Task3: n
   app:
    Task1: n
    Task2: n
    Task3: n
EOF
   sudo tee /home/admin/mentees/"$name"/task_completed.txt > /dev/null <<EOF
   sysAd:
    Task1: n
    Task2: n
    Task3: n
   web:
    Task1: n
    Task2: n 
    Task3: n
   app:
    Task1: n
    Task2: n
    Task3: n
EOF
done < menteeDetails.txt
while IFS= read -r line1
do
   line1=($line1)
   domain=${line1[1]}
   cap=${line1[2]}
   men=${line1[0]}
   if [ "$domain" = "web" ]; then
        create "web"
   elif [ "$domain" = "app" ]; then
        create "app"
   elif [ "$domain" = "sysad" ]; then
        create "sysad"
   fi
done < mentorDetails.txt
sudo touch /home/admin/mentees_domain.txt
sudo chmod 766 /home/admin/mentees_domain.txt