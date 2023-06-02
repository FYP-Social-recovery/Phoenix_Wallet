from flask import Flask, redirect, url_for, request
from eth_account import Account
from controller.publicContractController import PublicContractController
from controller.otp_controller import OTPController
from controller.nodeController import NodeContractController
from web3 import Web3, HTTPProvider
from eth_account.messages import encode_defunct  


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
    print("Private key received "+privateKey)
    print("Public Key received "+publicKey)
    contractAddress=NodeContractController.deploy(publicKeyLocal=publicKey,privateKeyLocal=privateKey)
    return {"contractAddress":contractAddress},200

@app.route('/node-contract/request-shares', methods=['post'])
def requestShares():
    privateKey=request.form['prv']
    publicKey=request.form['pub']
    contractAddress=request.form['contract']
    userName=request.form['username']
    generatedOTP=request.form['generatedOTP']
    enteredOTP=request.form['enteredOTP']

    account = Account.privateKeyToAccount(privateKey) 
    generated_message_text = generatedOTP
    generated_message = encode_defunct(text=generated_message_text) 

    entered_message_text = enteredOTP
    entered_message = encode_defunct(text=entered_message_text) 

    web3 = Web3(HTTPProvider('https://arb-goerli.g.alchemy.com/v2/kmaQkTzL0jVfzpP6t9J1R04Y0hr9GGJE'))      
    generated_signed_message = web3.eth.account.sign_message(generated_message, private_key=account.privateKey)
    entered_signed_message = web3.eth.account.sign_message(entered_message, private_key=account.privateKey)

    #NodeContractController.requestShares(publicKeyLocal=Test.publicKeyThirdParty, privateKeyLocal=Test.privateKeyThirdParty, nodeContractAddressLocal=contract, userName="Alice",generated_signed_otp=signed_message,entered_signed_otp=signed_message)
   

    print("Private key received "+privateKey)
    print("Public Key received "+publicKey)
    result=NodeContractController.requestShares(publicKeyLocal=publicKey,privateKeyLocal=privateKey, nodeContractAddressLocal= contractAddress, userName= userName, generated_signed_otp= generated_signed_message,entered_signed_otp= entered_signed_message)
    return {"result":result},200

@app.route('/node-contract/request-vault-hash', methods=['post'])
def getVaultHash():
    privateKey=request.form['prv']
    publicKey=request.form['pub']
    contractAddress=request.form['contract']
    userName=request.form['username']
    generatedOTP=request.form['generatedOTP']
    enteredOTP=request.form['enteredOTP']

    account = Account.privateKeyToAccount(privateKey) 
    generated_message_text = generatedOTP
    generated_message = encode_defunct(text=generated_message_text) 

    entered_message_text = enteredOTP
    entered_message = encode_defunct(text=entered_message_text) 

    web3 = Web3(HTTPProvider('https://arb-goerli.g.alchemy.com/v2/kmaQkTzL0jVfzpP6t9J1R04Y0hr9GGJE'))      
    generated_signed_message = web3.eth.account.sign_message(generated_message, private_key=account.privateKey)
    entered_signed_message = web3.eth.account.sign_message(entered_message, private_key=account.privateKey)

    #NodeContractController.requestShares(publicKeyLocal=Test.publicKeyThirdParty, privateKeyLocal=Test.privateKeyThirdParty, nodeContractAddressLocal=contract, userName="Alice",generated_signed_otp=signed_message,entered_signed_otp=signed_message)
   

    print("Private key received "+privateKey)
    print("Public Key received "+publicKey)
    vaultHash=NodeContractController.getVaultHash(publicKeyLocal=publicKey,privateKeyLocal=privateKey, nodeContractAddressLocal= contractAddress, userName= userName, generated_signed_otp= generated_signed_message,entered_signed_otp= entered_signed_message)
    return {"vaultHash":vaultHash},200



#fingerprint APIs

#fvss APIs

#otp APIs 



app.run()