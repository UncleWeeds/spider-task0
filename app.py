from flask import Flask, render_template, request

app = Flask(__name__)

def get_bash_file(filename):
    with open(filename, 'r') as file:
        content = file.read()
    return render_template('details.html', content=content)

@app.route('/bash/GenerateUser.sh')
def generate_user():
    return get_bash_file('bash/GenerateUser.sh')

@app.route('/bash/Room.sh')
def room():
    return get_bash_file('bash/Room.sh')

@app.route('/bash/Appointment.sh')
def appointment():
    return get_bash_file('bash/Appointment.sh')

@app.route('/bash/Diagnosis.sh')
def diagnosis():
    return get_bash_file('bash/Diagnosis.sh')

@app.route('/bash/Permit.sh')
def permit():
    return get_bash_file('bash/Permit.sh')

@app.route('/bash/add_aliases.sh')
def add_aliases():
    return get_bash_file('bash/add_aliases.sh')



if __name__ == '__main__':
    app.run(host='0.0.0.0')

