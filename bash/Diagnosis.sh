#!/bin/bash

name=$(whoami)

file="/home/Hospital_Server/userDetails.txt"
job=$(grep -i "$name" "$file" | awk '{print $2}')
ward="/home/$name/Doctor/Appointment.txt"

if [[ "$job" == "Doctor" ]]; then

   read -p "Please enter the patient's name: " pname
   echo "Patient's Name: $pname"

   wardd=$(grep -i "$pname" "$ward" | awk '{print $3}')
   warddd="/home/Hospital_Server/$wardd/wingConditions.txt"
   patient_dir="/home/$pname"
   Details_file="$patient_dir/Patient/PatientDetails.txt"
   prescription_file="$patient_dir/Patient/Prescription.txt"

   read -p "Is the patient diagnosed with an infectious condition? (Enter 'Infectious' or '-'): " diagnosis
   read -p "Is the patient diagnosed with a mental condition? (Enter 'Mental' or '-'): " diagnosis1
   read -p "Is the patient diagnosed with a physical condition? (Enter 'Physical' or '-'): " diagnosis2
   read -p "Is the patient diagnosed with a critical condition? (Enter 'Critical' or '-'): " diagnosis3
   datetime=$(date +"%m/%d/%Y")

   echo "$datetime  $diagnosis  $diagnosis1  $diagnosis2  $diagnosis3" >> "$Details_file"
   echo "$pname $diagnosis  $diagnosis1  $diagnosis2  $diagnosis3">> "$warddd"
   echo "Patient's diagnosis has been recorded successfully!"
#-------------------------------------------------------------------------------------------------------------
   echo "Please provide the prescription for the patient:"
   read -p "Morning Prescription: " morning_prescription
   read -p "Afternoon Prescription: " afternoon_prescription
   read -p "Dinner Prescription: " dinner_prescription

   echo "Date: $datetime" >> "$prescription_file"
   echo "Morning: $morning_prescription ,Afternoon: $afternoon_prescription ,Dinner: $dinner_prescription" >> "$prescription_file"
   echo "Prescription has been recorded successfully!"

else
   echo "Only Doctors can use this script"
fi
