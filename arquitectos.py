from flask import Flask, render_template, url_for, request, redirect, flash, session
from flask_mysqldb import MySQL
from flask_login import LoginManager,login_user,logout_user
from flask_mail import Mail, Message
from werkzeug.security import generate_password_hash
import datetime
import os
import uuid
from config import config
from models.ModelUser import ModelUser
from models.entities.User import User
#import openai
from flask import Flask, request, jsonify
#from flask_cors import CORS




arquitectosApp = Flask(__name__)
#Python AnyWhere
arquitectosApp.config.from_object(config['development'])
arquitectosApp.config.from_object(config['mail'])
db             = MySQL(arquitectosApp)
mail           = Mail(arquitectosApp)
adminSesion = LoginManager(arquitectosApp)
#CORS(arquitectosApp)  # Habilita CORS para permitir peticiones desde el navegador

@adminSesion.user_loader
def cargarUsuario(id):
    return ModelUser.get_by_id(db, id)

def obtener_proyectos():
    cursor = db.connection.cursor()
    cursor.execute("SELECT * FROM proyectos")
    proyectos = cursor.fetchall()
    cursor.close()
    return proyectos

def obtener_proyectosext():
    cursor = db.connection.cursor()
    cursor.execute("SELECT * FROM proyectosext")
    proyectosext = cursor.fetchall()
    cursor.close()
    return proyectosext

def obtener_proyectosjar():
    cursor = db.connection.cursor()
    cursor.execute("SELECT * FROM proyectosjar")
    proyectosjar = cursor.fetchall()
    cursor.close()
    return proyectosjar

@arquitectosApp.route('/')
def home():
    '''if session['NombreU'] == 'A':
        if session['PerfilU'] == 'A':
            return render_template('admin.html')
        else:
            return render_template('user.html')'''
    return render_template('home.html')

@arquitectosApp.route('/signup', methods=['GET', 'POST'])
def signup():  
    if request.method == 'POST':
        nombre = request.form['nombre']
        correo = request.form['correo']
        clave = request.form['clave']
        claveCifrada = generate_password_hash(clave)
        fechareg = datetime.datetime.now()

        reUsuario = db.connection.cursor()
        reUsuario.execute("INSERT INTO usuario (nombre, correo, clave, fechareg) VALUES (%s, %s, %s, %s)", (nombre, correo, claveCifrada, fechareg))
        db.connection.commit()

        
        img_path = os.path.join(os.path.dirname(__file__), 'static', 'IMG', 'EclipseHome.png')

        
        with open(img_path, 'rb') as f:
            img_data = f.read()


        msg = Message(subject='Su registro se realizó con éxito.', recipients=[correo])
        msg.attach('EclipseHome.png', 'image/png', img_data)

        
        msg.html = render_template('mail.html', nombre=nombre)
        mail.send(msg)

        return render_template('home.html')
    else:
        return render_template('signup.html')


@arquitectosApp.route('/signin', methods=['GET','POST'])
def signin():
    if request.method == 'POST' :
        usuario = User(0, None, request.form['correo'],request.form['clave'], None, None)
        usuarioAutenticado = ModelUser.signin(db, usuario)
        if usuarioAutenticado is not None:
            login_user(usuarioAutenticado)
            session['NombreU'] = usuarioAutenticado.nombre
            session['PerfilU'] = usuarioAutenticado.perfil
            if usuarioAutenticado.clave:
                if usuarioAutenticado.perfil == 'A':
                    return redirect(url_for('admin'))
                else:
                    return redirect(url_for('user'))
            else:
                flash('contraseña incorrecta')
                return redirect(request.url)
        else:
            flash('usuario inexistente')
            return redirect(request.url)
    else:
        return render_template('signin.html')

@arquitectosApp.route('/sUsuario',methods=['GET','POST'])
def sUsuario():
    selUsuario = db.connection.cursor()
    selUsuario.execute("SELECT * FROM usuario")
    u = selUsuario.fetchall()
    selUsuario.close()
    return render_template('usuario.html', usuarios = u)

@arquitectosApp.route('/iUsuario',methods=['GET','POST'])
def iUsuario():
    nombre = request.form['nombre']
    correo = request.form['correo']
    clave = request.form['clave']
    claveCifrada = generate_password_hash(clave)
    fechareg = datetime.datetime.now()
    perfil = request.form['perfil']

    crearUsuario = db.connection.cursor()
    crearUsuario.execute("INSERT INTO usuario (nombre, correo, clave, fechareg, perfil) VALUES (%s, %s, %s, %s, %s)", (nombre, correo, claveCifrada, fechareg, perfil))
    db.connection.commit()
    flash('Usuario Creado')
    return redirect('/sUsuario')

@arquitectosApp.route('/uUsuario/<int:id>',methods=['GET','POST'])
def uUsuario(id):
    nombre = request.form['nombre']
    correo = request.form['correo']
    clave = request.form['clave']
    claveCifrada = generate_password_hash(clave)
    fechareg = datetime.datetime.now()
    perfil = request.form['perfil']

    editarUsuario = db.connection.cursor()
    editarUsuario.execute("UPDATE usuario SET nombre=%s, correo=%s, clave=%s, fechareg=%s, perfil=%s WHERE id=%s",(nombre, correo, claveCifrada, fechareg, perfil, id))
    db.connection.commit()
    flash('Usuario Editado')
    return redirect('/sUsuario')

@arquitectosApp.route('/dUsuario/<int:id>',methods=['GET','POST'])
def dUsuario(id):
    eliminarUsuario = db.connection.cursor()
    eliminarUsuario.execute("DELETE FROM usuario WHERE id=%s",(id,))
    db.connection.commit()
    flash('User Delete')
    return redirect('/sUsuario')

@arquitectosApp.route('/signout',methods=['GET','POST'])
def signout():
    logout_user()
    return render_template('home.html')

@arquitectosApp.route('/admin')
def admin():
    return render_template('admin.html')

@arquitectosApp.route('/user')
def user():
    return render_template('user.html')

@arquitectosApp.route('/interiores')
def interiores():
    proyectos = obtener_proyectos()
    return render_template('interiores.html', proyectos = proyectos)

@arquitectosApp.route('/exteriores')
def exteriores():
    proyectosext = obtener_proyectosext()
    return render_template('exteriores.html', proyectosext = proyectosext)

@arquitectosApp.route('/jardines')
def jardines():
    proyectosjar = obtener_proyectosjar()
    return render_template('jardines.html', proyectosjar = proyectosjar)

@arquitectosApp.route('/sProyecto', methods = ['GET', 'POST'])
def sProyecto():
    selProyecto = db.connection.cursor()
    selProyecto.execute("SELECT * FROM proyectos")
    p = selProyecto.fetchall()
    selProyecto.close()
    return render_template('proyectos.html', proyectos = p)

@arquitectosApp.route('/iProyecto', methods=['POST'])
def iProyecto():
    
    nombre = request.form['nombre']
    descripcion = request.form['descripcion']
    tipo_proyecto = request.form['tipo_proyecto']
    imagen = request.files.get('imagen')

    if imagen:
        imagen_filename = imagen.filename
        imagen_path = f"static/IMG/{imagen_filename}"
        imagen.save(imagen_path)
        
    else:
        imagen_filename = None
    
    cursor = db.connection.cursor()
    cursor.execute("INSERT INTO proyectos (nombre, descripcion, tipo_proyecto, imagen) VALUES (%s, %s, %s, %s)", (nombre, descripcion, tipo_proyecto, imagen_filename))
    db.connection.commit()
    flash('Proyecto Creado')
    return redirect('/sProyecto')

@arquitectosApp.route('/uProyecto/<int:id>', methods=['GET', 'POST'])
def uProyecto(id):
        nombre = request.form['nombre']
        descripcion = request.form['descripcion']
        tipo_proyecto = request.form['tipo_proyecto']
        imagen = request.files.get('imagen')

        cursor = db.connection.cursor()

        if imagen:
            imagen_filename = imagen.filename
            imagen_path = f"static/IMG/{imagen_filename}"
            imagen.save(imagen_path)
        else:
            cursor.execute("SELECT imagen FROM proyectos WHERE idproyectos = %s", (id,))
            imagen_filename = cursor.fetchone()[0]

        cursor.execute("UPDATE proyectos SET nombre = %s, descripcion = %s, tipo_proyecto = %s, imagen = %s WHERE idproyectos = %s", (nombre, descripcion, tipo_proyecto, imagen_filename, id))
        db.connection.commit()
        flash('Proyecto Editado')
        return redirect('/sProyecto') 

@arquitectosApp.route('/dProyecto/<int:id>',methods=['GET','POST'])
def dProyecto(id):
    eliminarProyecto = db.connection.cursor()
    eliminarProyecto.execute("DELETE FROM proyectos WHERE idproyectos=%s",(id,))
    db.connection.commit()
    flash('Proyect Delete')
    return redirect('/sProyecto')

@arquitectosApp.route('/sProyectoE', methods = ['GET', 'POST'])
def sProyectoE():
    selProyectoE = db.connection.cursor()
    selProyectoE.execute("SELECT * FROM proyectosext")
    pext = selProyectoE.fetchall()
    selProyectoE.close()
    return render_template('proyectosext.html', proyectosext=pext)

@arquitectosApp.route('/iProyectoE', methods=['POST'])
def iProyectoE():
    
    nombre = request.form['nombre']
    descripcion = request.form['descripcion']
    tipo_proyecto = request.form['tipo_proyecto']
    imagen = request.files.get('imagen')

    if imagen:
        imagen_filename = imagen.filename
        imagen_path = f"static/IMG/{imagen_filename}"
        imagen.save(imagen_path)
        
    else:
        imagen_filename = None
    
    cursor = db.connection.cursor()
    cursor.execute("INSERT INTO proyectosext (nombre, descripcion, tipo_proyecto, imagen) VALUES (%s, %s, %s, %s)", (nombre, descripcion, tipo_proyecto, imagen_filename))
    db.connection.commit()
    flash('Proyecto Creado')
    return redirect('/sProyectoE')

@arquitectosApp.route('/uProyectoE/<int:id>', methods=['GET', 'POST'])
def uProyectoE(id):
        nombre = request.form['nombre']
        descripcion = request.form['descripcion']
        tipo_proyecto = request.form['tipo_proyecto']
        imagen = request.files.get('imagen')

        cursor = db.connection.cursor()

        if imagen:
            imagen_filename = imagen.filename
            imagen_path = f"static/IMG/{imagen_filename}"
            imagen.save(imagen_path)
        else:
            cursor.execute("SELECT imagen FROM proyectosext WHERE idproyectosext = %s", (id,))
            imagen_filename = cursor.fetchone()[0]

        cursor.execute("UPDATE proyectosext SET nombre = %s, descripcion = %s, tipo_proyecto = %s, imagen = %s WHERE idproyectosext = %s", (nombre, descripcion, tipo_proyecto, imagen_filename, id))
        db.connection.commit()
        flash('Proyecto Editado')
        return redirect('/sProyectoE') 

@arquitectosApp.route('/dProyectoE/<int:id>',methods=['GET','POST'])
def dProyectoE(id):
    eliminarProyecto = db.connection.cursor()
    eliminarProyecto.execute("DELETE FROM proyectosext WHERE idproyectosext=%s",(id,))
    db.connection.commit()
    flash('Proyect Delete')
    return redirect('/sProyectoE')

@arquitectosApp.route('/sProyectoJ', methods = ['GET', 'POST'])
def sProyectoJ():
    selProyectoJ = db.connection.cursor()
    selProyectoJ.execute("SELECT * FROM proyectosjar")
    pjar = selProyectoJ.fetchall()
    selProyectoJ.close()
    return render_template('proyectosjar.html', proyectosjar=pjar)

@arquitectosApp.route('/iProyectoJ', methods=['POST'])
def iProyectoJ():
    
    nombre = request.form['nombre']
    descripcion = request.form['descripcion']
    tipo_proyecto = request.form['tipo_proyecto']
    imagen = request.files.get('imagen')

    if imagen:
        imagen_filename = imagen.filename
        imagen_path = f"static/IMG/{imagen_filename}"
        imagen.save(imagen_path)
        
    else:
        imagen_filename = None
    
    cursor = db.connection.cursor()
    cursor.execute("INSERT INTO proyectosjar (nombre, descripcion, tipo_proyecto, imagen) VALUES (%s, %s, %s, %s)", (nombre, descripcion, tipo_proyecto, imagen_filename))
    db.connection.commit()
    flash('Proyecto Creado')
    return redirect('/sProyectoJ')

@arquitectosApp.route('/uProyectoJ/<int:id>', methods=['GET', 'POST'])
def uProyectoJ(id):
        nombre = request.form['nombre']
        descripcion = request.form['descripcion']
        tipo_proyecto = request.form['tipo_proyecto']
        imagen = request.files.get('imagen')

        cursor = db.connection.cursor()

        if imagen:
            imagen_filename = imagen.filename
            imagen_path = f"static/IMG/{imagen_filename}"
            imagen.save(imagen_path)
        else:
            cursor.execute("SELECT imagen FROM proyectosjar WHERE idproyectosjar = %s", (id,))
            imagen_filename = cursor.fetchone()[0]

        cursor.execute("UPDATE proyectosjar SET nombre = %s, descripcion = %s, tipo_proyecto = %s, imagen = %s WHERE idproyectosjar = %s", (nombre, descripcion, tipo_proyecto, imagen_filename, id))
        db.connection.commit()
        flash('Proyecto Editado')
        return redirect('/sProyectoJ') 

@arquitectosApp.route('/dProyectoJ/<int:id>',methods=['GET','POST'])
def dProyectoJ(id):
    eliminarProyecto = db.connection.cursor()
    eliminarProyecto.execute("DELETE FROM proyectosjar WHERE idproyectosjar=%s",(id,))
    db.connection.commit()
    flash('Proyect Delete')
    return redirect('/sProyectoJ')



#CHATBOT

# @arquitectosApp.route('/chatbot')
# def chatbot():

#     return render_template('chatbot.html')

# openai.api_key = "TU_CLAVE_API"

# @arquitectosApp.route("/chat", methods=["POST"])
# def chat():
#     data = request.json
#     user_message = data.get("message")

#     if not user_message:
#         return jsonify({"error": "No se recibió un mensaje."}), 400

#     response = openai.ChatCompletion.create(
#         model="gpt-3.5-turbo",
#         messages=[
#             {"role": "system", "content": "Eres un asistente para arquitectos, especializado en diseño de interiores."},
#             {"role": "user", "content": user_message}
#         ]
#     )

#     chatbot_reply = response["choices"][0]["message"]["content"]
#     return jsonify({"response": chatbot_reply})


if __name__ == '__main__':
    arquitectosApp.config.from_object(config['development'])
    arquitectosApp.run(port=3300)
