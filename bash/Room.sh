#!/bin/bash

myname=$(whoami)

 if [[ "$myname" != "wing_a" && "$myname" != "wing_b" && "$myname" != "wing_c" ]]; then
        echo "Invalid user specified. Only ward_a, ward_b, and ward_c are allowed."
        exit 1
    fi

is_wing_full() {
    local wing="$1"
    local num_patients=$(ls -1 "/home/Hospital_Server/$wing/Patient" 2>/dev/null | wc -l)
    if [ "$num_patients" -ge 10 ]; then
        return 0
    else
        return 1
    fi
}

is_max_infectious_violated() {
    local wing="$1"
    local num_infectious=$(grep -c "Infectious" "/home/Hospital_Server/$wing/wingConditions.txt" 2>/dev/null)
    if [ "$num_infectious" -ge 4 ]; then
        return 0
    else
        return 1
    fi
}

is_max_mental_violated() {
    local wing="$1"
    local num_mental=$(grep -c "Mental" "/home/Hospital_Server/$wing/wingConditions.txt" 2>/dev/null)
    if [ "$num_mental" -ge 3 ]; then
        return 0
    else
        return 1
    fi
}

is_max_physical_violated() {
    local wing="$1"
    local num_physical=$(grep -c "Physical" "/home/Hospital_Server/$wing/wingConditions.txt" 2>/dev/null)
    if [ "$num_physical" -ge 7 ]; then
        return 0
    else
        return 1
    fi
}
#-------------------------------------------------------------------------------------------------------------------------------------
assign_wing() {
    local patient="$1"
    local wing="$2"

    if ! is_wing_full "$wing" && \
        is_max_infectious_violated "$wing" && \
        is_max_mental_violated "$wing" && \
        is_max_physical_violated "$wing"
    then
        echo "$wing"
        return
    fi

    local wings=("wing_a" "wing_b" "wing_c")

    for alt_wing in "${wings[@]}"; do
        if [ "$alt_wing" != "$wing" ]; then
            # Check for critical patients waiting to be assigned to the wing
            local patient_dir="/home/Hospital_Server/$alt_wing/Patient/$patient"
            if [ -e "$patient_dir" ]; then
                local critical_file="$patient_dir/inPatient.txt"
                if grep -q "Critical" "$critical_file" && ! is_wing_full "$alt_wing"; then
                    # Reassign the oldest patient in the current wing to an alternative wing if it's full
                    local oldest_patient=$(ls -lt "/home/Hospital_Server/$alt_wing/Patient" | awk 'NR==2{print $9}')
                    rm -rf "/home/Hospital_Server/$alt_wing/Patient/$oldest_patient"
                    echo "$alt_wing"
                    return
                fi
            fi
        fi
    done

    for alt_wing in "${wings[@]}"; do
        if ! is_wing_full "$alt_wing"; then
            wing="$alt_wing"
            echo "$wing"
            return
        fi
    done

    echo "All wings are full. Cannot assign a room."
}

#-------------------------------------------------------------------------------------------------------------------------

read -p "Please enter the patient's name: " patient
echo "Patient's Name: $patient"

read -p "Please enter the doctor's appointment wing: " doctor_wing

assigned_wing=$(assign_wing "$patient" "$doctor_wing")

if [ "$assigned_wing" != "" ]; then
    echo "There are free rooms available in $assigned_wing"
    echo "Assigned Wing: $assigned_wing"
else
    echo "All wings are full. Cannot assign a room."
fi

