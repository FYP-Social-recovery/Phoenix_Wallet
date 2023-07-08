import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:pheonix_wallet_app/src/controllers/wallet_controller.dart';
import 'package:web3dart/web3dart.dart';

class PublicService {
  String PUBLIC_CONTRACT_ABI =
      '{"contractName": "PublicContract","abi":[ { "inputs": [], "stateMutability": "nonpayable", "type": "constructor" }, { "inputs": [ { "internalType": "address", "name": "holderAddress", "type": "address" } ], "name": "checkRequestsByShareholder", "outputs": [ { "internalType": "address[]", "name": "", "type": "address[]" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address[]", "name": "secretOwners", "type": "address[]" } ], "name": "checkRequestsForTheSeceret", "outputs": [ { "internalType": "address[]", "name": "", "type": "address[]" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "requseterAddress", "type": "address" }, { "internalType": "address", "name": "secretOwnerAddress", "type": "address" } ], "name": "deleteShareRequest", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "string", "name": "name", "type": "string" } ], "name": "getContractAddressByName", "outputs": [ { "components": [ { "internalType": "address", "name": "publicAddress", "type": "address" }, { "internalType": "address", "name": "contractAddress", "type": "address" } ], "internalType": "struct PublicContract.SampleNode", "name": "", "type": "tuple" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "publicAddress", "type": "address" } ], "name": "getContractAddressByPublicAddress", "outputs": [ { "internalType": "address", "name": "", "type": "address" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "string", "name": "name", "type": "string" } ], "name": "getEmailAddressByUserName", "outputs": [ { "internalType": "string", "name": "", "type": "string" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "secretOwner", "type": "address" } ], "name": "getRequestAcceptedHoldersList", "outputs": [ { "internalType": "address[]", "name": "", "type": "address[]" } ], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "secretOwner", "type": "address" } ], "name": "getRequestRejectedHoldersList", "outputs": [ { "internalType": "address[]", "name": "", "type": "address[]" } ], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "ownerAddress", "type": "address" } ], "name": "getSecretHolderAddressesCountInAcceptedHoldersList", "outputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "ownerAddress", "type": "address" } ], "name": "getSecretHolderAddressesCountInRejectedHoldersList", "outputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "holderAddress", "type": "address" } ], "name": "getSecretOwnerAddressesCountInHolderRequests", "outputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address[]", "name": "secretOwners", "type": "address[]" } ], "name": "getSecretOwnerAddressesCountInSecretRequests", "outputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "string", "name": "name", "type": "string" } ], "name": "isExists", "outputs": [ { "internalType": "bool", "name": "", "type": "bool" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "secretOwner", "type": "address" }, { "internalType": "address", "name": "holder", "type": "address" } ], "name": "makeARequestToBeAShareHolder", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "string", "name": "name", "type": "string" }, { "internalType": "address", "name": "requesterAddress", "type": "address" }, { "internalType": "bytes32", "name": "msgh1", "type": "bytes32" }, { "internalType": "uint8", "name": "v", "type": "uint8" }, { "internalType": "bytes32", "name": "r", "type": "bytes32" }, { "internalType": "bytes32", "name": "s", "type": "bytes32" }, { "internalType": "bytes32", "name": "msgh2", "type": "bytes32" } ], "name": "makeARequestToGetShares", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "string", "name": "name", "type": "string" }, { "internalType": "bytes32", "name": "msgh1", "type": "bytes32" }, { "internalType": "uint8", "name": "v", "type": "uint8" }, { "internalType": "bytes32", "name": "r", "type": "bytes32" }, { "internalType": "bytes32", "name": "s", "type": "bytes32" }, { "internalType": "bytes32", "name": "msgh2", "type": "bytes32" } ], "name": "makeARequestToGetVaultHash", "outputs": [ { "internalType": "string", "name": "", "type": "string" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "secretOwner", "type": "address" }, { "internalType": "address", "name": "holder", "type": "address" }, { "internalType": "string", "name": "sharedString", "type": "string" } ], "name": "makeSharesAccessibleToTheHolders", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "string", "name": "name", "type": "string" }, { "internalType": "address", "name": "publicAddress", "type": "address" }, { "internalType": "address", "name": "myContractAddress", "type": "address" } ], "name": "register", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "secretOwner", "type": "address" }, { "internalType": "string", "name": "sharedString", "type": "string" } ], "name": "releaseTheSecret", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "uint256", "name": "index", "type": "uint256" } ], "name": "removeFromHolderRequestList", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "shareHolder", "type": "address" }, { "internalType": "address", "name": "secretOwner", "type": "address" }, { "internalType": "bool", "name": "acceptance", "type": "bool" } ], "name": "respondToBeShareHolder", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "secretOwner", "type": "address" }, { "internalType": "address", "name": "shareHolder", "type": "address" } ], "name": "updateOwnersAcceptedToReleaseList", "outputs": [], "stateMutability": "nonpayable", "type": "function" } ]}';

  late String _abiCode;

  late Web3Client _web3Client;

  late EthereumAddress _contractAddress;
  late DeployedContract _contract;

  String privateKey =
      "58d0efedba9a8a61b2ac3f188dd079782e07aed904cdbc0e3340e073e85c7655";
  String publicKey = "0x20543FD8D854d500121215Abc542531987f6bc2e";

  String contractAddress = "0x662b6FF14318e6d967A9eD9EaD45cac322756f8b";

  initMethod() async {
    WalletController walletController = Get.find();
    var rpcURL = walletController.rpcUrl.value;

    var httpClient = Client();
    _web3Client = Web3Client(rpcURL, httpClient);

    await getAbi();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile = PUBLIC_CONTRACT_ABI;

    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi['abi']);

    _contractAddress = EthereumAddress.fromHex(contractAddress);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "PublicContract"), _contractAddress);
    // await Future.delayed(Duration(seconds: 2));
  }

  // state changing function
  Future<String> callFunction(String funcname, List<dynamic> args) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);

    DeployedContract contract = _contract;
    final ethFunction = contract.function(funcname);
    final result = await _web3Client.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: contract,
          function: ethFunction,
          parameters: args,
        ),
        chainId: null,
        fetchChainIdFromNetworkId: true);
    return result;
  }

  //non state change function
  Future<List<dynamic>> ask(String funcName, List<dynamic> args) async {
    final contract = _contract;
    final ethFunction = contract.function(funcName);
    final result = _web3Client.call(
        sender: EthereumAddress.fromHex(publicKey),
        contract: contract,
        function: ethFunction,
        params: args);
    return result;
  }
}
