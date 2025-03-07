from flask import Flask, render_template, url_for, request, redirect, flash, session
from flask_mysqldb import MySQL
from flask_login import LoginManager, login_user, logout_user, current_user
from flask_mail import Mail, Message
from werkzeug.security import generate_password_hash, check_password_hash
from werkzeug.utils import secure_filename
import datetime
import os
import uuid
from config import config
from models.ModelUser import ModelUser
from models.entities.User import User

# Inicializar la aplicación Flask
justifyApp = Flask(__name__)

# Cargar configuraciones desde config.py
justifyApp.config.from_object(config['development'])

# Inicializar MySQL
mysql = MySQL(justifyApp)

# Configuración de Flask-Login
login_manager = LoginManager(justifyApp)
login_manager.login_view = 'signin'

# Configuración de Flask-Mail
mail = Mail(justifyApp)
justifyApp.config['MAIL_DEFAULT_SENDER'] = config['mail'].MAIL_DEFAULT_SENDER

# Carpeta para subir imágenes
UPLOAD_FOLDER = 'static/IMG'
justifyApp.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Cargar usuario con Flask-Login
@login_manager.user_loader
def load_user(user_id):
    return ModelUser.get_by_id(mysql, user_id)

# Ruta para el home (redirige a inicio si autenticado)
@justifyApp.route('/')
def home():
    if current_user.is_authenticated:
        return redirect(url_for('inicio'))
    return render_template('home.html')

# Ruta para la página de inicio
@justifyApp.route('/inicio')
def inicio():
    if not current_user.is_authenticated:
        return redirect(url_for('signin'))
    
    try:
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT p.id_publicacion, p.titulo, p.descripcion, p.imagen, p.fecha, u.nombre FROM publicaciones p JOIN usuario u ON p.usuario_id = u.id ORDER BY p.fecha DESC")
        publicaciones = cursor.fetchall()
        cursor.close()

        # Depuración: Imprimir las publicaciones obtenidas
        print("Publicaciones obtenidas:", publicaciones)

        # Convertir tuplas a diccionarios
        publicaciones_dict = [
            {
                'id_publicacion': pub[0],
                'titulo': pub[1],
                'descripcion': pub[2],
                'imagen': pub[3],
                'fecha': pub[4],
                'nombre': pub[5]
            } for pub in publicaciones
        ]
        
        return render_template('inicio.html', publicaciones=publicaciones_dict)
    except Exception as e:
        flash(f"Error al cargar publicaciones: {str(e)}")
        return redirect(url_for('home'))

# Ruta para crear una publicación
@justifyApp.route('/crear_publicacion', methods=['POST'])
def crear_publicacion():
    if not current_user.is_authenticated:
        flash('Debes iniciar sesión para crear una publicación.')
        return redirect(url_for('signin'))

    usuario_id = current_user.id
    titulo = request.form.get('titulo', '')  # Opcional si no lo incluyes en el formulario
    descripcion = request.form['descripcion']
    imagen = request.files.get('imagen')

    # Validar límite de 500 palabras
    palabras = len(descripcion.split())
    if palabras > 500:
        flash('La descripción no puede exceder las 500 palabras.')
        return redirect(url_for('inicio'))

    # Manejo de la imagen
    imagen_filename = None
    if imagen and imagen.filename:
        imagen_filename = secure_filename(imagen.filename)
        imagen.save(os.path.join(justifyApp.config['UPLOAD_FOLDER'], imagen_filename))

    # Insertar en la base de datos con fecha actual
    try:
        cursor = mysql.connection.cursor()
        cursor.execute(
            "INSERT INTO publicaciones (usuario_id, titulo, descripcion, imagen, fecha) VALUES (%s, %s, %s, %s, %s)",
            (usuario_id, titulo, descripcion, imagen_filename, datetime.datetime.now())
        )
        mysql.connection.commit()
        cursor.close()
        flash('Publicación creada con éxito')
    except Exception as e:
        flash(f"Error al crear la publicación: {str(e)}")
    return redirect(url_for('inicio'))

# Ruta de inicio de sesión
@justifyApp.route('/signin', methods=['GET', 'POST'])
def signin():
    if request.method == 'POST':
        correo = request.form['correo']
        clave = request.form['clave']
        user = User(None, None, correo, clave, None, None)
        logged_user = ModelUser.signin(mysql, user)
        if logged_user and logged_user.clave:
            login_user(logged_user)
            return redirect(url_for('inicio'))
        else:
            flash('Correo o contraseña incorrectos.')
            return render_template('signin.html')
    return render_template('signin.html')

# Ruta de registro
@justifyApp.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        nombre = request.form['nombre']
        correo = request.form['correo']
        clave = request.form['clave']
        perfil = request.form['perfil']

        # Validar que el correo no exista
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT correo FROM usuario WHERE correo = %s", (correo,))
        existing_user = cursor.fetchone()
        cursor.close()

        if existing_user:
            flash('El correo ya está registrado.')
            return redirect(url_for('signup'))

        # Encriptar la contraseña
        clave_encriptada = generate_password_hash(clave)

        # Insertar nuevo usuario
        try:
            cursor = mysql.connection.cursor()
            cursor.execute(
                "INSERT INTO usuario (nombre, correo, clave, perfil) VALUES (%s, %s, %s, %s)",
                (nombre, correo, clave_encriptada, perfil)
            )
            mysql.connection.commit()
            cursor.close()
            flash('Registro exitoso. Por favor, inicia sesión.')
            return redirect(url_for('signin'))
        except Exception as e:
            flash(f"Error al registrar: {str(e)}")
            return redirect(url_for('signup'))

    return render_template('signup.html')

# Ruta de logout
@justifyApp.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('signin'))

if __name__ == '__main__':
    justifyApp.run(debug=True)