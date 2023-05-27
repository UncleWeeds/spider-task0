#!/bin/bash

# Alias commands
alias GenerateUser="/home/Hospital_Server/bash/GenerateUser.sh"
alias Room="/home/Hospital_Server/bash/Room.sh"
alias Permit="/home/Hospital_Server/bash/Permit.sh"
alias Appointment="/home/Hospital_Server/bash/Appointment.sh"
alias Diagnosis="/home/Hospital_Server/bash/Diagnosis.sh"

# Append alias commands to .bashrc
echo "# Custom Aliases" >> ~/.bashrc
echo "alias GenerateUser=\"/home/Hospital_Server/bash/GenerateUser.sh\"" >> ~/.bashrc
echo "alias Room=\"/home/Hospital_Server/bash/Room.sh\"" >> ~/.bashrc
echo "alias Permit=\"/home/Hospital_Server/bash/Permit.sh\"" >> ~/.bashrc
echo "alias Appointment=\"/home/Hospital_Server/bash/Appointment.sh\"" >> ~/.bashrc
echo "alias Diagnosis=\"/home/Hospital_Server/bash/Diagnosis.sh\"" >> ~/.bashrc

# Append alias commands to system-wide bashrc
echo "# Custom Aliases" >> /etc/bash.bashrc
echo "alias GenerateUser=\"/home/Hospital_Server/bash/GenerateUser.sh\"" >> /etc/bash.bashrc
echo "alias Room=\"/home/Hospital_Server/bash/Room.sh\"" >> /etc/bash.bashrc
echo "alias Permit=\"/home/Hospital_Server/bash/Permit.sh\"" >> /etc/bash.bashrc
echo "alias Appointment=\"/home/Hospital_Server/bash/Appointment.sh\"" >> /etc/bash.bashrc
echo "alias Diagnosis=\"/home/Hospital_Server/bash/Diagnosis.sh\"" >> /etc/bash.bashrc

# Reload .bashrc
source ~/.bashrc

echo "Alias commands have been added to .bashrc file."

