# spider-task0(DevOps)

Hospital File System
Problem Statement:
Rithvik, a newly appointed system administrator, has joined BHEL Hospital with the
responsibility of revamping its file system to enhance productivity. As part of this
assignment, Rithvik is tasked with recreating the functionality of the old system while
incorporating modern practices.

Task 1:
1. Generate User:
● The first script will generate three kinds of users, doctors, patients, and wing
admins. Each user will have their own home directory.
● Doctors will have Available.txt and Appointment.txt files and the Patients will
have PatientDetails.txt and Prescription.txt within their own home directories.
Doctors and Patients should also be able to write their slots and symptoms into
Available.txt and PatientDetails.txt respectively, during user creation
● There are 3 wing admins and the wing’s name is the name of the home directory.
There should be a Patient and a Doctor sub-directory for each Wing and files
named InPatient.txt and inDoctor.txt for each unique user.

2. Permit:
● Patient should have read access to all the files under their own name and write
access to PatientDetails.txt and Appointment.txt
● Doctor should also have read access to all the files under their own name and
write access to Prescription.txt, Patient Details, and Available.txt
● Wing Admin should have read and write access to all files within their own wing

3. Appointment:
● Doctors can use Appointment to fill up their shift timings in Available.txt.
Depending on the wing, their timings must also be reflected in the inDoctor.txt.
He should be able to add or update his timings accordingly
● Patients should be able to book an appointment with a doctor based on their
availability, and their chosen timings must be reflected in Appointment.txt and
inPatient.txt. The patient should not be able to overwrite any patients who have
already booked a slot


Task 2:
4. Diagnosis:
● Doctor should enter the patient diagnosis [infectious, mental, physical, critical]
along with the date and time into PateintDetails.txt
● Doctor must also give a prescription that is divided into 3 three parts, morning
afternoon, and dinner, with, the name of the medicine, which goes into the
Prescription.txt

5. Room:
Wing admin should allot rooms to patients based on the following parameters:
● By default, Patients go to the wing where their doctor’s appointment is unless it
violates one of the below conditions
● Critical people will always go to the wing of the doctor’s appointment. If one of
the below conditions gets violated, the oldest patient admitted moves to a
different wing.
● Each wing should have a max capacity of 10 people
● Each wing can accommodate a max of 4 infectious people 3 mental 7 physical
● One wing can’t have more than two infectious people with a mental person


Task3:
● Create a web application to display the file contents. You may use Flask/node/express to
implement it.
● Dockerize the entire application along with the bash scripts
Format:NOTE:
● All scripts should be a runnable .sh script and usage of aliases is permitted
● Usage of Excel tables or database are not allowed for the above tasks
● Brownie points will also be given if the appointment script can also remove the time slot
after the shift is over
● Tasks 1 and 2 are required to complete the task.
● Completing Task 3 also gives you brownie points
