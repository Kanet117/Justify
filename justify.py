from flask import Flask, render_template, url_for, request, redirect, flash, session, jsonify
from flask_mysqldb import MySQL
from flask_login import LoginManager, login_user, logout_user, current_user, UserMixin
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
login_manager.login_view = 'login'

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

# Ruta para el home
@justifyApp.route('/')
def home():
    return render_template('home.html')

# Ruta para mostrar publicaciones
@justifyApp.route('/publicaciones')
def mostrar_publicaciones():
    try:
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT p.id_publicacion, p.titulo, p.descripcion, p.imagen, p.fecha, u.nombre, u.id AS usuario_id, u.perfil FROM publicaciones p JOIN usuario u ON p.usuario_id = u.id ORDER BY p.fecha DESC")
        publicaciones = cursor.fetchall()
        cursor.close()
        return render_template('publicaciones.html', publicaciones=publicaciones)
    except Exception as e:
        flash(f"Error al cargar publicaciones: {str(e)}")
        return redirect(url_for('home'))

# Ruta para crear una publicación
@justifyApp.route('/crear_publicacion', methods=['POST'])
def crear_publicacion():
    if not current_user.is_authenticated:
        flash('Debes iniciar sesión para crear una publicación.')
        return redirect(url_for('login'))

    # Permitir a todos los usuarios autenticados (U, E, A) crear publicaciones
    usuario_id = current_user.id
    titulo = request.form['titulo']
    descripcion = request.form['descripcion']
    imagen = request.files.get('imagen')

    # Validar límite de 500 palabras
    palabras = len(descripcion.split())
    if palabras > 500:
        flash('La descripción no puede exceder las 500 palabras.')
        return redirect(url_for('publicaciones'))

    # Manejo de la imagen
    imagen_filename = None
    if imagen and imagen.filename:
        imagen_filename = secure_filename(imagen.filename)
        imagen.save(os.path.join(justifyApp.config['UPLOAD_FOLDER'], imagen_filename))

    # Insertar en la base de datos
    try:
        cursor = mysql.connection.cursor()
        cursor.execute(
            "INSERT INTO publicaciones (usuario_id, titulo, descripcion, imagen) VALUES (%s, %s, %s, %s)",
            (usuario_id, titulo, descripcion, imagen_filename)
        )
        mysql.connection.commit()
        cursor.close()
        flash('Publicación creada con éxito')
    except Exception as e:
        flash(f"Error al crear la publicación: {str(e)}")
    return redirect(url_for('publicaciones'))

# Ruta para editar una publicación
@justifyApp.route('/editar_publicacion/<int:id>', methods=['GET', 'POST'])
def editar_publicacion(id):
    if not current_user.is_authenticated:
        flash('Debes iniciar sesión para editar una publicación.')
        return redirect(url_for('login'))

    # Obtener la publicación para verificar el propietario
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM publicaciones WHERE id_publicacion = %s", (id,))
    publicacion = cursor.fetchone()
    cursor.close()

    if not publicacion:
        flash('Publicación no encontrada.')
        return redirect(url_for('publicaciones'))

    # Verificar permisos
    if current_user.perfil == 'A':
        # Los administradores pueden editar cualquier publicación
        pass
    elif current_user.perfil in ['U', 'E']:
        # Estudiantes y empresas solo pueden editar sus propias publicaciones
        if publicacion['usuario_id'] != current_user.id:
            flash('No tienes permiso para editar esta publicación.')
            return redirect(url_for('publicaciones'))
    else:
        flash('No tienes permiso para editar publicaciones.')
        return redirect(url_for('publicaciones'))

    if request.method == 'POST':
        titulo = request.form['titulo']
        descripcion = request.form['descripcion']
        imagen = request.files.get('imagen')

        # Validar límite de 500 palabras
        palabras = len(descripcion.split())
        if palabras > 500:
            flash('La descripción no puede exceder las 500 palabras.')
            return redirect(url_for('editar_publicacion', id=id))

        # Manejo de la imagen
        imagen_filename = publicacion['imagen']
        if imagen and imagen.filename:
            imagen_filename = secure_filename(imagen.filename)
            imagen.save(os.path.join(justifyApp.config['UPLOAD_FOLDER'], imagen_filename))

        # Actualizar en la base de datos
        try:
            cursor = mysql.connection.cursor()
            cursor.execute(
                "UPDATE publicaciones SET titulo = %s, descripcion = %s, imagen = %s WHERE id_publicacion = %s",
                (titulo, descripcion, imagen_filename, id)
            )
            mysql.connection.commit()
            cursor.close()
            flash('Publicación editada con éxito')
        except Exception as e:
            flash(f"Error al editar la publicación: {str(e)}")
        return redirect(url_for('publicaciones'))

    return render_template('editar_publicacion.html', publicacion=publicacion)

# Ruta para borrar una publicación
@justifyApp.route('/borrar_publicacion/<int:id>')
def borrar_publicacion(id):
    if not current_user.is_authenticated:
        flash('Debes iniciar sesión para borrar una publicación.')
        return redirect(url_for('login'))

    # Obtener la publicación para verificar el propietario
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM publicaciones WHERE id_publicacion = %s", (id,))
    publicacion = cursor.fetchone()
    cursor.close()

    if not publicacion:
        flash('Publicación no encontrada.')
        return redirect(url_for('publicaciones'))

    # Verificar permisos
    if current_user.perfil == 'A':
        # Los administradores pueden borrar cualquier publicación
        pass
    elif current_user.perfil in ['U', 'E']:
        # Estudiantes y empresas solo pueden borrar sus propias publicaciones
        if publicacion['usuario_id'] != current_user.id:
            flash('No tienes permiso para borrar esta publicación.')
            return redirect(url_for('publicaciones'))
    else:
        flash('No tienes permiso para borrar publicaciones.')
        return redirect(url_for('publicaciones'))

    # Borrar la publicación
    try:
        cursor = mysql.connection.cursor()
        cursor.execute("DELETE FROM publicaciones WHERE id_publicacion = %s", (id,))
        mysql.connection.commit()
        cursor.close()
        flash('Publicación borrada con éxito')
    except Exception as e:
        flash(f"Error al borrar la publicación: {str(e)}")
    return redirect(url_for('publicaciones'))

# Ruta de login
@justifyApp.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        correo = request.form['correo']
        clave = request.form['clave']
        user = User(None, None, correo, clave, None, None)
        logged_user = ModelUser.signin(mysql, user)
        if logged_user and logged_user.clave:
            login_user(logged_user)
            return redirect(url_for('home'))
        else:
            flash('Correo o contraseña incorrectos.')
            return render_template('login.html')
    return render_template('login.html')

# Ruta de logout
@justifyApp.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('login'))

if __name__ == '__main__':
    justifyApp.run(debug=True)