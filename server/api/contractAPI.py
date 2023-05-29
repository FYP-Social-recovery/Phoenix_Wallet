from flask import Flask, redirect, url_for, request

from controller.publicContractController import PublicContractController
from controller.otp_controller import OTPController
from controller.nodeController import NodeContractController

app = Flask(__name__)
app.config["DEBUG"] = True


@app.route('/', methods=['GET'])
def home():
    return "<h1>Distant Reading Archive</h1><p>This site is a prototype API for distant reading of science fiction novels.</p>"


@app.route('/test', methods=['POST'])
def test():
    #data = request.get_json()  # retrieve the data sent in the request
    print(request.form['name'])
    return {"Name":request.form["name"]},200
   # return {'message': f'Test successful! Received data: {data["name"]}'}, 200

#started POC API
#public contract  APIs

#public-contract/deploy

@app.route('/public-contract/deploy',methods=['GET'])
def deployPublicContract():
    PublicContractController.deploy()
    return {"Deploy":"True"},200


#/node-contract/deploy

@app.route('/node-contract/deploy', methods=['post'])
def nodeDeploy():
    privateKey=request.form['prv']
    publicKey=request.form['pub']
    contractAddress=NodeContractController.deploy(publicKeyLocal=publicKey,privateKeyLocal=privateKey)
    return {"contractAddress":contractAddress},200




#fingerprint APIs

#fvss APIs

#otp APIs 



app.run()