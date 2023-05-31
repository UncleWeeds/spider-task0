#Spider-Task0

If you're interested in exploring the scripts, you can follow the commands below (or feel free to modify them as per your requirements 🦖):

Download the Docker image using the command: docker build -t "YourImageName" .

Replace "YourImageName" with a name of your choice.
Once the image is downloaded, run it using the command: docker container run -d -p 5000:5000 "YourImageName"

Again, replace "YourImageName" with the name you provided in the previous step.
You can now access the scripts on your local host. To do this, open a web browser and navigate to localhost:5000/bin/"ScriptName".

Replace "ScriptName" with the name of the script you wish to check.
Additionally, if you want to run the scripts within the Docker container, you can open a terminal inside the container using the command:
docker exec -it "ContainerID" /bin/bash

To find the ContainerID, you can use either docker ps or docker container ls command.
Please note that this command will only work if the container is already running.
Once inside the container, navigate to the directory /home/Hospital_Server/bash using the cd command.

This is where the scripts are located.
To run a script, use the ./"ScriptName" command.

Replace "ScriptName" with the name of the script you want to execute.
We hope you find this information helpful! Should you have any further queries or require assistance, feel free to ask.
