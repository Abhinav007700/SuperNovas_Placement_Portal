import mimetypes
from flask import Flask, render_template, request, session, redirect, url_for, send_file
from flaskext.mysql import MySQL
from io import BytesIO
import pymysql
import re
import base64
app = Flask(__name__)
app.secret_key = 'supernovas'
mysql = MySQL()
# MySQL config
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'root'
app.config['MYSQL_DATABASE_DB'] = 'placement'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)


@app.route('/')
def home():
    if 'loggedin' in session:
        if 'rollno' in session:
            return redirect(url_for('newhome'))
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    return render_template('home.html')


@app.route('/home')
def home1():
    if 'loggedin' in session:
        if 'rollno' in session:
            return redirect(url_for('newhome'))
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    return render_template('home.html')


@app.route('/forgot')
def forgot():
    if 'loggedin' in session:
        if 'rollno' in session:
            return redirect(url_for('newhome'))
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    return render_template('forgot.html')


@app.route('/newhome')
def newhome():
    if 'loggedin' in session:
        if 'rollno' in session:
            return render_template('newhome.html', name=session['name'])
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    else:
        return redirect(url_for('login'))


@app.route('/rnewhome')
def rnewhome():
    if 'loggedin' in session:
        if 'rollno' in session:
            return redirect(url_for('newhome'))
        elif 'email' in session:
            return render_template('rnewhome.html', name=session['name'])
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    else:
        return redirect(url_for('rlogin'))


@app.route('/login', methods=['GET', 'POST'])
def login():
    if 'loggedin' in session:
        if 'rollno' in session:
            return redirect(url_for('newhome'))
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    conn = mysql.connect()
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    msg = ''
    if request.method == 'POST' and 'rollno' in request.form and 'password' in request.form:
        rollno = request.form['rollno']
        password = request.form['password']
        if not re.fullmatch(r'^[0-9]{9}$', rollno):
            msg = 'Wrong Rollno format!'
            return render_template('login.html', msg=msg)
        cursor.execute(
            'SELECT * FROM login WHERE rollno = %s AND password = %s', (int(rollno), password))
        account = cursor.fetchone()
        if account:
            session['loggedin'] = True
            session['rollno'] = account['rollno']
            session['name'] = account['name']
            return redirect(url_for('newhome'))
        else:
            msg = 'Incorrect rollnumber/password!'
    return render_template('login.html', msg=msg)


@app.route('/alogin', methods=['GET', 'POST'])
def alogin():
    if 'loggedin' in session:
        if 'rollno' in session:
            return redirect(url_for('newhome'))
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    conn = mysql.connect()
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    msg = ''
    if request.method == 'POST' and 'aemail' in request.form and 'password' in request.form:
        email = request.form['aemail']
        password = request.form['password']
        if not re.fullmatch(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$', email):
            msg = 'Wrong Email format!'
            return render_template('login.html', msg=msg)
        cursor.execute(
            'SELECT * FROM alogin WHERE email = %s AND password = %s', (email, password))
        account = cursor.fetchone()
        if account:
            session['loggedin'] = True
            session['aemail'] = account['email']
            return redirect(url_for('admin'))
        else:
            msg = 'Incorrect rollnumber/password!'
    return render_template('alogin.html', msg=msg)


@app.route('/rlogin', methods=['GET', 'POST'])
def rlogin():
    if 'loggedin' in session:
        if 'rollno' in session:
            return redirect(url_for('newhome'))
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    conn = mysql.connect()
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    msg = ''
    if request.method == 'POST' and 'email' in request.form and 'password' in request.form:
        email = request.form['email']
        password = request.form['password']
        if not re.fullmatch(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$', email):
            msg = 'Wrong Email format!'
            return render_template('rlogin.html', msg=msg)
        cursor.execute(
            'SELECT * FROM rlogin WHERE email = %s AND password = %s', (email, password))
        account = cursor.fetchone()
        if account:
            session['loggedin'] = True
            session['email'] = account['email']
            session['name'] = account['name']
            return redirect(url_for('rnewhome'))
        else:
            msg = 'Incorrect rollnumber/password!'
    return render_template('rlogin.html')


@app.route('/admin')
def admin():
    if 'loggedin' in session:
        if 'rollno' in session:
            return redirect(url_for('newhome'))
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            return render_template('admin.html')
    else:
        return redirect(url_for('alogin'))


@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if 'loggedin' in session:
        if 'rollno' in session:
            return redirect(url_for('newhome'))
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            conn = mysql.connect()
            cursor = conn.cursor(pymysql.cursors.DictCursor)
            msg = ''
            if request.method == 'POST' and 'rollno' in request.form and 'password' in request.form and 'name' in request.form and 'confirmpwd' in request.form:
                name = request.form['name']
                rollno = request.form['rollno']
                password = request.form['password']
                confirmpwd = request.form['confirmpwd']
                cursor.execute(
                    'SELECT * FROM login WHERE rollno = %s', (int(rollno)))
                account = cursor.fetchone()
                if account:
                    msg = 'Acount already exists!'
                elif not re.fullmatch(r'^[0-9]{9}$', rollno):
                    msg = 'Roll Number must be 9 digits!'
                elif not re.fullmatch(r'^[A-za-z]+$', name):
                    msg = 'Name should only contain characters!'
                elif not re.fullmatch(password, confirmpwd):
                    msg = 'Password and Confirm Password does not match!'
                else:
                    cursor.execute(
                        'INSERT INTO login VALUES (%s,%s,%s)',
                        (int(rollno), name, password))
                    conn.commit()
                    msg = 'Successfully Signed Up'
        return render_template('signup.html', msg=msg)
    else:
        return redirect(url_for('alogin'))


@app.route('/rsignup', methods=['GET', 'POST'])
def rsignup():
    if 'loggedin' in session:
        if 'rollno' in session:
            return redirect(url_for('newhome'))
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            conn = mysql.connect()
            cursor = conn.cursor(pymysql.cursors.DictCursor)
            msg = ''
            if request.method == 'POST' and 'email' in request.form and 'password' in request.form and 'name' in request.form and 'confirmpwd' in request.form:
                name = request.form['name']
                email = request.form['email']
                password = request.form['password']
                confirmpwd = request.form['confirmpwd']
                cursor.execute(
                    'SELECT * FROM rlogin WHERE email = %s', (email))
                account = cursor.fetchone()
                if account:
                    msg = 'Acount already exists!'
                elif not re.fullmatch(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$', email):
                    msg = 'Email format is wrong!'
                elif not re.fullmatch(r'^[A-za-z]+$', name):
                    msg = 'Name should only contain characters!'
                elif not re.fullmatch(password, confirmpwd):
                    msg = 'Password and Confirm Password does not match!'
                else:
                    cursor.execute(
                        'INSERT INTO rlogin VALUES (%s,%s,%s)',
                        (email, name, password))
                    conn.commit()
                    msg = 'Successfully Signed Up'
        return render_template('rsignup.html', msg=msg)
    else:
        return redirect(url_for('alogin'))


@app.route('/contact')
def contact():
    if 'loggedin' in session:
        if 'rollno' in session:
            return redirect(url_for('newhome'))
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    return render_template('contact.html')


@app.route('/settings')
def settings():
    if 'loggedin' in session:
        if 'rollno' in session:
            return render_template('settings.html')
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    else:
        return redirect(url_for('login'))


@app.route('/logout')
def logout():
    session.pop('loggedin', None)
    session.pop('rollno', None)
    session.pop('name', None)
    return redirect(url_for('login'))


@app.route('/rlogout')
def rlogout():
    session.pop('loggedin', None)
    session.pop('email', None)
    session.pop('name', None)
    return redirect(url_for('rlogin'))


@app.route('/alogout')
def alogout():
    session.pop('loggedin', None)
    session.pop('aemail', None)
    return redirect(url_for('alogin'))


@app.route('/profile', methods=['GET', 'POST'])
def profile():
    if 'loggedin' in session:
        if 'rollno' in session:
            conn = mysql.connect()
            cursor = conn.cursor(pymysql.cursors.DictCursor)
            cursor.execute(
                'SELECT * FROM data WHERE rollno = %s', (int(session['rollno'])))
            account = cursor.fetchone()
            if account:
                return redirect(url_for('profiledone'))
            else:
                msg = ''
                if request.method == 'POST' and 'cgpa' in request.form and 'email' in request.form and 'dept' in request.form and 'degree' in request.form and 'year' in request.form and 'date' in request.form:
                    email = request.form['email']
                    dept = request.form['dept']
                    degree = request.form['degree']
                    year = request.form['year']
                    cgpa = request.form['cgpa']
                    date = request.form['date']
                    cursor.execute(
                        'SELECT * FROM data WHERE rollno = %s', (int(session['rollno'])))
                    account = cursor.fetchone()
                    if account:
                        return redirect(url_for('profiledone'))
                    elif not re.fullmatch(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$', email):
                        msg = 'Email format is wrong!'
                    elif not re.fullmatch(r'^[a-zA-Z]+$', dept):
                        msg = 'Department should only contain characters!'
                    elif not re.fullmatch(r'^[a-zA-Z]+$', degree):
                        msg = 'Degree should only contain characters!'
                    elif not re.fullmatch(r'^[0-9]{4}$', year):
                        msg = 'Year should have only 4 digits!'
                    else:
                        cursor.execute(
                            'INSERT INTO data VALUES (%s,%s,%s,%s,%s,%s,%s)',
                            (int(session['rollno']), email, dept, degree, int(year), date, float(cgpa)))
                        conn.commit()
                        msg = 'Successfully Data Stored'
                return render_template('profile.html', msg=msg)
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    else:
        return redirect(url_for('login'))


@app.route('/profiledone')
def profiledone():
    if 'loggedin' in session:
        if 'rollno' in session:
            conn = mysql.connect()
            cursor = conn.cursor(pymysql.cursors.DictCursor)
            cursor.execute(
                'SELECT * FROM data WHERE rollno = %s', (int(session['rollno'])))
            account = cursor.fetchone()
            return render_template('profiledone.html', data=account)
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    else:
        return redirect(url_for('login'))


@app.route('/newcontact')
def newcontact():
    if 'loggedin' in session:
        if 'rollno' in session:
            return render_template('newcontact.html')
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    else:
        return redirect(url_for('login'))


@app.route('/ufile', methods=['GET', 'POST'])
def ufile():
    msg = ''
    conn = mysql.connect()
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    if 'loggedin' in session:
        if 'rollno' in session:
            cursor.execute(
                'SELECT * FROM files WHERE rollno = %s', (int(session['rollno'])))
            account = cursor.fetchone()
            if account:
                return redirect(url_for('doneupload'))
            else:
                if request.method == 'POST':
                    if 'file' not in request.files:
                        msg = 'no file'
                    else:
                        file = request.files['file']
                        f = file.read()
                        f = base64.b64encode(f)
                        cursor.execute('INSERT INTO files VALUES(%s,%s)',
                                       (int(session['rollno']), f))
                        conn.commit()
                        msg = 'File successfully stored'
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            return redirect(url_for('admin'))

    else:
        return redirect(url_for('login'))
    return render_template('ufile.html', msg=msg)


@app.route('/doneupload')
def doneupload():
    if 'loggedin' in session:
        if 'rollno' in session:
            return render_template('doneupload.html')
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    else:
        return redirect(url_for('login'))


@app.route('/rnewcontact')
def rnewcontact():
    if 'loggedin' in session:
        if 'rollno' in session:
            return redirect(url_for('newhome'))
        elif 'email' in session:
            return render_template('rnewcontact.html')
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    else:
        return redirect(url_for('rlogin'))


@app.route('/rsettings')
def rsettings():
    if 'loggedin' in session:
        if 'rollno' in session:
            return redirect(url_for('newhome'))
        elif 'email' in session:
            return render_template('rsettings.html')
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    else:
        return redirect(url_for('rlogin'))


@app.route('/applications')
def applications():
    if 'loggedin' in session:
        if 'rollno' in session:
            return redirect(url_for('newhome'))
        elif 'email' in session:
            conn = mysql.connect()
            cursor = conn.cursor(pymysql.cursors.DictCursor)
            msg = ''
            cursor.execute(
                'SELECT name, cgpa, data.rollno from data, login ,files where data.rollno=login.rollno and data.rollno=files.rollno')
            datas = cursor.fetchall()
            return render_template('applications.html', data=datas)
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    else:
        return redirect(url_for('rlogin'))


@app.route('/<rollno>')
def fileshow(rollno):
    if 'loggedin' in session:
        if 'rollno' in session:
            return redirect(url_for('newhome'))
        elif 'email' in session:
            conn = mysql.connect()
            cursor = conn.cursor(pymysql.cursors.DictCursor)
            msg = ''
            cursor.execute('SELECT pdf from files where rollno=%s', rollno)
            file = cursor.fetchone()
            f = file['pdf']
            f = base64.b64decode(f)
            return send_file(BytesIO(f), mimetype="application/pdf", conditional=True)
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    else:
        return redirect(url_for('rlogin'))


@app.route('/edit')
def edit():
    if 'loggedin' in session:
        if 'rollno' in session:
            return render_template('edit.html')
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    else:
        return redirect(url_for('login'))


@app.route('/change', methods=['GET', 'POST'])
def change():
    if 'loggedin' in session:
        if 'rollno' in session:
            conn = mysql.connect()
            cursor = conn.cursor(pymysql.cursors.DictCursor)
            msg = ''
            if request.method == 'POST' and 'password' in request.form and 'password1' in request.form and 'password2' in request.form:
                password = request.form['password']
                password1 = request.form['password1']
                password2 = request.form['password2']
                cursor.execute(
                    'SELECT password from login where rollno=%s', (session['rollno']))
                account = cursor.fetchone()
                if account['password'] != password:
                    msg = 'Wrong current password!'
                elif not re.fullmatch(password1, password2):
                    msg = 'Re-enter password is not same'
                else:
                    cursor.execute(
                        'UPDATE login SET password=%s WHERE rollno = %s', (password1, int(session['rollno'])))
                    conn.commit()
                    msg = 'Successfully changed'
                return render_template('change.html', msg=msg)
            return render_template('change.html', msg=msg)
        elif 'email' in session:
            return redirect(url_for('rnewhome'))
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    else:
        return redirect(url_for('login'))


@app.route('/rchange', methods=['GET', 'POST'])
def rchange():
    if 'loggedin' in session:
        if 'rollno' in session:
            return redirect(url_for('newhome'))
        elif 'email' in session:
            conn = mysql.connect()
            cursor = conn.cursor(pymysql.cursors.DictCursor)
            msg = ''
            if request.method == 'POST' and 'password' in request.form and 'password1' in request.form and 'password2' in request.form:
                password = request.form['password']
                password1 = request.form['password1']
                password2 = request.form['password2']
                cursor.execute(
                    'SELECT password from rlogin where email=%s', (session['email']))
                account = cursor.fetchone()
                if account['password'] != password:
                    msg = 'Wrong current password!'
                elif not re.fullmatch(password1, password2):
                    msg = 'Re-enter password is not same'
                else:
                    cursor.execute(
                        'UPDATE rlogin SET password=%s WHERE email = %s', (password1, session['email']))
                    conn.commit()
                    msg = 'Successfully changed'
                return render_template('rchange.html', msg=msg)
            return render_template('rchange.html', msg=msg)
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    else:
        return redirect(url_for('rlogin'))


@app.route('/candidates')
def candidates():
    if 'loggedin' in session:
        if 'rollno' in session:
            return redirect(url_for('newhome'))
        elif 'email' in session:
            return render_template('candidate.html')
        elif 'aemail' in session:
            return redirect(url_for('admin'))
    else:
        return redirect(url_for('rlogin'))
