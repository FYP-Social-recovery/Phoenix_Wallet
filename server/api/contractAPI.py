from flask import Flask, redirect, url_for, request
from eth_account import Account
from controller.publicContractController import PublicContractController
from controller.otp_controller import OTPController
from controller.nodeController import NodeContractController
from controller.keyGenerationController import KeyGenerationController
from controller.email_controller import EmailController
from controller.finger_print_controller import FingerPrintController
from web3 import Web3, HTTPProvider
from eth_account.messages import encode_defunct  
from utils.fuzzy_vault_utils.Constants import *
from utils.symmetricEncryption import SymmetricEncryption
from utils.fuzzy_vault_utils.Strings import *
from controller.email_controller import EmailController
from controller.fvss_controller import VSS_Controller

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

@app.route('/public-contract/deploy',methods=['post'])
def deployPublicContract():
    PublicContractController.deploy()
    return {"Deploy":"True"},200


#/node-contract/deploy

@app.route('/node-contract/deploy', methods=['post'])
def nodeDeploy():
    privateKey=request.form['privateKey']
    publicKey=request.form['publicKey']
    contractAddress=NodeContractController.deploy(publicKeyLocal=publicKey,privateKeyLocal=privateKey)
    return {"result":contractAddress},200

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

@app.route('/node-contract/request-vault-hash', methods=['POST'])
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
    return {"result":vaultHash},200



#Node contract APIs

#/node-contract/deploy
#/node-contract/register
#node-contract/be-holder-requests
#node=-contract/accept-invitation
#node-contract/reject-invitation
#node-contract/share-requests
#node-contract/release-share
#node-contract/add-temp-shareholder
#node-contract/make-holder-requests
#node-contract/add-shares
#node-contract/share-holders
#node-contract/requested-share-holders
#node-contract/rejected-share-holders
#node-contract/distribute
#node-contract/request-shares
#node-contract/vault-hash
#node-contract/received-shares
#node-contract/check-user-exists
#node-contract/my-state
#node-contract/holder-status
#node-contract/contract-address-by-public-address
#node-contract/user-name
#node-contract/email-by-user-name

#key-generation/generateMnemonicForNewAccount
#key-generation/import-wallet-from-mnemonic
#key-generation/mnemonic-to-entropy

@app.route('/key-generation/generateMnemonicForNewAccount', methods=['GET'])
def generateMnemonicForNewAccount():
    mnemonic=KeyGenerationController.generateMnemonicForNewAccount()
    return {"result":mnemonic},200

@app.route('/key-generation/import-wallet-from-mnemonic', methods=['POST'])
def importWalletFromMnemonic():
    mnemonic=request.form['mnemonic']
    prv,pub=KeyGenerationController.importWalletFromMnemonic(mnemonicString=mnemonic)
    return {"result":[prv,pub]},200

@app.route('/key-generation/mnemonic-to-entropy', methods=['POST'])
def mnemonicToEntropy():

    mnemonic=request.form['mnemonic']
    entropy=KeyGenerationController.mnemonicToEntropy(mnemonic=mnemonic)
    return {"result":str(entropy)},200

@app.route('/node-contract/register', methods=['POST'])
def nodeRegister():
    userName=request.form['userName']
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    NodeContractController.register(userName=userName,publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
    return {"result":"registered"},200

@app.route('/node-contract/be-holder-requests', methods=['POST'])
def checkRequestsForBeAHolder():
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    requests=NodeContractController.checkRequestsForBeAHolder(publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
    return {"result":requests},200

@app.route('/node-contract/accept-invitation', methods=['POST'])
def acceptInvitation():
    address=request.form['address']
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    status=NodeContractController.acceptInvitation(address=address,publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
    return {"result":status},200

@app.route('/node-contract/reject-invitation', methods=['POST'])
def rejectInvitation():
    address=request.form['address']
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    status=NodeContractController.rejectInvitation(address=address,publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
    return {"result":status},200

@app.route('/node-contract/share-requests', methods=['POST'])
def getShareRequests():
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    shareRequests=NodeContractController.checkRequestsForShare(publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
    return {"result":shareRequests},200

@app.route('/node-contract/release-share', methods=['POST'])
def releaseShare():
    address=request.form['address']
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    status=NodeContractController.releaseShare(address=address,publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
    return {"result":status},200

@app.route('/node-contract/add-temp-share-holder', methods=['POST'])
def addTempShareHolder():
    shareHolder=request.form['shareHolder']
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    status=NodeContractController.addTemporaryShareHolder(share_holder=shareHolder,publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
    return {"result":status},200

@app.route('/node-contract/make-shareholder-requests', methods=['POST'])
def makeShareHolderRequests():
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    status=NodeContractController.makeHolderRequests(publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
    return {"result":status},200

@app.route('/node-contract/add-shares', methods=['POST'])
def addShares():
    shares=request.form['shares']
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    status=NodeContractController.addMyShares(shares=shares,publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
    return {"status":status},200

@app.route('/node-contract/share-holders', methods=['POST'])
def getShareHolders():
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    shareHolders=NodeContractController.getShareHolders(publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
    return {"result":shareHolders},200

@app.route('/node-contract/requested-shareholders', methods=['POST'])
def getRequestedShareHolders():
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    requestedShareHolders=NodeContractController.getRequestedShareHolders(publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
    return {"result":requestedShareHolders},200

@app.route('/node-contract/rejected-share-holders', methods=['POST'])
def getRejectedShareHolders():
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    rejectedShareHolders=NodeContractController.getRejectedShareHolders(publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
    return {"result":rejectedShareHolders},200

@app.route('/node-contract/distribute', methods=['POST'])
def distribute():
    otpContr=OTPController()
    emailContr=EmailController()
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    email=request.form['email']
    entropy=request.form['entropy']
    print("OTP verification successful")
    print("Start Enrolling")
    # Capture Enrolling fingerprint template
    original_image_path = "../data/Original_fp.BMP"
    original_image_template = FingerPrintController.read_image(original_image_path)
    
    # Preprocessing Fingerprint
    preprocessed_image_output_path = "../data/Preprocessed_fp.jpg"

    preprocessed_image = FingerPrintController.fingerprint_pipline(original_image_template, save_image=True, save_path=preprocessed_image_output_path)
    
    # Extract minutiea
    print("Start minutiae extraction")
    good_fp = False
    
    good_fp = FingerPrintController.capture_new_fp_xyt(preprocessed_image_output_path)
    
    ## If good fp enroll
    ## else error
    if not good_fp:
        print("APP_RETRY_FP")
        res=1
    else:
        print("Start vault generation")
        # Generate vault
        secret = entropy
        fuzzy_vault = FingerPrintController.enroll_new_fingerprint(FP_TEMP_FOLDER + FP_OUTPUT_NAME + '.xyt', secret)
        
        print(fuzzy_vault)
        print("\n\n")
        
        fuzzy_vault_bytes_object = SymmetricEncryption.convertStringToBytesObject(fuzzy_vault)
        
        print(fuzzy_vault_bytes_object)
        print("\n\n")
        
        encrypted_fuzzy_vault,key  = SymmetricEncryption.encrypt_vault_128_bit_key(fuzzy_vault_bytes_object) # encrypted_fuzzy_vault,key,iv = SymmetricEncryption.encrypt_vault_256_bit_key(fuzzy_vault_bytes_object)
        encrypted_fuzzy_vault = SymmetricEncryption.convertByteToString(encrypted_fuzzy_vault)
        print(encrypted_fuzzy_vault)
        print("\n\n")
        
        combined_key_bytes = key # SymmetricEncryption.concatanate2BytesObject(key,iv)
        
        combined_key = SymmetricEncryption.convertBytesObjectToInteger(combined_key_bytes)

        #print(combined_key)
        


        VSS_client=VSS_Controller()
        shares=VSS_client.get_generated_shares(int(combined_key))
        #print(type(otpHash))
        #print(type(encrypted_fuzzy_vault))
        NodeContractController.addMyShares(shares=[shares[0],shares[1],shares[2]],publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
        
        #change this function to store email
        NodeContractController.distribute(publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract,email=email,vault=encrypted_fuzzy_vault)
        res=2
    return {"result":res},200

# @app.route('/node-contract/request-shares', methods=['POST'])
# def requestShares():
#     userName=request.form['userName']
#     generatedSignedOTP=request.form['generatedSignedOTP']
#     enteredSignedOTP=request.form['enteredSignedOTP']
#     publicKey=request.form['publicKey']
#     privateKey=request.form['privateKey']
#     nodeContract=request.form['nodeContract']
#     status=NodeContractController.requestShares(generated_signed_otp=generatedSignedOTP,entered_signed_otp=enteredSignedOTP, userName=userName,publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
#     return {"status":status},200

# @app.route('/node-contract/vault-hash', methods=['GET'])
# def getVaultHash():
#     userName=request.form['userName']
#     generatedSignedOTP=request.form['generatedSignedOTP']
#     enteredSignedOTP=request.form['enteredSignedOTP']
#     publicKey=request.form['publicKey']
#     privateKey=request.form['privateKey']
#     nodeContract=request.form['nodeContract']
#     vaultHash=NodeContractController.getVaultHash(generated_signed_otp=generatedSignedOTP,entered_signed_otp=enteredSignedOTP, userName=userName,publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
#     return {"vaultHash":vaultHash},200

@app.route('/node-contract/received-shares', methods=['POST'])
def getReceivedShares():
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    shares=NodeContractController.getReceivedShares(publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
    return {"result":shares},200

# @app.route('/node-contract/check-user-exists', methods=['GET'])
# def checkUserExists():
#     userName=request.form['userName']
#     status=NodeContractController.checkUserExists(userName=userName)
#     return {"status":status},200

@app.route('/node-contract/my-state', methods=['POST'])
def getMyState():
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    state=NodeContractController.getMyState(publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
    return {"result":state},200

@app.route('/node-contract/holder-status', methods=['POST'])
def getHolderStatus():
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    holderStatus=NodeContractController.getHolderStatus(publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
    return {"result":holderStatus},200

# @app.route('/node-contract/contract-address-by-public-address', methods=['GET'])
# def getContractAddressByPublicAddress():
#     userName=request.form['userName']
#     generatedSignedOTP=request.form['generatedSignedOTP']
#     enteredSignedOTP=request.form['enteredSignedOTP']
#     publicKey=request.form['publicKey']
#     privateKey=request.form['privateKey']
#     nodeContract=request.form['nodeContract']
#     status=NodeContractController.getContractAddressOfPublicAddress(generated_signed_otp=generatedSignedOTP,entered_signed_otp=enteredSignedOTP, userName=userName,publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
#     return {"status":status},200


@app.route('/node-contract/user-name', methods=['POST'])
def getUserName():
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    userName=NodeContractController.getUserName(publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
    return {"result":userName},200

@app.route('/node-contract/email-by-user-name', methods=['POST'])
def getEmail():
    userName=request.form['userName']
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    nodeContract=request.form['nodeContract']
    email=NodeContractController.getEmailByUserName(userName=userName,publicKeyLocal=publicKey,privateKeyLocal=privateKey,nodeContractAddressLocal=nodeContract)
    
    OTP_client=OTPController()
    otp,generated_signed_otp=OTP_client.generateSignedOTP()
    Email_client=EmailController()
    Email_client.sendEmail(email,otp)
    return {"result":[email,generated_signed_otp]},200

@app.route('/public-contract/get-contract-address-by-public-address', methods=['POST'])
def getContractAddressByPublicAddress():
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    rtn=PublicContractController.getContractAddressByPublicAddress(publicKeyLocal=publicKey, privateKeyLocal=privateKey)
    return {"result": rtn}, 200

@app.route('/public-contract/check-user-exists', methods=['POST'])
def checkUserExists():
    publicKey=request.form['publicKey']
    privateKey=request.form['privateKey']
    userName=request.form["userName"]
    rtn = PublicContractController.checkUserExists(
        userName, publicKey, privateKey)
    return {"result": rtn}, 200


#OTP controller APIs


@app.route('/otp/generate-otp', methods=['POST'])
def generateOTP():
    email=request.form['email']
    otpContr=OTPController()
    emailContr=EmailController()
    otp,otp_hash = otpContr.generateOTPHash()
    emailContr.sendEmail(receiverEmail=email,OTP=otp)
    return {"result":otp_hash}, 200


@app.route('/otp/get-otp-hash', methods=['POST'])
def getOTPHash():
    otp=request.form['otp']
    otpContr=OTPController()
    rtn = otpContr.convert_Hash(otp)[1]
    return {"result": rtn}, 200






app.run()