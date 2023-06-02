from model.nodeModel import NodeContractModel


# nodeObject =nodeModel.NodeContractModel()
publicKey="0x20543FD8D854d500121215Abc542531987f6bc2e"
privateKey="58d0efedba9a8a61b2ac3f188dd079782e07aed904cdbc0e3340e073e85c7655"

class NodeContractController:
    def deploy(publicKeyLocal, privateKeyLocal):
        contractAddress=NodeContractModel.deploy(publicAddress=publicKeyLocal,privateAddress=privateKeyLocal)
        return contractAddress

    def requestShares(publicKeyLocal, privateKeyLocal, nodeContractAddressLocal, userName,generated_signed_otp,entered_signed_otp):
        status =NodeContractModel.requestShares(owner_addr=publicKeyLocal,private_addr=privateKeyLocal,user_name=userName,generated_signed_otp=generated_signed_otp, entered_signed_otp=entered_signed_otp,nodeContractAddressLocal=nodeContractAddressLocal)
        return status
        
    def getVaultHash(publicKeyLocal, privateKeyLocal, nodeContractAddressLocal,userName,generated_signed_otp,entered_signed_otp):
        vaultHash =NodeContractModel.requestVaultHash(owner_addr=publicKey,private_addr=privateKeyLocal,user_name=userName,generated_signed_otp=generated_signed_otp, entered_signed_otp=entered_signed_otp, nodeContractAddressLocal=nodeContractAddressLocal)
        return vaultHash