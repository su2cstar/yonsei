from flask import Flask, jsonify, request
from flask_restful import Resource, Api
from flask_restful import reqparse
#reqparse = 파서를 사용해 파라미터를 추출하는데 쓰임



app = Flask(__name__)
api = Api(app)

name = {}

class HOME(Resource):
    def get(self):
        try:
            json_doc = {'Greeting' : 'Hello'}
            return jsonify(json_doc)

        except Exception as e:
            return {'error':str(e)}

class Name(Resource):
    
    def get(self):
        return jsonify(name)
    

class CreateUser(Resource):
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('email', type=str)
            parser.add_argument('user_name', type=str)
            parser.add_argument('password', type=str)
                       
            args = parser.parse_args()

            _userEmail = args['email']
            _userName = args['user_name']
            _userPassword = args['password']

            user = {'email' : _userEmail, 'user_name' : _userName, 'password' : _userPassword}
            name[_userName] = user

            json_doc = {'Email':args['email'], 'UserName':args['user_name'], 'Password':args['password']}
            return jsonify(json_doc)
        except Exception as e:
            return {'error':str(e)}
 
        
        
api.add_resource(HOME, '/')
api.add_resource(CreateUser, '/user')
api.add_resource(Name, '/name')

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5001)