import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
//import 'package:flutter_js/flutter_js.dart';
import 'package:http/http.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';
import 'package:pheonix_wallet_app/src/controllers/wallet_controller.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class NodeService {
  String NODE_CONTRACT_ABI =
      '{"contractName": "NodeContract","abi":[ { "inputs": [ { "internalType": "address", "name": "defaultPublicContractAddress", "type": "address" } ], "stateMutability": "nonpayable", "type": "constructor" }, { "inputs": [ { "internalType": "address", "name": "secretOwner", "type": "address" } ], "name": "acceptInvitation", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "string[]", "name": "myShares", "type": "string[]" } ], "name": "addMyShares", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "address payable", "name": "shareHolder", "type": "address" } ], "name": "addTemporaryShareHolders", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "checkAcceptance", "outputs": [ { "internalType": "bool", "name": "", "type": "bool" } ], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "checkRequestsForBeAHolder", "outputs": [ { "internalType": "address[]", "name": "", "type": "address[]" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "checkRequestsForShare", "outputs": [ { "internalType": "address[]", "name": "", "type": "address[]" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "cleanReleaseAcceptedShareHolders", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "string", "name": "tempOtp", "type": "string" } ], "name": "compareOtpHash", "outputs": [ { "internalType": "bool", "name": "", "type": "bool" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "secretOwnerAddress", "type": "address" } ], "name": "deleteSecretOwnerFromList", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "string", "name": "email", "type": "string" }, { "internalType": "string", "name": "vault", "type": "string" } ], "name": "distribute", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "publicAddress", "type": "address" } ], "name": "getContractAddressOfPublicAddress", "outputs": [ { "internalType": "address", "name": "", "type": "address" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "getEmailAddress", "outputs": [ { "internalType": "string", "name": "", "type": "string" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "string", "name": "name", "type": "string" } ], "name": "getEmailOfUser", "outputs": [ { "internalType": "string", "name": "", "type": "string" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "getMyShares", "outputs": [ { "internalType": "string[]", "name": "", "type": "string[]" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "getMyState", "outputs": [ { "internalType": "string", "name": "", "type": "string" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "getOtp", "outputs": [ { "internalType": "string", "name": "", "type": "string" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "getRejectedShareHolders", "outputs": [ { "internalType": "address[]", "name": "", "type": "address[]" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "getRequestedShareHolders", "outputs": [ { "internalType": "address[]", "name": "", "type": "address[]" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "getShareHolders", "outputs": [ { "internalType": "address[]", "name": "", "type": "address[]" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "getUserName", "outputs": [ { "internalType": "string", "name": "", "type": "string" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "isRegistered", "outputs": [ { "internalType": "bool", "name": "", "type": "bool" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "string", "name": "tempUserName", "type": "string" } ], "name": "isUserNameExist", "outputs": [ { "internalType": "bool", "name": "", "type": "bool" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "makingHolderRequests", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "myState", "outputs": [ { "internalType": "string", "name": "", "type": "string" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "refreshHolderLists", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "refreshState", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "regenerate", "outputs": [ { "internalType": "string[]", "name": "", "type": "string[]" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "string", "name": "name", "type": "string" } ], "name": "registerToPublicContract", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "secretOwner", "type": "address" } ], "name": "rejectInvitation", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "secretOwnerAddress", "type": "address" } ], "name": "releaseSecret", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "uint256", "name": "index", "type": "uint256" } ], "name": "remove", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "address payable", "name": "shareHolder", "type": "address" } ], "name": "removeShareHolders", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "string", "name": "name", "type": "string" }, { "internalType": "bytes32", "name": "msgh1", "type": "bytes32" }, { "internalType": "uint8", "name": "v", "type": "uint8" }, { "internalType": "bytes32", "name": "r", "type": "bytes32" }, { "internalType": "bytes32", "name": "s", "type": "bytes32" }, { "internalType": "bytes32", "name": "msgh2", "type": "bytes32" } ], "name": "requestSharesFromHolders", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "string", "name": "name", "type": "string" }, { "internalType": "bytes32", "name": "msgh1", "type": "bytes32" }, { "internalType": "uint8", "name": "v", "type": "uint8" }, { "internalType": "bytes32", "name": "r", "type": "bytes32" }, { "internalType": "bytes32", "name": "s", "type": "bytes32" }, { "internalType": "bytes32", "name": "msgh2", "type": "bytes32" } ], "name": "requestVaultHashOfSecretOwner", "outputs": [ { "internalType": "string", "name": "", "type": "string" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "returnMyVaultHash", "outputs": [ { "internalType": "string", "name": "", "type": "string" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "string", "name": "share", "type": "string" } ], "name": "saveToRegeneratedShares", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "shareHolder", "type": "address" } ], "name": "saveToReleaseAcceptedShareHolders", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "string", "name": "email", "type": "string" } ], "name": "setEmail", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "string", "name": "vault", "type": "string" } ], "name": "setEncryptedVault", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "requestingParty", "type": "address" } ], "name": "setRequester", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "ownerAddress", "type": "address" }, { "internalType": "string", "name": "sharedString", "type": "string" } ], "name": "takeTheSecretFromTheOwner", "outputs": [], "stateMutability": "nonpayable", "type": "function" } ]}';

  late String _abiCode;
  late Web3Client _web3Client;
  late EthereumAddress _contractAddress;
  late DeployedContract _contract;

  initMethod() async {
    WalletController walletController = Get.find();
    var rpcURL = walletController.rpcUrl.value;

    var httpClient = Client();
    _web3Client = Web3Client(rpcURL, httpClient);

    await getAbi();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile = NODE_CONTRACT_ABI;

    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi['abi']);

    _contractAddress = EthereumAddress.fromHex(
        "0xdBe31A0F6d5Aac9F4CF88FcCf9F04C1Cc88dBE53"); //walletController.nodeContractAddress.value
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Node"), _contractAddress);
    // await Future.delayed(Duration(seconds: 2));
  }

  // state changing function
  Future<String> callFunction(
      String funcname, List<dynamic> args, String privateKey) async {
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
    AuthController authController = Get.find();
    final contract = _contract;
    final ethFunction = contract.function(funcName);
    final result = _web3Client.call(
        sender: EthereumAddress.fromHex(authController.publicKey.value),
        contract: contract,
        function: ethFunction,
        params: args);
    return result;
  }

  //function calling in node service
  Future<String> getUserName() async {
    var result = await ask("getUserName", []);
    print(result);
    return result[0];
  }

  Future<void> addTempShareHolder(String shareHolder, String privateKey) async {
    var res = await callFunction("addTemporaryShareHolders",
        [EthereumAddress.fromHex(shareHolder)], privateKey);
    print(res);
  }

  Future<void> setEmail(String email, String privateKey) async {
    var res = await callFunction("setEmail", [email], privateKey);
    print(res);
  }
}
