from model.nodeModel import NodeContractModel


# nodeObject =nodeModel.NodeContractModel()
publicKey="0x20543FD8D854d500121215Abc542531987f6bc2e"
privateKey="58d0efedba9a8a61b2ac3f188dd079782e07aed904cdbc0e3340e073e85c7655"

class NodeContractController:
    def deploy(publicKeyLocal, privateKeyLocal):
        contractAddress=NodeContractModel.deploy(publicAddress=publicKeyLocal,privateAddress=privateKeyLocal)
        return contractAddress

    