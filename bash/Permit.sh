#!/bin/bash

if [[ "${UID}" -ne 0 ]]; then
   echo "Please use this as an Admin my friend" >&2
   exit 1
fi

declare -a wing_admins=("wing_a" "wing_b" "wing_c")

for admin in "${wing_admins[@]}"; do
    chown -R "$admin:$admin" "/home/Hospital_Server/$admin"
    chmod -R 700 "/home/Hospital_Server/$admin"
done

while IFS= read -r line; do
username=$(echo "$line" | awk '{print $1}')
who=$(echo "$line" | awk '{print $2}')

#-------------------------------------------------------------------------------------------------Patient

   if [ "$who" = "Patient" ]; then
      chown -R "$username:$username" "/home/$username/Patient"
    
          while IFS= read -r line; do
               username1=$(echo "$line" | awk '{print $1}')
               setfacl  -m u:$username:rw "/home/$username1/Doctor/Appointment.txt" &>/dev/null
               setfacl  -m u:$username:rw "/home/$username1/Doctor/Available.txt" &>/dev/null
               setfacl  -m u:$username:rwx "/home/$username1" &>/dev/null

          done < /home/Hospital_Server/userDetails.txt

          for admin in "${wing_admins[@]}"; do
          setfacl -R -m u:$username:rwx "/home/Hospital_Server/$admin" &>/dev/null

          done

#-------------------------------------------------------------------------------------------------Doctor

    elif [ "$who" = "Doctor" ]; then
       chown -R "$username:$username" "/home/$username/Doctor"
       chmod 600 "/home/$username/Doctor/Available.txt"

            while IFS= read -r line; do
                  username1=$(echo "$line" | awk '{print $1}')
                  setfacl -R -m u:$username:rwx "/home/$username1" &>/dev/null
                  setfacl -R -m u:$username:rwx "/home/$username1/Patient/PatientDetails.txt" &>/dev/null
                  setfacl -R -m u:$username:rwx "/home/$username1/Patient/Prescription.txt" &>/dev/null
             done < /home/Hospital_Server/userDetails.txt

             for admin in "${wing_admins[@]}"; do
                  setfacl -R -m u:$username:rwx "/home/Hospital_Server/$admin" &>/dev/null
                  setfacl -R -m u:$username:rwx "/home/Hospital_Server/$admin/wingConditions.txt" &>/dev/null

             done
    fi    

done < /home/Hospital_Server/userDetails.txt

