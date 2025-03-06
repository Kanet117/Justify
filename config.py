class Config:
    SECRET_KEY = 'falksdjflakñdfañlkdfañlksdfjañlkdfpoiquerpoiquezxcvbnvm'
    DEBUG = True
    

class DevelopmentConfig(Config):
    MYSQL_HOST = 'localhost'
    MYSQL_USER = 'root'
    MYSQL_PASSWORD = 'mysql'
    MYSQL_DB = 'justify'
    MYSQL_SOCKET = '/Applications/XAMPP/xamppfiles/var/mysql/mysql.sock'
    
    '''
    MYSQL_HOST = 'eclipsehome.mysql.pythonanywhere-services.com'
    MYSQL_USER = 'eclipsehome'
    MYSQL_PASSWORD = 'RembrandtMauricio'
    MYSQL_DB = 'eclipsehome$eclipsehome'
    '''

class MailConfig(Config):

    MAIL_SERVER = 'smtp.gmail.com'
    MAIL_PORT = 587
    MAIL_USE_TLS = True
    MAIL_USE_SSL = False
    MAIL_USERNAME = 'rembrandt.mauricio1762@alumnos.udg.mx'
    MAIL_PASSWORD = 'kbkr saez rdtq nxkr'
    MAIL_DEFAULT_SENDER = 'rembrandt.mauricio1762@alumnos.udg.mx'
    MAIL_ASCII_ATTACHMENTS = True




config = {
    'development': DevelopmentConfig,
    'mail'       : MailConfig  
}