#imports 
from web3 import Web3
from eth_account import Account
from solcx import compile_standard, install_solc
from eth_account.messages import encode_defunct
import json 
from View.state import GlobalState

class NodeContractModel:
    w3 = Web3(Web3.HTTPProvider(GlobalState.RPC_URL))
    

    # deploy the node smart contract
    def deploy(publicAddress,privateAddress):
        # NodeContractModel.defaultPrivateAddress=privateAddress
        # NodeContractModel.defaultPublicAddress=publicAddress
        
        #with open(r"contract/compiled_code.json","r") as file: # for windows
        with open("../contract/compiled_code.json","r") as file: # for ubuntu
            compiled_sol = json.loads(file.read())

        # get bytecode
        bytecode = compiled_sol["contracts"]["Node.sol"]["Node"]["evm"]["bytecode"]["object"]
        # get abi
        abi = json.loads(compiled_sol["contracts"]["Node.sol"]["Node"]["metadata"])["output"]["abi"]
        GlobalState.NODE_CONTRACT_ABI=abi

        w3 = Web3(Web3.HTTPProvider(GlobalState.RPC_URL))

        chain_id = GlobalState.CHAIN_ID
        
        address = publicAddress
        # leaving the private key like this is very insecure if you are working on real world project
        private_key = privateAddress
        # Create the contract in Python
        ContactList = w3.eth.contract(abi=abi, bytecode=bytecode)
        # Get the number of latest transaction
        nonce = w3.eth.getTransactionCount(address)


        # build transaction
        transaction = ContactList.constructor(GlobalState.PUBLIC_CONTRACT_ADDRESS).buildTransaction(
            {
                "chainId": chain_id,
                "gasPrice": w3.eth.gas_price,
                "from": address,
                "nonce": nonce,
            }
        )
        # Sign the transaction
        sign_transaction = w3.eth.account.sign_transaction(
            transaction, private_key=private_key)
        print("Deploying Contract!")
        #print("Gas",w3.eth.gas_price)
        # Send the transaction
        transaction_hash = w3.eth.send_raw_transaction(sign_transaction.rawTransaction)
        # Wait for the transaction to be mined, and get the transaction receipt
        print("Waiting for transaction to finish...")
        transaction_receipt = w3.eth.wait_for_transaction_receipt(transaction_hash)
        print("Gas",transaction_receipt["gasUsed"] )
        print(f"Done! Contract deployed to {transaction_receipt.contractAddress}")

        #setting my contract address to deployed address  
        GlobalState.NODE_CONTRACT_ADDRESS=transaction_receipt.contractAddress
        return transaction_receipt.contractAddress
    
    #establish the connection to call the smart contract functions 
    def connection(abi,contract_addr,owner_addr,p_key):
        c = NodeContractModel.w3.eth.contract(address=contract_addr, abi=abi)
        return c
#Request shares from holders 
    def requestShares(owner_addr,private_addr,user_name,generated_signed_otp,entered_signed_otp, nodeContractAddressLocal):
        #signed msg
        def to_32byte_hex(val):
            return Web3.toHex(Web3.toBytes(val).rjust(32, b'\0'))
        generated_msg_hash=Web3.toHex(generated_signed_otp.messageHash)
        entered_msg_hash=Web3.toHex(entered_signed_otp.messageHash)
        v, r, s = generated_signed_otp.v, to_32byte_hex(generated_signed_otp.r), to_32byte_hex(generated_signed_otp.s)
        c= NodeContractModel.connection(GlobalState.NODE_CONTRACT_ABI,nodeContractAddressLocal,owner_addr,private_addr)
        print(owner_addr,"Requesting the shares ",nodeContractAddressLocal)
        nonce = NodeContractModel.w3.eth.getTransactionCount(owner_addr)
        returnVal = c.functions.requestSharesFromHolders(user_name,generated_msg_hash,v, r, s,entered_msg_hash).buildTransaction({"from": owner_addr,"nonce": nonce})
        # Sign the transaction
        sign_store_contact = NodeContractModel.w3.eth.account.sign_transaction(returnVal, private_key=private_addr)
        # Send the transaction
        send_store_contact = NodeContractModel.w3.eth.send_raw_transaction(sign_store_contact.rawTransaction)
        transaction_receipt = NodeContractModel.w3.eth.wait_for_transaction_receipt(send_store_contact)

        status = transaction_receipt["status"]
        #generate a list of tuples
        print("Gas",transaction_receipt["gasUsed"] )
        print("Shares requested:", status)
        return status
     
#request vault hash by the third party 
    def requestVaultHash(owner_addr,private_addr,user_name,generated_signed_otp,entered_signed_otp,nodeContractAddressLocal):
        #signed msg
        def to_32byte_hex(val):
            return Web3.toHex(Web3.toBytes(val).rjust(32, b'\0'))
        generated_msg_hash=Web3.toHex(generated_signed_otp.messageHash)
        entered_msg_hash=Web3.toHex(entered_signed_otp.messageHash)
        v, r, s = generated_signed_otp.v, to_32byte_hex(generated_signed_otp.r), to_32byte_hex(generated_signed_otp.s)
        c= NodeContractModel.connection(GlobalState.NODE_CONTRACT_ABI,nodeContractAddressLocal,owner_addr,private_addr)
        print(owner_addr,"Requesting and getting vault hash  ",nodeContractAddressLocal)
        nonce = NodeContractModel.w3.eth.getTransactionCount(owner_addr)
        vaultHash = c.caller({"from": owner_addr, "nonce": nonce}).requestVaultHashOfSecretOwner(user_name,generated_msg_hash,v, r, s,entered_msg_hash)
        #print("Gas",transaction_receipt["gasUsed"] )
        print("Vault hash  retrieved")
        print("vault hash:", vaultHash)
        return vaultHash

     #OTP section
    def sign_message(str_msg):
        message = encode_defunct(text=str_msg)
        private_key = GlobalState.PUBLIC_CONTRACT_OWNER_PRIVATE_KEY
        account = Account.privateKeyToAccount(private_key)
        # Sign the message using the account
        signed_message = NodeContractModel.w3.eth.account.sign_message(message, private_key=account.privateKey)
        return signed_message
    
#get contract address using public address 
    def getEmailByUserName(owner_addr,private_addr, nodeContractAddressLocal,userName):
        c= NodeContractModel.connection(GlobalState.NODE_CONTRACT_ABI,nodeContractAddressLocal,owner_addr,private_addr)
        print(owner_addr,"Getting an email of the given user name  ",userName)
        nonce = NodeContractModel.w3.eth.getTransactionCount(owner_addr)
        email = c.caller({"from": owner_addr, "nonce": nonce}).getEmailOfUser(userName)
        #print("Gas",transaction_receipt["gasUsed"] )
        print("Requested Email retrieved")
        print("Email", email)
        return email
