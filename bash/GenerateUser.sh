#!/bin/bash

if [ "$UID" -ne 0 ]; then
    echo "Only root can run this script."
    exit 1
fi

read -p "Please enter your name: " name
echo "Name: $name"

#Checks if the name already exists
if id "$name" >/dev/null 2>&1; then
    echo "User $name already exists."
    exit 1
fi

#Loops until 1 or 2 is entered
valid_input=false
while [ "$valid_input" = false ]; do
    read -p "Please enter 1 if you're a doctor or 2 if you are a patient: " num
    echo "Choice: $num"

    if [ "$num" -eq 1 ] || [ "$num" -eq 2 ]; then
        valid_input=true
    else
        echo "Invalid input. Please enter either 1 or 2."
    fi
done

touch "/home/Hospital_Server/userDetails.txt"

#---------------------------------------------------------------------------Ward

wing_admins=("wing_a" "wing_b" "wing_c")
for admin in "${wing_admins[@]}"; do
useradd -m -d "/home/$admin" "$admin" &>/dev/null
mkdir -p "/home/Hospital_Server/$admin" 
mkdir -p "/home/Hospital_Server/$admin/Patient"
mkdir -p "/home/Hospital_Server/$admin/Doctor"
touch "/home/Hospital_Server/$admin/wingConditions.txt"
done

#---------------------------------------------------------------------------Doctor

if [ "$num" -eq 1 ]; then
useradd -m -d "/home/$name" "$name"
mkdir -p "/home/$name/Doctor"
touch "/home/$name/Doctor/Available.txt"
touch "/home/$name/Doctor/Appointment.txt"

wards=("wing_a" "wing_b" "wing_c")
for wing in "${wards[@]}"; do
mkdir -p "/home/Hospital_Server/$wing/Doctor/$name"
setfacl -R -m u:$name:rwx "/home/Hospital_Server/$wing" &>/dev/null
touch "/home/Hospital_Server/$wing/Doctor/$name/inDoctor.txt"
chmod 660 "/home/Hospital_Server/$wing/Doctor/$name/inDoctor.txt"
done

echo "$name Doctor" >> "/home/Hospital_Server/userDetails.txt"

#--------------------------------------------------------------------------Patient

elif [ "$num" -eq 2 ]; then
    useradd -m -d "/home/$name" "$name"
    mkdir -p "/home/$name/Patient"
    touch "/home/$name/Patient/PatientDetails.txt"
    touch "/home/$name/Patient/Prescription.txt"

wards=("wing_a" "wing_b" "wing_c")
for wing in "${wards[@]}"; do

mkdir -p "/home/Hospital_Server/$wing/Patient/$name"
touch "/home/Hospital_Server/$wing/Patient/$name/inPatient.txt"

done	
    echo "$name Patient" >> "/home/Hospital_Server/userDetails.txt"

fi
