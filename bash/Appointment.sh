#!/bin/bash

name=$(whoami)

file="/home/Hospital_Server/userDetails.txt"
job=$(grep -i "$name" "$file" | awk '{print $2}')

if [[ "$job" == "Doctor" ]]; then
    echo "Welcomoe Dr $name"
    doctor_dir="/home/$name/Doctor"
    appointment_file="$doctor_dir/Appointment.txt"
    Available_file="$doctor_dir/Available.txt"
    datee=$(date +'%m/%d/%y')

     echo "Your existing shift timings are:"
     cat "$Available_file"
     echo ""

     read -p "Do you want to update your shift timings? (y/n): " update_choice
     
     if [ "$update_choice" == "y" ]; then

        read -p "Please enter your shift time (format: HH:MM AM/PM): " start_time
    
        timings="$start_time"
        echo "Shift Timings: $timings"

        read -p "Please enter the wing you gonna work for this slot (wing_a, wing_b, or wing_c): " wing
        echo "Wing Name: $wing"
        inDoctor_file="/home/Hospital_Server/$wing/Doctor/$name/inDoctor.txt"

        echo "$timings $wing" >> "$Available_file"
        echo "$datee $timings" >> "$inDoctor_file"

        echo "Available timings updated successfully!"

        echo "Your new shift timings are:"
        cat "$Available_file"
        echo ""

        read -p "Do you want to remove any booked appointment time slot that has been over? (y/n): " remove_choice

     if [ "$remove_choice" == "y" ]; then
        read -p "Please enter the appointment time slot you want to remove (format: HH:MM AM/PM): " remove_time

        # Removes the booked appointment time from the available slots
        sed -i "/$remove_time/d" "$doctor_dir/Available.txt"
       	echo "Appointment time slot removed successfully!"
     fi
     fi
     
fi

#-----------------------------------------------------------------------------------------------------------------
if [[ "$job" == "Patient" ]]; then
    echo "Welcome Mr/Ms $name"	
    read -p "Please enter the doctor's name you want to book an appointment with: " doctor_name
    echo "Doctor's Name: $doctor_name"

    doctor_dir="/home/$doctor_name/Doctor"
    appointment_file="$doctor_dir/Appointment.txt"
    available_file="$doctor_dir/Available.txt"
    datee=$(date +'%m/%d/%y')

    echo "Available appointment timings with $doctor_name(choose one from the slots mentioned here):"
    cat "$available_file"
    echo ""

    read -p "Please enter the desired appointment time (format: HH:MM AM/PM): " appointment_time
    read -p "Please enter the wing name where the doctor working during the slot(wing_a, wing_b, or wing_c): " wing

    inDoctor_file="/home/Hospital_Server/$wing/Doctor/$doctor_name/inDoctor.txt"
    inPatient_file="/home/Hospital_Server/$wing/Patient/$name/inPatient.txt"

      if grep -q "$appointment_time" "$available_file"; then
         if grep -q "$appointment_time" "$appointment_file"; then
            echo "Sorry, the appointment slot is already booked by another patient."
         else
            echo "Appointment booked successfully!"
            echo "$datee $appointment_time $name" >> "$inPatient_file"
	    echo "$appointment_time $wing $name" >> "$appointment_file"

	    # Remove the booked appointment time from the available slots
            sed -i "/$appointment_time/d" "$doctor_dir/Available.txt"
	 
      fi
         else
            echo "Invalid appointment time. Please choose from the available timings."
      fi
fi
