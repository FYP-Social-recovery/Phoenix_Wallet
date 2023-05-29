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
