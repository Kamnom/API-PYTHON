from flask import Flask, request, jsonify, make_response
from flask_sqlalchemy import SQLAlchemy 
from flask_marshmallow import Marshmallow
from marshmallow import ValidationError, fields
import json
import jwt
from functools import wraps
import datetime

app = Flask (__name__)

app.config['SECRET_KEY'] = 'absolutekey'
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql+psycopg2://postgres:123456789@localhost:5432/RecursosHumanos'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS']=False

db = SQLAlchemy(app)
mm = Marshmallow(app)

## Models

class Personal(db.Model):
    personal_id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(25))
    apellidop = db.Column(db.String(25))
    apellidom = db.Column(db.String(25))
    fecha_nac = db.Column(db.Date())
    puesto = db.Column(db.String(50))

    def __init__(self,nombre,apellidop,apellidom,fecha_nac,puesto):
        self.nombre = nombre
        self.apellidop = apellidop
        self.apellidom = apellidom
        self.fecha_nac = fecha_nac
        self.puesto = puesto

class Usuarios(db.Model):
    usuario_id = db.Column(db.Integer, primary_key=True)
    usuario = db.Column(db.String(25), unique=True)
    contraseña = db.Column(db.String(25))
    token_id = db.Column(db.String())
    fecha_crea = db.Column(db.Date())
    ultimo_login = db.Column(db.Date())
    admin = db.Column(db.Boolean())

    def __init__(self,usuario,contraseña,token_id,fecha_crea,ultimo_login,admin):
        self.usuario = usuario
        self.contraseña = contraseña
        self.token_id = token_id
        self.fecha_crea = fecha_crea
        self.ultimo_login = ultimo_login
        self.admin = admin

db.create_all()


def token_check(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = None

        if 'x-acces-token' in request.headers:
            token=request.headers['x-acces-token']
        if not token:
            return jsonify({'message': 'Token is required'}),401

        try:
            data = jwt.decode(token,app.config['SECRET_KEY'])
            current_user = Usuarios.query.filter_by(usuario = data['usuario'],contraseña = data['contraseña']).first()
        except:
            return jsonify({'message': 'Token is required'}),401
        return f(current_user, *args, **kwargs)
    return decorated

##USANDO MARSHMALLOW para crear Schema para el manejo los datos
class PersonalSchema(mm.Schema):
    pesonal_id = fields.Integer()
    nombre = fields.String(required=True)
    apellidop = fields.String(required=True)
    apellidom = fields.String(required=True)
    fecha_nac = fields.String(required=True)
    puesto = fields.String(required=True)

class UsuarioSchema(mm.Schema):
    usuario = fields.String(required=True)
    contraseña = fields.String(required=True)
    token_id = fields.String()

##### Instancias

personal_schema = PersonalSchema()
personals_schema = PersonalSchema(many=True)

usuario_schema = UsuarioSchema()

########

#CREATE Personal

@app.route('/personal',methods=['POST'])
@token_check
def create_personal(current_user):
    data = dict()
    resquest_data = request.get_json()

    try:
        validated_personal = personal_schema.load(resquest_data)

        nombre = validated_personal['nombre']
        apellidop = validated_personal['apellidop']
        apellidom = validated_personal['apellidom']
        fecha_nac = validated_personal['fecha_nac']
        puesto = validated_personal['puesto']

        new_personal = Personal(nombre,apellidop,apellidom,fecha_nac,puesto)
        db.session.add(new_personal)
        db.session.commit()

        data['data'] = validated_personal
        data['status'] = {'status':'OK', 'messege':'Done', 'action':'CREATE'}
        print(data)

        return jsonify(data)

    except ValidationError as err:
        resp = jsonify({"error": err.messages,"valid_data":err.valid_data, 'action':'CREATE'})
        return resp               


## UPDATE Personal
@app.route('/personal/<personal_id>',methods=['PUT'])
@token_check
def update_personal(current_user,personal_id):

    if not current_user.admin:
        return make_response('No estas autorizado para este contenido : Usuario sin permisos',401,{'WWW-Authenticate': 'Basic realm="Login required!"'})

    data = dict()
    request_data = request.get_json()

    personal = Personal.query.get(personal_id)

    if personal:
        for k,v in request_data.items():
            setattr(personal, k, v) 
        db.session.commit()
        
        data['data'] = request_data
        data['status'] = {'status':'OK', 'messege':'Done','action':'UPDATE'}
        return jsonify(data)
    else:
        data['data'] = request_data
        data['status'] = {'status':'FAIL', 'messege':'Data Not Found','action':'UPDATE'}
        return jsonify(data)

### DELETE Personal

@app.route('/personal/<personal_id>',methods=['DELETE'])
@token_check
def delete_personal(current_user,personal_id):
    data = dict()
    personal = Personal.query.get(personal_id)

    if personal:
        db.session.delete(personal)
        db.session.commit()
        
        data['data'] = personal_schema.dump(personal)
        data['status'] = {'status':'OK', 'messege':'Done', 'action':'DELETE'}
        return jsonify(data)
    else:
        data['data'] = {}
        data['status'] = {'status':'FAIL', 'messege':'Data Not Found', 'action':'DELETE'}
        return jsonify(data)

##GET ALL PERSONAL
@app.route('/personal',methods=['GET'])
@token_check
def get_all_personal(current_user):

    data = dict()

    print(current_user.admin)

    try:
        all_personal = Personal.query.all()
        result = personals_schema.dump(all_personal)
        data['data'] = result
        data['status'] = {'status':'OK', 'messege':'Done'}
        
        return jsonify(data)

    except:
        data['data'] = result
        data['status'] = {'status':'FAIL', 'messege':'Data not Found'}
        return jsonify(data)

##GET PERSONAL BY ID  
@app.route('/personal/<personal_id>',methods=['GET'])
@token_check
def get_personal_by_id(current_user,personal_id):
    data = dict()
    try:
        personal = Personal.query.get(personal_id)
        result = personal_schema.dump(personal)
        
        if result and len(result)>0:
            data['data'] = result
            data['status'] = {'status':'OK', 'messege':'Done'}
            return jsonify(data)
        else:
            data['data'] = result
            data['status'] = {'status':'FAIL', 'messege':'Personal Data Not Found'}
            return jsonify(data)

    except:
        data['data'] = result
        data['status'] = {'status':'FAIL', 'messege':'DataBase Error'}
        return jsonify(data)




##LOGIN and AUTH

@app.route('/login')
def login():
    auth = request.authorization
    x = datetime.datetime.now()
    date = str(x.year)+'-'+str(x.month)+'-'+str(x.day)

    if not auth or not auth.username or not auth.password:
        return make_response('Usuario y Contraseña no validos.',401,{'WWW-Authenticate': 'Basic realm="Login required!"'})

    usuario = Usuarios.query.filter_by(usuario = auth.username,contraseña = auth.password).first()
    usr = usuario_schema.dump(usuario)

   
    if not usr:
        return make_response('No se pudo verificar el Login: Usuario no encontrado',401,{'WWW-Authenticate': 'Basic realm="Login required!"'})

    if usr['contraseña'] == auth.password and usr['token_id'] == None:

        token = jwt.encode({'usuario':usr['usuario'],'contraseña':usr['contraseña']},app.config['SECRET_KEY'])
        usuario.token_id = token.decode('UTF-8')

        usuario.ultimo_login = date
        db.session.commit()
        return jsonify({'token': token.decode('UTF-8')})

    if usr['contraseña'] == auth.password and usr['token_id'] :
        return make_response({'token':usr['token_id']},200,{'WWW-Authenticate': 'Basic realm="Logged!"'}) 
    
    return make_response('No se pudo verificar el login : Contraseña erronea',401,{'WWW-Authenticate': 'Basic realm="Login required!"'})

## Running App
if __name__ == '__main__':
    app.run(host="0.0.0.0",port:5000,debug=True)
